<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:template match="procedure">
  <fo:block>
    <xsl:value-of select="ancestor-or-self::*[@security][1]/@security"/>
  </fo:block>
  <xsl:apply-templates/>
</xsl:template>
</xsl:stylesheet>
