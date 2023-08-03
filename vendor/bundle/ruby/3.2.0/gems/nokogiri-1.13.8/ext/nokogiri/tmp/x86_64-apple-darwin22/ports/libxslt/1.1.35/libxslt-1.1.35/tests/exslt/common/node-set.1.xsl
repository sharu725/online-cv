<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:exslt="http://exslt.org/common" >

<!-- Test exslt:node-set applied to a node-set -->

<xsl:variable name="tree">
<a><b><c><d/></c></b></a>
</xsl:variable>

<xsl:template match="/">
  <out>
    <xsl:value-of select="count(exslt:node-set(//*))"/>
  </out>
</xsl:template>
 
</xsl:stylesheet>
