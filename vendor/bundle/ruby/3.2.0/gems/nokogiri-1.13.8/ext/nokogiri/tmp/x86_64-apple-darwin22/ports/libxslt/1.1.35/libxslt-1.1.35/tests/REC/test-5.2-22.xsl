<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="doc">
        <xsl:copy>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="doc[last()][last()]/elem">
        <xsl:text>success</xsl:text>
    </xsl:template>

</xsl:stylesheet>
