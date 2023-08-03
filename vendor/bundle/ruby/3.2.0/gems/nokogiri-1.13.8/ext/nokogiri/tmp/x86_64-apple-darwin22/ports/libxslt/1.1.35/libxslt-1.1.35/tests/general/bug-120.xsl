<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="a">
   <a>
   Ascending numeric
   <xsl:for-each select="b">
     <xsl:sort select="." data-type="number"/>
     <xsl:copy-of select="."/>
   </xsl:for-each>
   Descending numeric
   <xsl:for-each select="b">
     <xsl:sort select="." data-type="number" order="descending"/>
     <xsl:copy-of select="."/>
   </xsl:for-each>
   Ascending alpha
   <xsl:for-each select="b">
     <xsl:sort select="." data-type="text"/>
     <xsl:copy-of select="."/>
   </xsl:for-each>
   </a>
</xsl:template>

</xsl:stylesheet>

