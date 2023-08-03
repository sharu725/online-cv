<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:func = "http://exslt.org/functions" extension-element-prefixes="func"
xmlns:f = "f.uri" exclude-result-prefixes="f">

<!-- Test the effect of function-available() and element-available() -->

<func:function name="f:total">
    <xsl:param name="n1" select="0"/>
    <xsl:param name="n2" select="0"/>
    <xsl:param name="n3" select="0"/>
    <xsl:param name="n4" select="0"/>
    <xsl:param name="n5" select="0"/>
    <xsl:param name="n6" select="0"/>
    <xsl:param name="n7" select="0"/>
    <func:result select="$n1+$n2+$n3+$n4+$n5+$n6+$n7"/>
</func:function>

  <xsl:template match="/">
      <out>;
        <true><xsl:value-of select="function-available('f:total')"/></true>;
        <false><xsl:value-of select="function-available('f:jabberwocky')"/></false>;
        <true><xsl:value-of select="element-available('func:result')"/></true>;
        <false><xsl:value-of select="element-available('func:function')"/></false>;
            <!-- note, this should return false because func:function is not an INSTRUCTION -->
        <false><xsl:value-of select="element-available('func:jeni-tennison')"/></false>;
      </out>
  </xsl:template>


</xsl:stylesheet>
