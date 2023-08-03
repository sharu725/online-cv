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
        <xsl:variable name="padding">
            <xsl:choose>
                <xsl:when test="string(.)">
                    <xsl:value-of select="str:padding(@length, .)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="str:padding(@length)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <padding>
            <xsl:value-of select="$padding"/>
        </padding>
        <length-check>
            <xsl:choose>
                <xsl:when test="string-length($padding) = @length">OK</xsl:when>
                <xsl:otherwise>FAIL</xsl:otherwise>
            </xsl:choose>
        </length-check>
    </test-result>
</xsl:template>

</xsl:stylesheet>

