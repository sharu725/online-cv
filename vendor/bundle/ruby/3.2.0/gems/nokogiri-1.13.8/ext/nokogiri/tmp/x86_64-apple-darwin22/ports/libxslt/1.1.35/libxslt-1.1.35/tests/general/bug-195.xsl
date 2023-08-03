<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="comment()">
        <xsl:comment>
            <xsl:value-of select="."/>
            <xsl:text> id="</xsl:text>
            <xsl:number count="comment()" level="any" />
            <xsl:text>"</xsl:text>
        </xsl:comment>
    </xsl:template>

</xsl:stylesheet>
