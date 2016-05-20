<!--Ex comment_edit.htm -->
<!DOCTYPE html>
<!-- #INCLUDE FILE="../common/include/HTTPHeaders.asp" -->
<!-- #INCLUDE FILE="../common/include/otm_helper.asp" -->
<!-- #INCLUDE FILE="../common/include/otm_common.asp" -->
<!-- #INCLUDE FILE="../common/include/CSPathtoRoot.asp" -->
<!-- #INCLUDE FILE="../common/include/images.asp" -->
<!-- #INCLUDE FILE="../common/include/combo.asp" -->
<!-- #INCLUDE FILE="../common/include/otm/otm_GetOnyxUsers.asp" -->
<!-- #INCLUDE FILE="../common/include/otm/otm_GetOnyxUser.asp" -->
<!-- #INCLUDE FILE="../application/onyxApplicationConstants.asp" -->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Nota Dinamica</title>
    
    <!-- Gobal vars, Onyx naming convention -->
    <script type="text/javascript">
        var popUp = window.dialogArguments;

        var msCommentId = popUp.current_note; //If '0' => I'm adding a new note, otherwise, current_note GUID.

        var msMode = popUp.mode;
        var msSiglaIns = popUp.sigla_ins;
        var mdtInsertDate = popUp.data_ins;
        var msSiglaUpd = popUp.sigla_agg;
        var mdtUpdateDate = popUp.data_agg;

        var msOwnerId = popUp.owner_id;
        var msOwnerType = popUp.owner_type;
        var mstrInsertBy = popUp.insert_by;
        var msOnyxTimeStamp = popUp.data_agg;
        var secondaryId = popUp.secondary_id;
        var id_dox = popUp.id_dox;
        var current_user = popUp.current_user;
        var insertion_user = popUp.insert_by;
    </script>

    <!-- comment_edit.htm includes -->
    <link rel="stylesheet" type="text/css" href="../stylesheet/default.css">
    
    <script type="text/vbscript"" src="popup_nota.vbs"></script>
    <script type="text/javascript" src="../common/javascript/cache.js"></script>
    <script type="text/javascript" src="../common/javascript/cached_data.js"></script>
    <script type="text/javascript" src="../common/javascript/alert.js"></script>
    <script type="text/javascript" src="../common/javascript/images.js"></script>
    <script type="text/javascript" src="../common/javascript/window.js"></script>
    <script type="text/javascript" src="../common/javascript/common.js"></script>
    <script type="text/javascript" src="popup_nota_onyx.js"></script> <!--Ex comment_edit.js -->
    <script type="text/javascript" src="../common/javascript/spell_check.js"></script>

    <script type="text/javascript" src="../res/javascript/alertres.js"></script>
    <script type="text/javascript" src="../res/javascript/notificationres.js"></script>
    <script type="text/javascript" src="../common/javascript/notification.js"></script>
    <script type="text/javascript" src="../res/comments/comment_edit_res.js"></script>
    <script type="text/vbscript" src="../res/common/vbscript/spell_check_Res.vbi"></script>

    <script type="text/vbscript" src="../common/vbscript/otm_common.vbi"></script>
    <script type="text/vbscript" src="../common/vbscript/otm_helper.vbi"></script>
   
    <script type="text/vbscript" src="otm_comment_delete.vbi"></script>
    <script type="text/vbscript" src="otm_comment_retrieve.vbi"></script>
    <script type="text/vbscript" src="otm_comment_save.vbi"></script>

    <script type="text/vbscript" src="../csDenuncia/otm_Eai.vbi"></script>
    <script type="text/javascript" src="../common/javascript/datetime.js"></script>
   
    <script type="text/javascript" src="../navbar/navigation_bar.js"></script>

    <script type="text/javascript" src="../jQuery/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="../common/javascript/numbers.js"></script>
    <script type="text/vbscript" src="../lbo/common/otm_connection.vbi"></script>
    <script type="text/vbscript" src="../lbo/common/otm_retrieve.vbi"></script>
    <script type="text/javascript" src="../lbo/common/error.js"></script>
    <script type="text/javascript" src="../lbo/user/user.js"></script>
    
    <!--A.G. includes -->
    <script type="text/javascript" src ="../Res/comments/comment_edit_res.js"></script>
    <script type="text/javascript" src="../csGenericLbo/csGenericLbo.js"></script>
    <script type="text/vbscript" src="../csGenericLbo/csGenericLbo.vbi"></script>
    <script type="text/javascript" src="../string_extensions.js"></script>
    <script type="text/javascript" src="../csDataTable/scripts/jquery.dataTables.js"></script>
    <script type="text/javascript" src="../csDataTable/scripts/xml2json.min.js"></script>
    <script type="text/javascript" src="../csDataTable/scripts/date.js"></script>
    <script type="text/javascript" src="popup_nota.js"></script>
    <link href="popup_nota.css" rel="stylesheet" />

