<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str="http://exslt.org/strings"
    exclude-result-prefixes="str">

<xsl:template match="/">
<out>;
	str:split('a, simple, list', ', ')
	<xsl:copy-of select="str:split('a, simple, list', ', ')"/>

	str:split('data math str')
	<xsl:copy-of select="str:split('data math str')"/>

	str:split('foobar', '')
	<xsl:copy-of select="str:split('foobar', '')"/>

	str:split('-*- hello - world -*-', '-')
	<xsl:copy-of select="str:split('-*- hello - world -*-', '-')"/>

	str:split('data &amp;math str;')
	<xsl:copy-of select="str:split('data &amp;math str;')"/>
</out>
</xsl:template>

</xsl:stylesheet>
