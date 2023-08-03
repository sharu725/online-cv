<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*">
        <xsl:attribute name="{name()}">
            <xsl:number count="@*" level="any" />
        </xsl:attribute>
    </xsl:template>

</xsl:stylesheet>
