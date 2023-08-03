<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
version="1.0">
<xsl:output method="text"/>
<xsl:template match="/XML_DATA//*">
<xsl:value-of select="name()"/>
<xsl:text> - </xsl:text>
<xsl:for-each select="namespace::*">
<xsl:text> &quot;</xsl:text>
<xsl:value-of select="name()"/>
<xsl:text>&quot; </xsl:text>
</xsl:for-each>
<xsl:text>
</xsl:text>
</xsl:template>
</xsl:stylesheet>
