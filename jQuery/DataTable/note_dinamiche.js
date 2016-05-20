$(document).ready(function () {
    //#region Global vars
    var team = function () {
        if (localStorage.getItem('supervisors') === null && localStorage.getItem('assistants') === null)
        {
            var lbo = new cJsRole();
            localStorage.setItem('supervisors', lbo.retrieveCommaSeparatedUserIds("NCO.RESPONSABILI/TL", 1));
            localStorage.setItem('assistants', lbo.retrieveCommaSeparatedUserIds("NCO.RESPONSABILI/DTL", 1));
        } 
        return {
            "supervisors": localStorage.getItem("supervisors") || "",
            "assistants": localStorage.getItem("assistants") || ""
        }
    }();

    var popup_features = 'status:no;help:no;dialogWidth:800px;dialogHeight:650px;',
        id_dox = "id_dox".getQueryStringParameterValue(),
        isSanitario = "isSanitario".getQueryStringParameterValue(),
        id_denuncia = "id_denuncia".getQueryStringParameterValue(),
        workticket_id = "workticketId".getQueryStringParameterValue(),
        search_keyword = "search_keyword".getQueryStringParameterValue(),
        current_user = "current_user".getQueryStringParameterValue(),
        is_team_assistant = team.assistants.indexOf(current_user) > -1,
        childWin;

    var html_table = "";
    //#endregion Global vars
    $("<div></div>").dialog({
        show: {
            effect: 'blind',
            complete: function () {
                //#region Note List - Showing
                var h = getWindowHeight(80);
                $('#note_div').css('max-height', h);
                $('#note_div').css('height', h);

                $("#note_cmd").show();
                $("#note_div").show();
                $("#dialog-message").hide();
                //#endregion Note List - Showing

                //#region jQueryTable instance and config
                var oTable = $('#tbl_note_dinamiche').dataTable({
                    "searching": true,
                    "bAutoWidth": false,
                    "aoColumns":
                    [
                        { "targets": 0, "visible": "false", "searchable": "false" },
                        { "targets": 1, "visible": "false", "searchable": "false" },
                        { "targets": 2, "visible": "false", "searchable": "false" },
                        { "targets": 3, "sWidth": "13%", "iDataSort": 8 },   //data ins  - it_IT, when sorted, actually sort by col. 8 (data_ins - en_GB)
                        { "targets": 4, "sWidth": "9%" },  //sigla ins
                        { "targets": 5, "sWidth": "13%", "iDataSort": 9 },   //data agg  - it_IT, when sorted, actually sort by col. 9 (data_agg - en_GB)
                        { "targets": 6, "sWidth": "9%" },  //sigla agg
                        { "targets": 7, "sWidth": "50%" },  //testo
                        { "targets": 8, "visible": "false", "searchable": "false" }, //data_ins - en_GB - richiesto da onyx per non far fallire l'update di una nota selezionata
                        { "targets": 9, "visible": "false", "searchable": "false" }, //data_agg - en_GB - idem
                        { "targets": 10, "sWidth": "2%", "searchable": "false", "orderable": "false" },   //Zoom
                        { "targets": 11, "sWidth": "2%", "searchable": "false", "orderable": "false" }, //Copy to clipboard
                        { "targets": 12, "sWidth": "2%", "searchable": "false", "orderable": "false" }  //Open PF attachment
                    ],
                    "oLanguage": { "sSearch": "<span>&#8195;&#8195;</span>" },
                    "aaSorting": [[3, "asc"]],  //Sorting by data_ins en_GB descending.
                    "iDisplayLength": 25,       //Default page size
                    "sDom": '<"top"<"actions">lfpi<"clear">><"clear">rt<"bottom">',
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "bDeferRender": true,
                    "responsive": true
                });

                if (search_keyword != "")
                    oTable.fnFilter(search_keyword);

                adjustTblNoteHeader(oTable);

                $(window).resize(function () {
                    adjustTblNoteHeader(oTable);
                });

                oTable.$('td').hover(function () {
                    var tooltipText = $(this).find("span");
                    tooltipText.toggleClass("noTooltip");
                    tooltipText.toggleClass("hasTooltip");
                });

                //zoom event handler
                oTable.$('td:eq(10)').find('a').click(function () {
                        var td = $(this).parent();
                        var id = td.parent().attr('id');
                        var testo_nota = getTestoNota(id);
                        $("#dettaglio_nota").text(testo_nota);
                        popUpWindow("#dettaglio_nota".toHTML('Testo Nota'));
                });

                //copy to clipboard event handler
                oTable.$('td:eq(11)').find('a').click(function () {
                    if (window.clipboardData && clipboardData.setData) {
                        var td = $(this).parent();
                        var id = td.parent().attr('id');
                        var testo_nota = getTestoNota(id);
                        clipboardData.setData("Text", testo_nota);
                      }
                });

                //#endregion jQueryTable instance and config

                //#region Add Note
                $("#add_note").click(function () {
                    //Note popup already open
                    if (typeof (childWin) != 'undefined' && !childWin.closed)
                        return;

                    var timestamp = getCurrentDatetime(),
                    popUp = {
                        "row_index": null,
                        "row_count": oTable.fnGetData().length,
                        "mode": "ADD",
                        "current_note": 0,
                        "owner_type": 10,
                        "owner_id": workticket_id,
                        "secondary_id": 8888,
                        "data_ins": timestamp,
                        "sigla_ins": current_user,
                        "data_agg": timestamp,
                        "sigla_agg": current_user,
                        "id_dox": id_dox,
                        "isSanitario": isSanitario,
                        "is_team_assistant": is_team_assistant
                    };

                    childWin = showModelessDialog("..\\comments\\popup_nota.asp", popUp, popup_features);

                    $(childWin).unload(function (e) {
                        //TODO: Nice to have - avoid redirecting when the user closes the pop-up without saving or updating the note.
                        search_keyword = oTable.fnSettings().oPreviousSearch.sSearch;
                        window.location.href = "note_dinamiche.asp?id_denuncia=" + id_denuncia + "&id_dox=" + id_dox + "&isSanitario=" + isSanitario + "&workticketId=" + workticket_id + "&current_user=" + current_user + "&search_keyword=" + search_keyword;
                    });
                });
                //#endregion Add Note

                //#region View/edit notes in sequence.
                $("#browse_notes").click(function () {
                    //Note popup already open
                    if (typeof (childWin) != 'undefined' && !childWin.closed)
                        return;
                    
                    var oSettings = oTable.fnSettings(),
                        page_size = oSettings._iDisplayLength,
                        page_index = Math.ceil(oSettings._iDisplayStart / page_size),
                        first_selected_note_id = oTable._('tr', { "filter": "applied" })[page_size * page_index][0],
                        row_index = oTable.fnGetPosition($("#tbl_note_dinamiche tr td:contains('" + first_selected_note_id + "')")[0])[0];

                    var popUp = getPopupArgsBySelectedRow(oTable, row_index, id_dox, isSanitario, is_team_assistant, current_user);
                    childWin = showModelessDialog("..\\comments\\popup_nota.asp", popUp, popup_features);

                    $(childWin).unload(function (e) {
                        search_keyword = oTable.fnSettings().oPreviousSearch.sSearch;
                        window.location.href = "note_dinamiche.asp?id_denuncia=" + id_denuncia + "&id_dox=" + id_dox + "&isSanitario=" + isSanitario + "&workticketId=" + workticket_id + "&current_user=" + current_user + "&search_keyword=" + search_keyword;
                    });
                });
                //#endregion View/edit notes in sequence.

                //#region Double click on selected note
                oTable.$('tr').dblclick(function () {
                    //Note popup already open
                    if (typeof (childWin) != 'undefined' && !childWin.closed)
                        return;
                    var popUp = getPopupArgsBySelectedRow(oTable, oTable.fnGetPosition(this), id_dox, isSanitario, is_team_assistant, current_user);

                    childWin = showModelessDialog("..\\comments\\popup_nota.asp", popUp, popup_features);
                    $(childWin).unload(function (e) {
                        search_keyword = oTable.fnSettings().oPreviousSearch.sSearch;
                        window.location.href = "note_dinamiche.asp?id_denuncia=" + id_denuncia + "&id_dox=" + id_dox + "&isSanitario=" + isSanitario + "&workticketId=" + workticket_id + "&current_user=" + current_user + "&search_keyword=" + search_keyword;
                    });
                });
                //#endregion Double click on selected note
            }
        },
        open: function (event, ui) {
            //#region Note list - Retrieving + rendering as HTML table
            html_table = getNoteDinamicheAsHTMLTable(id_denuncia, team.supervisors);
            $("#note_div").append(html_table);
            //updating data_ins (=td:eq(3)) and data_agg (=td:eq(5)) to the italian timezone
            $("#tbl_note_dinamiche tbody tr").find("td:eq(3), td:eq(5)")
            .each(function () {
                var gmt_datetime = $(this).text();
                $(this).html(jsConvertGMTUniversalToLocal(gmt_datetime, true));
            });
            //finds the process frame link (if any, according to its table position) and writes the image link in the last column.   
            $("#tbl_note_dinamiche tbody tr").find("td:last").each(function () {
                var imgLink = $(this).text().getImageLinkHtml();
                $(this).html(imgLink);
            });
            //#endregion Note list - Retrieving + rendering as HTML table
        },
        modal: false,
        draggable: false,
        resizable: false,
        position: ['center', 'top'],
        hide: 'blind',
        width: 400,
        dialogClass: 'ui-dialog-osx'
    });

});

