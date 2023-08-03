<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="root">
    <result>
        <xsl:apply-imports/>
    </result>
</xsl:template>

<xsl:template match="test">passed</xsl:template>

</xsl:stylesheet>
