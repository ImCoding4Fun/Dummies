<xsl:stylesheet 
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>
  <xsl:preserve-space elements="*" />
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <xsl:template name="fmt_date">
    <xsl:param name="data_ins" />

    <!-- input format xslt datetime string -->
    <!-- output format dd/mm/yyyy -->

    <xsl:variable name="datestr">
      <xsl:value-of select="substring-before($data_ins,'T')" />
    </xsl:variable>

    <xsl:variable name="mm">
      <xsl:value-of select="substring($data_ins,6,2)" />
    </xsl:variable>

    <xsl:variable name="dd">
      <xsl:value-of select="substring($data_ins,9,2)" />
    </xsl:variable>

    <xsl:variable name="yyyy">
      <xsl:value-of select="substring($data_ins,0,5)" />
    </xsl:variable>

    <xsl:value-of select="concat($dd,'/', $mm, '/', $yyyy)" />
  </xsl:template>

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
          <td><xsl:attribute name="style">display:none</xsl:attribute>
          </td>
          <td>
            <xsl:attribute name="style">display:none</xsl:attribute>
          </td>
          <td>
            <xsl:attribute name="style">display:none</xsl:attribute>
          </td>
          <td>Data Ins.</td>
          <td>Sigla Ins.</td>
          <td>Data Agg.</td>
          <td>Sigla Agg.</td>
          <td>Testo Nota</td>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="returnXml/parametersReturn/rowSet/rows/row">
          <tr>
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
            <td>
              <!--Id nota-->
              <xsl:attribute name="style">display:none</xsl:attribute>
              <xsl:value-of select="c0"/>
            </td>
            <td>
              <!-- owner_id -->
              <xsl:attribute name="style">display:none</xsl:attribute>
              <xsl:value-of select="c4"/>
            </td>
            <td>
              <!-- update_by -->
              <xsl:attribute name="style">display:none</xsl:attribute>
              <xsl:value-of select="c12"/>
            </td>
            <td>
              <!-- data_ins -->
              <xsl:call-template name="fmt_date">
                <xsl:with-param  name="data_ins">
                  <xsl:value-of select="c11"/>
                </xsl:with-param>
              </xsl:call-template>
            </td>
            <td>
              <!-- sigla_ins -->
              <xsl:value-of select="c14"/>
              <span>
                <xsl:attribute name="class">noTooltip</xsl:attribute>
                <xsl:value-of select="c18"/> - <xsl:value-of select="c16"/>
              </span>
            </td>
            <td>
              <!-- data_agg -->
              <xsl:value-of select="c13" />
            </td>
            <td>
              <!-- sigla_agg -->
              <xsl:value-of select="c15"/>
              <span>
                <xsl:attribute name="class">noTooltip</xsl:attribute>
                <xsl:value-of select="c19"/> - <xsl:value-of select="c17"/>
              </span>
            </td>
            <td>
              <!-- Descrizione + testo nota -->
              <xsl:value-of select="c6"/>
              <span>
                <xsl:attribute name="class">noTooltip</xsl:attribute>
                <xsl:value-of select="c7"/>
              </span>
            </td>
            <td>
              <!-- data ins hidden -->
              <xsl:attribute name="style">display:none</xsl:attribute>
              <xsl:value-of select="c11" />
            </td>
            <td>
              <!-- data agg hidden -->
              <xsl:attribute name="style">display:none</xsl:attribute>
              <xsl:value-of select="c13" />
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
