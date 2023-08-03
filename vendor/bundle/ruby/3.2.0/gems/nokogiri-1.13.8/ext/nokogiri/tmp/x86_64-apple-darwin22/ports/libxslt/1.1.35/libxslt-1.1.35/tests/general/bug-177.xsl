<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/*">
        <xsl:copy>
            <xsl:attribute name="id" namespace="http://www.w3.org/XML/1998/namespace">etc</xsl:attribute>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
