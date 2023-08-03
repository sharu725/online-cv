<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:set="http://exslt.org/sets" >

<!-- Test exslt:distinct -->


<xsl:template match="/">
  <out>
  <all-countries>:
    <xsl:for-each select="//@country">
          <xsl:value-of select="."/>;
    </xsl:for-each>
  </all-countries>:
  <distinct-countries>:  
    <xsl:for-each select="set:distinct(//@country)">
          <xsl:value-of select="."/>;
    </xsl:for-each>      
  </distinct-countries> 
  </out>
</xsl:template>
 
</xsl:stylesheet>