function getNoteDinamicheAsHTMLTable(id_denuncia, supervisors)
{
    var lboNote = new csGenericLbo();
    lboNote.executeOtm("note", "retrieveListByOwnerAndType", "<parameters><ownerId>" + id_denuncia + "</ownerId><ownerType>6</ownerType><noteType>8888</noteType><isNotaPerOperativo></isNotaPerOperativo></parameters>");

    var html_table = "";
    var xml = new ActiveXObject("Msxml2.DOMDocument.3.0");
    xml.async = false;
    xml.loadXML(lboNote.getXml());

    if (xml.parseError.errorCode != 0) {
        var myErr = source.parseError;
        alert("Parsing error: " + myErr.reason);
    } else {
        //Append team supervisors to root element
        var root = xml.documentElement;
        var teamsupvsElement = xml.createElement('teamsupervisors');
        teamsupvsElement.text = supervisors;
        xml.getElementsByTagName('customData')[0].appendChild(teamsupvsElement);
        //Load style sheet.
        var stylesheet = new ActiveXObject("Msxml2.DOMDocument.3.0");
        stylesheet.async = false
        stylesheet.load("note_dinamiche_template.xsl");
        if (stylesheet.parseError.errorCode != 0) {
            var myErr = stylesheet.parseError;
            alert("Parsing error: " + myErr.reason);
        } else {
            html_table = xml.transformNode(stylesheet);
        }
    }
    return html_table;
}

