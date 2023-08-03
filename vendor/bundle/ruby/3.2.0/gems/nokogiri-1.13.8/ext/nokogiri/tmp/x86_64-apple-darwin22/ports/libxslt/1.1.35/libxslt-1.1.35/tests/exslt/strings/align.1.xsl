<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str="http://exslt.org/strings"
    exclude-result-prefixes="str">

<xsl:output indent="yes"/>

<xsl:template match="test-cases">
    <test-results>
        <xsl:apply-templates select="test-case"/>
    </test-results>
</xsl:template>

<xsl:template match="test-case">
    <test-result>
        <xsl:value-of select="str:align(@string, @padding, @alignment)"/>
    </test-result>
</xsl:template>

</xsl:stylesheet>

