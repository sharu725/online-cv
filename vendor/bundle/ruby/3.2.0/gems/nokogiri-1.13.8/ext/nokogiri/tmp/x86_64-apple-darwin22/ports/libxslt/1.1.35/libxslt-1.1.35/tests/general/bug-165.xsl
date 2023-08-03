<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:template match="p">
<xsl:value-of select="preceding-sibling::p[not(pPr/pStyle = $pStyle)][1]/preceding-sibling::p/pPr/pStyle"/>
</xsl:template>

</xsl:stylesheet>
