<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:crypto="http://exslt.org/crypto"
	exclude-result-prefixes="crypto"
	version="1.0">

	<xsl:output method="text" encoding="utf-8"/>

	<xsl:variable name="nl" select="'&#x0A;'"/>

	<xsl:template match="/">
		<xsl:apply-templates select="patterns/*"/>
	</xsl:template>

	<xsl:template match="br">
		<xsl:value-of select="$nl"/>
	</xsl:template>

	<xsl:template match="pattern">
		<xsl:variable name="text" select="."/>

		<xsl:text>text = _</xsl:text>
		<xsl:value-of select="$text"/>
		<xsl:text>_</xsl:text>

		<xsl:text>     md5 = </xsl:text>
		<xsl:value-of select="crypto:md5($text)"/>

		<xsl:text>     sha1 = </xsl:text>
		<xsl:value-of select="crypto:sha1($text)"/>

		<xsl:value-of select="$nl"/>
	</xsl:template>

</xsl:stylesheet>
