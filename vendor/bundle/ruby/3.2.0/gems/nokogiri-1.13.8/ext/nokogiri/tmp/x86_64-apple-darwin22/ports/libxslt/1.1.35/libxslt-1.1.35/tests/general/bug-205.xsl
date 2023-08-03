<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:decimal-format xmlns:testns="urn:test:1" name="testns:format" decimal-separator=","/>
<xsl:decimal-format xmlns:testns="urn:test:2" name="testns:format" decimal-separator="."/>

<xsl:template match="/" xmlns:newns="urn:test:1">
    <xsl:value-of select="format-number(123, '0,00', 'newns:format')"/>
</xsl:template>

</xsl:stylesheet>
