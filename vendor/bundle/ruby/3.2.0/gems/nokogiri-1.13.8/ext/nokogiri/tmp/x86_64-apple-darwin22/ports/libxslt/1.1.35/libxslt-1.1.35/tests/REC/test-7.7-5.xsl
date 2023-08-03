<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:template match="H4">
  <fo:block>
    <xsl:number level="any" from="H1" count="H2"/>
    <xsl:text>.</xsl:text>
    <xsl:number level="any" from="H2" count="H3"/>
    <xsl:text>.</xsl:text>
    <xsl:number level="any" from="H3" count="H4"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
