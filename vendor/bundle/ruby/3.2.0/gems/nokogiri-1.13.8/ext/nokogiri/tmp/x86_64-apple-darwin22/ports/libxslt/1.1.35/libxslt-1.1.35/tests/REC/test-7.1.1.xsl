<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias">

<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>

<xsl:template match="/">
  <axsl:stylesheet>
    <xsl:apply-templates/>
  </axsl:stylesheet>
</xsl:template>

<xsl:template match="block">
  <axsl:template match="{.}">
     <fo:block><axsl:apply-templates/></fo:block>
  </axsl:template>
</xsl:template>

</xsl:stylesheet>
