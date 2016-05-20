//lbo note singleton
var lboNote = (function () {
    var instance;
    return {
        getInstance: function () {
            if (!instance) {
                instance = new csGenericLbo();
            }
            return instance;
        }
    };
})();

$(document).ready(function () {
    var row_index = popUp.row_index,
        row_count = popUp.row_count,
        ids= popUp.ids;

    if (popUp.mode == "ADD") {
        $("#spnHeading").text(res_titleEdit);
        $("#btnPrev, #btnNext").attr("disabled", true);
        $("#copy_to_clipboard").hide();

        if (popUp.is_team_assistant == true)
            $(".evidenzia_nota").show();
    }
    else{ //EDIT

        $("#spnHeading").text(res_titleAdd);
        
        var nota = getNota(popUp.current_note);

        displayCurrentNota(nota);
        togglePrevAndNext(row_index, row_count);

        var prevNextHandler = function(e){

            var prevPressed;
            if (e.type == 'click')
                prevPressed = $(this).attr("id") == "btnPrev";
            else //keydown
                prevPressed = e.keyCode == 33; //ch(33) = page-down, ch(34) = page-up. 

            if (prevPressed){
                if(row_index > 0)
                    row_index--;
            }else{
                if (row_index < row_count-1)
                row_index++;
            }
            var id_nota = ids[row_index].split(';')[0];
            
            if (id_nota !== undefined) {
                var sigla_ins = ids[row_index].split(';')[1];
                var sigla_agg = ids[row_index].split(';')[2];
                var in_evidenza = ids[row_index].split(';')[3];
                var nota = getNota(id_nota, sigla_ins, sigla_agg, in_evidenza);

                updatePopupArgs(nota);
                displayCurrentNota(nota);
            }
            togglePrevAndNext(row_index, row_count);
        }

        $("#btnPrev, #btnNext").click(prevNextHandler);
        $(document).keydown(function (e){
            if (e.keyCode == 33 || e.keyCode == 34)
                prevNextHandler(e);
        });
    }

    //Copia nota negli appunti sse contiene elementi html.
    $("#btn_copytoclipboard").click(function (e) {
        var
          target = e.target,
          c = $(target).attr('data-copytarget'),
          text = $(c).html();

        if (window.clipboardData && clipboardData.setData) {
            clipboardData.setData("Text", text);
        }
    });

});

//#region A.G. - RU Medical 2.0 - 554905 - Note as Html
function showNotaAsHtml() {
    $("#btnModifica").click(function () {
        $("#notaHtml").hide();
        $("#txaCommentText").show();

        $("#btnModifica").hide();
        $("#btnSaveClose").show();
    });
    showAsHtmlIf(!"#txaCommentText".isNullOrEmpty() && "#txaCommentText".containsHTMLElement());
}

function showAsHtmlIf(condition) {
    /*A.G. Uncomment to apply the change to sanitary doxs only.
    var popUp = window.dialogArguments;
    if (!popUp.isSanitario)
        return;*/
    if(condition)
        document.getElementById("notaHtml").innerHTML = "#txaCommentText".toHTML();
    $("#notaHtml").toggle(condition);
    $("#txaCommentText").toggle(!condition);
    $("#btnModifica").toggle(condition);
    $("#btnSaveClose").toggle(!condition);
    $("#copy_to_clipboard").toggle(condition);
}
//#endregion A.G. - RU Medical 2.0 - 554905 - Note as Html

function displayCurrentNota(nota) {
    txaCommentText.value = nota.testo;
    
    var displayEvidenza = popUp.current_user.toLowerCase() == nota.insert_by.toLowerCase() && popUp.is_team_assistant && nota.in_evidenza == 'false';
    $(".evidenzia_nota").toggle(displayEvidenza);

    //Necessary to display the "no changes" warning on save.
    txaCommentText.origvalue = nota.testo;
    txtDescription.origvalue = nota.description;

    txtDescription.value = id_dox;
    var nota_info = "Inserito : " + nota.sigla_ins + " @" + jsConvertGMTUniversalToLocal(nota.data_ins, true) + " - " + "Aggiornato : " + nota.sigla_agg + " @" + jsConvertGMTUniversalToLocal(nota.data_agg, true);
    //workaround to override the pre-existing onyx-oriented label setting.
    setTimeout(function () { $("#labelLogMark").text(nota_info); }, 10);
    showNotaAsHtml();
}

function getNota(id,sigla_ins,sigla_agg,in_evidenza) {
    var lbo = lboNote.getInstance();
    lbo.executeOtm("note", "retrieve", "<parameters><note><primaryId>" + id + "</primaryId></note></parameters>");
    return {
        "id"          : lbo.getValue("//parametersReturn/note/primaryId"),
        "testo"       : lbo.getValue("//parametersReturn/note/text"),
        "data_ins"    : lbo.getValue("//parametersReturn/note/insertDate"),
        "data_agg"    : lbo.getValue("//parametersReturn/note/updateDate"),
        "insert_by"   : lbo.getValue("//parametersReturn/note/insertBy"),
        "sigla_ins"   : sigla_ins == undefined ? popUp.sigla_ins : sigla_ins, //sigla ins not defined => 
        "sigla_agg"   : sigla_agg == undefined? popUp.sigla_agg : sigla_agg,
        "owner_id"    : lbo.getValue("//parametersReturn/note/ownerId"),
        "owner_type"  : lbo.getValue("//parametersReturn/note/ownerType"),
        "secondary_id": lbo.getValue("//parametersReturn/note/secondaryId"),
        "description" : lbo.getValue("//parametersReturn/note/description"),
        "in_evidenza" : in_evidenza == undefined ? popUp.nota_gia_in_evidenza : in_evidenza
    };
}

//Mandatory params update for vbCommentSave in order to don't save the initial note after a SUCC or PRESS button press
function updatePopupArgs(nota) {
    msCommentId = nota.id;
    msSiglaIns = nota.sigla_ins;
    mdtInsertDate = nota.data_ins;
    msSiglaUpd = nota.sigla_agg;
    mdtUpdateDate = nota.data_agg;

    msOwnerId = nota.owner_id;
    msOwnerType = nota.owner_type;
    mstrInsertBy = nota.insert_by;
    msOnyxTimeStamp = nota.data_agg;
    secondaryId = nota.secondary_id;
    insertion_user = nota.insert_by;
}

//Disabling button PREV and NEXT when the user is browsing the 1st and the last note.
function togglePrevAndNext(row_index, row_count)
{
    //A 50 ms delayed callback to prioritize this code and not the former onyx logic. It sucks, but it works.
    setTimeout(function () {
        $("#btnPrev").attr('disabled', row_index == 0);
        $("#btnNext").attr('disabled', row_index == row_count - 1);
    }, 50);
}