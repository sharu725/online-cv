<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:variable name="n">2</xsl:variable>

<xsl:template match="doc">
<xsl:value-of select="item[position()=$n]"/>
</xsl:template>

</xsl:stylesheet>
