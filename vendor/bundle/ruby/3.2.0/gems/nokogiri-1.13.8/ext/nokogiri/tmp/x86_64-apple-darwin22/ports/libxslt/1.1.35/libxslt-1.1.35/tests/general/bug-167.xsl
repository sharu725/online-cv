<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:output method="text"/>

<xsl:template match="/">
  <xsl:text>Hello </xsl:text>
  <xsl:if test="false()">
    <xsl:text>world</xsl:text>
  </xsl:if>
</xsl:template>

<x:ignore xmlns:x="x">
<xsl:template match="/">
  <!--this better not be here!-->
</xsl:template>
</x:ignore>

</xsl:stylesheet>

