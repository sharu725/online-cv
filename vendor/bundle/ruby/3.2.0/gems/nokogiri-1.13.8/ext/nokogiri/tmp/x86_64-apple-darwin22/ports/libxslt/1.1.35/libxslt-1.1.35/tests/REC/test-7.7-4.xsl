<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:template match="note">
  <fo:block>
    <xsl:number level="any" from="chapter" format="(1) "/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
