<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:func = "http://exslt.org/functions" extension-element-prefixes="func">

<!-- Test an EXSLT function call with defaulted arguments -->

<func:function name="func:total">
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
      <out><xsl:value-of select="func:total(1,2,3,4,5)"/></out>
  </xsl:template>


</xsl:stylesheet>
