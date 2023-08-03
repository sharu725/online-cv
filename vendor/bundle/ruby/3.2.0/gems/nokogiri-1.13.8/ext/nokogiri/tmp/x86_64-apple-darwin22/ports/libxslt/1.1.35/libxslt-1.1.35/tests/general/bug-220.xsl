<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ext="ext"
    extension-element-prefixes="ext">
<xsl:template match="/">
    <r>
        <ext:e>
            <xsl:fallback><fallback/></xsl:fallback>
            <ext:f/>
        </ext:e>
    </r>
</xsl:template>
</xsl:stylesheet>

