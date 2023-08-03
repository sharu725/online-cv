<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                version="1.0">

<xsl:template match="/">
	<xsl:for-each select="//string">
		<xsl:value-of select="text()"/>
		<xsl:text>
</xsl:text>
		<xsl:for-each select="str:tokenize(text(), '/')">
			    <xsl:text> '</xsl:text>
			    <xsl:value-of select="."/>
			    <xsl:text>'
</xsl:text>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>

<xsl:template name="foobar">
	<string>/foo/bar</string>
	<string>//foo/bar</string>
	<string>foo//bar</string>
	<string>foo/bar/</string>
	<string>foo/bar//</string>
</xsl:template>

</xsl:stylesheet>