function getPopupArgsBySelectedRow(oTable, row_index, id_dox, isSanitario, is_team_assistant, current_user) {
    //TODO Nicetohave: data_ins and data_agg should be reverted to gmt timezone with the original format.
    var row = oTable.fnGetData(row_index),
        note_id     = row[0],
        owner_id    = row[1],
        insert_by   = row[2],
        data_ins    = row[8],  // = jsConvertLocalToGMT(row[3],true),
        sigla_ins   = row[4].substring(0, row[4].indexOf("<SPAN")),
        data_agg    = row[9], // = jsConvertLocalToGMT(row[5], true),
        sigla_agg   = row[4].substring(0, row[4].indexOf("<SPAN")),
        row_count = oTable._('tr', { "filter": "applied" }).length,
        in_evidenza = oTable.fnGetNodes()[row_index].outerHTML.indexOf("evidenzia_team") > -1,
        ids         = oTable._('td:eq(0)', { "filter": "applied" });

    //TODO: This should be jquery-datatable native somewhere...
    var filtered_index;
    for(var i in ids){
        if (note_id == ids[i]) {
            filtered_index = i;
            break;
        }
    }

    //ids sarà una stringa nel seguente formato: id_nota(guid);sigla_ins;sigla_upd;flag_evidenza
    for (var i in ids) {
        var id_selector = "#"+ids[i];

        var ins_user_html = oTable.$(id_selector).find('td:eq(4)')[0].innerHTML;
        var upd_user_html = oTable.$(id_selector).find('td:eq(6)')[0].innerHTML;
        
        var ins_user_sigla  = ins_user_html.substring(0, ins_user_html.indexOf("<SPAN"));
        var upd_user_sigla  = upd_user_html.substring(0, upd_user_html.indexOf("<SPAN"));

        var flag_evidenza = oTable.$(id_selector).is('.evidenzia_team_assistant, .evidenzia_team_supervisor');

        ids[i] = ids[i] + ";" + ins_user_sigla + ";" + upd_user_sigla + ';' + flag_evidenza;
    }

    return {
        "row_index": filtered_index,
        "row_count": row_count,
        "ids": ids,
        "mode": "EDIT",
        "current_note": note_id,
        "owner_id": owner_id,
        "insert_by": insert_by,
        "owner_type": 10,
        "data_ins": data_ins,
        "sigla_ins": sigla_ins,
        "data_agg": data_agg,
        "sigla_agg": sigla_agg,
        "id_dox": id_dox,
        "isSanitario": isSanitario,
        "is_team_assistant": is_team_assistant,
        "nota_gia_in_evidenza": in_evidenza.toString(),
        "current_user": current_user
    }
}

//#region Utilities
function adjustTblNoteHeader(oTable) {
    setTimeout(function () {
        oTable.fnAdjustColumnSizing();
        oTable.fnSettings().sScrollY = getWindowHeight(80);
    }, 10);
}

function getWindowHeight(percentage) {

    if (typeof percentage === undefined)
        percentage = 100;

    var w = window,
    d = document,
    e = d.documentElement,
    g = d.getElementsByTagName('body')[0],
    ret = (w.innerHeight || e.clientHeight || g.clientHeight) * (percentage / 100);
    return Math.ceil(ret);
}

function getTestoNota(id) {
    var lbo = new csGenericLbo();
    lbo.executeOtm("note", "retrieve", "<parameters><note><primaryId>" + id + "</primaryId></note></parameters>");
    return lbo.getValue("//parametersReturn/note/text");
}

function popUpWindow(html) {
    var popupWin = window.open("", 'subWind', "resizable=1,toolbar=0,status=0,menubar=0,scrollbars=1,location=1,titlebar=1,top=10,left=15,width=800px,height=650px");
    popupWin.document.write(html);
    popupWin.document.close();
}

//#endregion Utilities

$(window).unload(function () {
    var searching_value = $("#tbl_note_dinamiche_filter input")[0].value || "";
    localStorage.setItem("search_keyword", searching_value);
});