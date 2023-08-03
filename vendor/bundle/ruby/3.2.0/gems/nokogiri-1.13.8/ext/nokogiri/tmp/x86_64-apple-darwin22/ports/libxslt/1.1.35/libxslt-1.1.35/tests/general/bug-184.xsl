<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Known to fail with libxml2 2.9.1 and below. -->
    <xsl:template match="/">
        <result>
            <xsl:value-of select="generate-id()=generate-id(key('none', $nonexistent))"/>
        </result>
    </xsl:template>
</xsl:stylesheet>