</head>
   <body onload="jsOnOpen();jsInitHeartbeat(false);jsOnLoad();" onbeforeunload="jsOnBeforeUnload(current_user,insertion_user);" onunload="vbOnUnload();jsOnUnload();">
    <div id="divMainToolbar" class="headerbg">
        <table border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed;">
            <tr>
                <td align="left"><span id="spnHeading" class="clsHead1"></span></td>
                <td align="right">
                    <table>
                        <tr>
                            <td></td>
                            <td></td>
                            <td>
                                <img id="Img2" name="imgSave" src="../images/icons/iconSave0.gif"
                                     alt=""
                                     class="mouse"
                                     onClick="vbCommentSave(false)"
                                     onmousedown="jsRollover(this)"
                                     onmouseup="jsRollover(this)"
                                     onmouseover="jsRollover(this)"
                                     onmouseout="jsRollover(this)"
                                     tabindex="6" width="23" height="22"
                                     style="display:none">
                            </td>
                            <td>
                                <IMG id="imgClear" name="imgClear" src="../images/icons/iconerase0.gif"
                                     alt=""
                                     class="mouse"
                                     onClick="jsClearFields()"
                                     onmousedown="jsRollover(this)"
                                     onmouseup="jsRollover(this)"
                                     onmouseover="jsRollover(this)"
                                     onmouseout="jsRollover(this)"
                                     tabindex="4" width="23" height="22"
                                     style="visibility:hidden">
                            </td>
                            <td>
                                <div id="div_iconSpellCheck"></div>
                            </td>
                            <td>
                                <img id="imgDelete" name="imgDelete" src="../images/icons/iconDelete0.gif"
                                     alt=""
                                     class="mouse"
                                     onClick="vbCommentDelete()"
                                     onmousedown="return jsRollover(this)"
                                     onmouseup="return jsRollover(this)"
                                     onmouseover="return jsRollover(this)"
                                     onmouseout="return jsRollover(this)"
                                     tabindex="3" width="23" height="22"
                                     style="display:none">
                            </td>
                            <td>
                                <img id="ImgSaveClose" name="imgSaveClose" style="display:none;" src="../images/icons/iconSaveClose0.gif"
                                     alt=""
                                     class="mouse"
                                     onmousedown="jsRollover(this)"
                                     onmouseup="jsRollover(this)"
                                     onmouseover="jsRollover(this)"
                                     onmouseout="jsRollover(this)"
                                     tabindex="6" width="23" height="22">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div style="padding:4px">
        <div id="idCommentDiv" style="height:500px" class="">
            <table style="overflow: auto; width: 100%; height: 100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <textarea id="txaCommentText" name="txaCommentText" class="testo_nota" cols="78" rows="31" origvalue="" tabindex="2"></textarea>
                        <!-- A.G. RU Medical 2.0 - 554905 - {Tab numeri utili}.  -->
                        <div id="notaHtml" class="testo_nota_html">
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <label id="labelLogMark"></label>
        <div id="idDescriptionDiv" class="" style="display:none">
            <label FOR="txtDescription" id="lblDescription" accesskey=""></label>
            <input type="text" id="txtDescription" name="txtDescription" value="" origvalue="" style="width:100%;overflow:auto" maxlength="255" tabindex="1">
            <label FOR="txaCommentText" id="lblCommentText" accesskey=""></label>
        </div>
    </div>
    <div class="evidenzia_nota"><input id="chk_box_evidenzia_nota" type="checkbox" /><label for="checkbox_id"><script type="text/javascript">document.write(res_EvidenziaNotaInVerde);</script></label>
    </div>
    <div id="copy_to_clipboard">
        <table style="width: 100%">
            <tr>
                <td style="width: 100px">
                    <input type="button" data-copytarget="#txaCommentText" id="btn_copytoclipboard" value="Copia negli appunti" />
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table style="width:100%">
            <tr>
                <td style="width:100px">
                    <input id="btnPrev" name="btnPrev" type="button" value="PRECEDENTE"  class="clsButton"/>
                </td>
                <td>
                    <input id="btnNext" name="btnNext" value="SUCCESSIVA" type="button"  class="clsButton"/>
                </td>
                <td align=right>
                    <input id="btnSaveClose" name="btnSaveClose" value="SALVA E CHIUDI" type="button"  class="clsButton" />
                    <!-- A.G. RU Medical 2.0 - 554905 - {Tab numeri utili}.  -->
                    <input value="MODIFICA" type=button id="btnModifica" name="btnModifica" class="clsButton" style="display:none" />
                </td>
            </tr>
        </table>
    </div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#btnSaveClose, #ImgSaveClose").click(function () {
            vbCommentSave(true, msCommentId, msOwnerId, msOwnerType, msOnyxTimeStamp, secondaryId, current_user, insertion_user);
        });
    });
</script>
</body>
</html>
