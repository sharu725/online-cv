<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ns2="whatever"
 xmlns:ns="another"
 version="1.0">

<xsl:output method="text"/>

<xsl:template match="ns2:root">
  RIGHT
</xsl:template>

<xsl:template match="ns:root">
  WRONG
</xsl:template>

</xsl:stylesheet>
