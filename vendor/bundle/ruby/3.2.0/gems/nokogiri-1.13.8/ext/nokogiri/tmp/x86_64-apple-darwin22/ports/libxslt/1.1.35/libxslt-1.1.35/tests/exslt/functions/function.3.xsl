<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:func = "http://exslt.org/functions" extension-element-prefixes="func">

<!-- Test an EXSLT function with arguments -->

<func:function name="func:initial">
    <xsl:param name="size"/>
    <func:result select="substring(.,1,$size)"/>
</func:function>

  <xsl:template match="text()">
      <xsl:value-of select="func:initial(3)"/>
  </xsl:template>

  <xsl:template match="*">
  <xsl:copy>
      <xsl:apply-templates/>
  </xsl:copy>    
  </xsl:template>

</xsl:stylesheet>
