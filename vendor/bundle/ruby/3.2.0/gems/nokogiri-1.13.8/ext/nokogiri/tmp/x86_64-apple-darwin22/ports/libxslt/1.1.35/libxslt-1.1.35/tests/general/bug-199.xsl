<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:for-each select="namespace::a">
                <xsl:attribute name="ns">
                    <xsl:value-of select="."/>
                    <xsl:text>(</xsl:text>
                    <xsl:number count="*" level="any"/>
                    <xsl:text>)</xsl:text>
                </xsl:attribute>
            </xsl:for-each>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
