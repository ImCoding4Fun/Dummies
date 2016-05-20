<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>
  <xsl:preserve-space elements="*" />
  <xsl:template match="/">
    <xsl:variable name="teamsupervisors" select="returnXml/customData/teamsupervisors" />
    <table>
      <xsl:attribute name="id">tbl_note_dinamiche</xsl:attribute>
      <xsl:attribute name="class">display</xsl:attribute>
      <xsl:attribute name="data-role">datatable</xsl:attribute>
      <xsl:attribute name="cellspacing">0</xsl:attribute>
      <xsl:attribute name="width">100%</xsl:attribute>
      <xsl:attribute name="data-searching">true</xsl:attribute>
      <thead>
        <tr>
          <td><xsl:attribute name="style">display:none</xsl:attribute></td>
          <td><xsl:attribute name="style">display:none</xsl:attribute></td>
          <td><xsl:attribute name="style">display:none</xsl:attribute></td>
          <td>Data Ins.</td>
          <td>Sigla Ins.</td>
          <td>Data Agg.</td>
          <td>Sigla Agg.</td>
          <td>Testo Nota</td>
          <td><xsl:attribute name="style">display:none</xsl:attribute></td>
          <td><xsl:attribute name="style">display:none</xsl:attribute></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="returnXml/parametersReturn/rowSet/rows/row">
          <tr>
            <xsl:attribute name="id">
              <xsl:value-of select="c0"/>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="c20 = '1'">
                <!-- Is nota per operativo -->
                <xsl:attribute name="class">evidenzia_guardia_medica</xsl:attribute>
              </xsl:when>
              <xsl:when test="c21 = '1'">
                <!-- Nota evidenziata da pop-up in fase di ADDing -->
                <xsl:attribute name="class">evidenzia_team_assistant</xsl:attribute>
              </xsl:when>
              <xsl:when test="c16 = 'UP009 GUARDIA MEDICA'">
                <xsl:attribute name="class">evidenzia_guardia_medica</xsl:attribute>
              </xsl:when>
              <xsl:when test="c17 = 'UP009 GUARDIA MEDICA'">
                <xsl:attribute name="class">evidenzia_guardia_medica</xsl:attribute>
              </xsl:when>
              <xsl:when test="contains($teamsupervisors,c12)">
                <xsl:attribute name="class">evidenzia_team_supervisor</xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="class"></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            <td style="display:none"> <!--Id nota-->
              <xsl:value-of select="c0"/>
            </td>
            <td style="display:none"> <!-- Owner_id -->
              <xsl:value-of select="c4"/>
            </td>
            <td style="display:none"> <!-- Insert_by -->
              <xsl:value-of select="c10"/>
            </td>
            <td><!-- data_ins -->
              <xsl:value-of select="c11" />
            </td>
            <td> <!-- sigla_ins -->
              <xsl:value-of select="c14"/>
              <span class="noTooltip">
                <xsl:value-of select="c18"/> - <xsl:value-of select="c16"/>
              </span>
            </td>
            <td> <!-- Data_agg -->
              <xsl:value-of select="c13" />
            </td>
            <td> <!-- Sigla_agg -->
              <xsl:value-of select="c15"/>
              <span class="noTooltip">
                <xsl:value-of select="c19"/> - <xsl:value-of select="c17"/>
              </span>
            </td>
            <td width="50%"><!-- Descrizione + testo nota -->
              <div class="tbl_note_ellipsis multiline">
                <xsl:value-of select="c7"/>
              </div>
              <span class="noTooltip">
                <xsl:value-of select="c7"/>
              </span>
            </td>
            <td style="display:none"> <!-- Data ins hidden -->
              <xsl:value-of select="c11" />
            </td>
            <td style="display:none"> <!-- Data agg hidden -->
              <xsl:value-of select="c13" />
            </td>
            <td> <!-- Visualizza -->
              <a title="Visualizza">
                <img src="../images/zoom.png"/>
              </a>
            </td>
            <td> <!-- Copia negli appunti -->
              <a title="Copia negli appunti">
                <img src="../images/copy_to_clipboard.png"/>
              </a>
            </td>
            <td> <!-- Link to process frame attachment -->
              <xsl:value-of select="c7"/>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
