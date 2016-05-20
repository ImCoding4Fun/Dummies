<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9">
    <title></title>
    <script type="text/vbscript" src="../common/vbscript/encode.vbi"></script>
    <script type="text/vbscript" src="../common/vbscript/otm_helper.vbi"></script>
    <script type="text/vbscript" src="../common/vbscript/common.vbi"></script>
    <script type="text/vbscript" src="../common/vbscript/datetime.vbi"></script>

    <script type="text/javascript" src="../csGenericLbo/csGenericLbo.js"></script>
    <script type="text/vbscript" src="../csGenericLbo/csGenericLbo.vbi"></script>

    <script type="text/javascript" src="../jQuery/jquery-1.8.2.js"></script>

    <!--#region lbo Role includes -->
    <script type="text/javascript" src="../common/javascript/numbers.js"></script>
    <script type="text/vbscript" src="../lbo/common/otm_connection.vbi"></script>
    <script type="text/vbscript" src="../lbo/common/otm_retrieveList.vbi"></script>
    <script type="text/javascript" src="../lbo/common/error.js"></script>
    <script type="text/javascript" src="../lbo/role/role.js"></script>
    <!--#endregion lbo Role includes   -->

    <% ' jsMessageBox includes %>
    <script type="text/vbscript" src="../res/javascript/alertres.js"></script>
    <script type="text/vbscript" src="../res/javascript/notificationres.js"></script>
    <script type="text/vbscript" src="../common/javascript/notification.js"></script>
    <script type="text/javascript" src="../common/javascript/cache.js"></script>

    <link rel="stylesheet" type="text/css" href="../stylesheet/default.css">
    <link rel="stylesheet" type="text/css" href="../jQuery/css/smoothness/jquery-ui-1.8.4.custom.css">
    <link rel="stylesheet" type="text/css" href="../csDataTable/styles/jquery.dataTables.css" />
    <link rel="stylesheet" type="text/css" href="../csDataTable/styles/dataTables.css" />
    <link rel="stylesheet" type="text/css" href="note_dinamiche.css">

    <script type="text/javascript" src="../csDataTable/scripts/jquery.dataTables.js"></script>
    <script type="text/javascript" src="../csDataTable/scripts/xml2json.min.js"></script>
    <script type="text/javascript" src="../csDataTable/scripts/date.js"></script>
    <script type="text/javascript" src="../jQuery/jquery-ui-1.8.2.custom.min.js"></script>
    <script type="text/javascript" src="../string_extensions.js"></script>
    <script type="text/javascript" src="../common/javascript/datetime.js"></script>
    <script type="text/javascript" src="note_dinamiche.js"></script>
    <script type="text/javascript" src ="../Res/comments/comment_edit_res.js"></script>
</head>
<body>
    <div id="dialog-message" title="">
        <span class="ui-icon ui-icon-info" style="float:left; margin:0 5px 0 0;"></span><script type="text/javascript">document.write(res_LoadingTabellaNote);</script>
    </div>

    <div id="note_cmd">
        <span class="imgCommandNote">
            <img id="add_note" src="../images/icons/iconadd2.gif" alt="Aggiungi nota" /></span>
        <span class="imgCommandNote">
            <img id="browse_notes" src="../images/icons/iconretrieve0.gif" alt="Visualizza nota" /></span>
    </div>
    <div id="note_div"></div>
    <div id="dettaglio_nota" style="display:none"></div>
</body>
</html>



