<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0" >

   <xsl:output method="text"/>
   <xsl:template match="*">
     <xsl:text>&#x0A;selecting by element:    </xsl:text>
     <xsl:for-each select="ancestor-or-self::*">
       <xsl:text>/</xsl:text>
       <xsl:value-of select="@name"/>
     </xsl:for-each>
     <xsl:text>&#x0A;          by attribute:  </xsl:text>
     <xsl:for-each select="ancestor-or-self::*/@name">
       <xsl:text>/</xsl:text>
       <xsl:value-of select="."/>
     </xsl:for-each>
     <xsl:text>&#x0A;</xsl:text>
     <xsl:apply-templates/>
   </xsl:template>

</xsl:stylesheet>
