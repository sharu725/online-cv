<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="foo">
        <FOO>
                <xsl:apply-templates/>
        </FOO>
</xsl:template>

<xsl:template match="bar">
        <BAR>
                <xsl:value-of select="."/>
        </BAR>
</xsl:template>

<xsl:template match="xxx">
        <XXX>
                <xsl:value-of select="."/>
        </XXX>
</xsl:template>

</xsl:stylesheet>
