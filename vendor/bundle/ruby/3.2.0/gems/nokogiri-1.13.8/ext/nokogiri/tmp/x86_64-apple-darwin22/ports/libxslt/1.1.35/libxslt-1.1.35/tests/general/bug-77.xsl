<?xml version="1.0"?> <xsl:stylesheet 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   version="1.0">
<!-- I have tried this with   xmlns:xml="http://www.w3.org/XML/1998/namespace"
     defined above, too
  -->

<xsl:template match="/">
<xsl:apply-templates mode="copy"/>
</xsl:template>

<xsl:template match="@* | node()" mode="copy">
<xsl:copy>
<xsl:apply-templates select="node() | @*" mode="copy"/>
</xsl:copy>
</xsl:template>

</xsl:stylesheet>
