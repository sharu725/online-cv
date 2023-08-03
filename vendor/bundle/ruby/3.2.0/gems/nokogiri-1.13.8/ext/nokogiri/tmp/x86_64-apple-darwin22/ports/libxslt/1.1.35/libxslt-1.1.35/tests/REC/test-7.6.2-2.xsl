<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">
        <xsl:element name="{substring('abc}', 1, 3)}"/>
    </xsl:template>
</xsl:stylesheet>
