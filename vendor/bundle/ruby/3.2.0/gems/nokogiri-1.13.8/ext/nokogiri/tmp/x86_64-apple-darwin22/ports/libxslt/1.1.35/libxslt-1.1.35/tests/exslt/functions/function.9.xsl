<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns:func="http://exslt.org/functions"
  xmlns:math="http://exslt.org/math"
  xmlns:mg="mg"
  extension-element-prefixes="exsl func">

  <xsl:template match="table">          
    <xsl:variable name="cols" select="mg:function(., .)"/>         
    <xsl:value-of select="$cols"/>
  </xsl:template>       

  <func:function name="mg:function">
    <xsl:param name="table"/>
    <xsl:param name="t2" select="$table/tr[1]"/>
    <xsl:param name="tr" select="$table/tr[1]"/>                
    <xsl:param name="trd" select="$tr/td[1]"/>
    <func:result select="$tr"/>
  </func:function>      
</xsl:stylesheet>


