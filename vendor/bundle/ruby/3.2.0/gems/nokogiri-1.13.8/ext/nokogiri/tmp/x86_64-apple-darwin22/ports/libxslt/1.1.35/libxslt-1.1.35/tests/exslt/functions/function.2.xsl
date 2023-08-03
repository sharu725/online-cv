<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:func = "http://exslt.org/functions" extension-element-prefixes="func">

<!-- Test an EXSLT function with local variables -->

<func:function name="func:count-elements-and-attributes">
    <xsl:variable name="elements" select="//*"/>
    <xsl:variable name="attributes" select="//@*"/>
    <func:result select="count($elements | $attributes)"/>
</func:function>

  <xsl:template match="/">
    <out>
    <el><xsl:value-of select="count(//*)"/></el>;
    <at><xsl:value-of select="count(//@*)"/></at>;
      <xsl:value-of select="func:count-elements-and-attributes()"/>
    </out>
  </xsl:template>

</xsl:stylesheet>
