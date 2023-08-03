<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[@type]">
      <xsl:copy>
          <xsl:variable name="type" select="@type"/>
          <xsl:variable name="pos">
              <xsl:number count="node()[@type = $type]"/>
          </xsl:variable>
          <xsl:apply-templates select="@*"/>
          <xsl:attribute name="pos">
              <xsl:value-of select="$pos"/>
          </xsl:attribute>
          <xsl:apply-templates/>
      </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
