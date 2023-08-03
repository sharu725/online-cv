<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="*">
<xsl:for-each select="namespace::*">
<namespace>
<name><xsl:value-of select="name()"/></name>
<uri><xsl:value-of select="."/></uri>
<parent><xsl:copy-of select=".."/></parent>
</namespace>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>

