<xsl:stylesheet version="1.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:func="http://exslt.org/functions"   
   xmlns:mg="mg"
   extension-element-prefixes="func">

   <xsl:template match="root">
      <xsl:value-of select="mg:recurse(a, b)"/>
   </xsl:template>

   <func:function name="mg:recurse">
      <xsl:param name="a"/>
      <xsl:param name="b"/>
      <xsl:choose>
         <xsl:when test="$a > 0">            
            <func:result select="$a+mg:recurse($a - $b, $b)"/>
         </xsl:when>
         <xsl:otherwise>
            <func:result select="0"/>
         </xsl:otherwise>
      </xsl:choose>     
   </func:function>
</xsl:stylesheet>


