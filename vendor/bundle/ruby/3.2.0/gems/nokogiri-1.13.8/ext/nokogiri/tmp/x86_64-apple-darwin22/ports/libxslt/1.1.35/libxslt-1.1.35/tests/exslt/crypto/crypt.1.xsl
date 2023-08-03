<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:crypto="http://exslt.org/crypto"
    exclude-result-prefixes="crypto"
    version="1.0">

    <xsl:output indent="yes"/>

    <xsl:template match="test-cases">
        <test-results>
            <xsl:apply-templates select="test-case"/>
        </test-results>
    </xsl:template>

    <xsl:template match="test-case">
        <xsl:variable name="ciphertext" select="crypto:rc4_encrypt(key, data)"/>
        <xsl:variable name="plaintext" select="crypto:rc4_decrypt(key, $ciphertext)"/>
        <test-result>
            <ciphertext>
                <xsl:value-of select="$ciphertext"/>
            </ciphertext>
            <match>
                <xsl:choose>
                    <xsl:when test="$plaintext = data">OK</xsl:when>
                    <xsl:otherwise>FAIL</xsl:otherwise>
                </xsl:choose>
            </match>
        </test-result>
    </xsl:template>

</xsl:stylesheet>
