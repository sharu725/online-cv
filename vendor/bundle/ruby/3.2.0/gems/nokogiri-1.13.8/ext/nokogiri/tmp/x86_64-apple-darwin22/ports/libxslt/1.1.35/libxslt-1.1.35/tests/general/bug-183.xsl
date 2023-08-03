<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:key name="index" match="val" use="current()/@k"/>
<xsl:template match="/">
    <result>
        <xsl:value-of select="key('index', 'one')"/>
    </result>
</xsl:template>
</xsl:stylesheet>
