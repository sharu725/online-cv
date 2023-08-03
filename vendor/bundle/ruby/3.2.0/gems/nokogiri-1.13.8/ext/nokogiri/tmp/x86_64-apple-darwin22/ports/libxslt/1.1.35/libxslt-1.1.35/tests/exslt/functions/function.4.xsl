<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:func = "http://exslt.org/functions" extension-element-prefixes="func">

<!-- Test a recursive EXSLT function -->

<func:function name="func:factorial">
    <xsl:param name="n"/>
    <xsl:choose>
    <xsl:when test="$n=1"><func:result select="1"/></xsl:when>
    <xsl:otherwise><func:result select="$n * func:factorial($n - 1)"/></xsl:otherwise>
    </xsl:choose>
</func:function>

  <xsl:template match="/">
      <out><xsl:value-of select="func:factorial(5)"/></out>
  </xsl:template>


</xsl:stylesheet>
