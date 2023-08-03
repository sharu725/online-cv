<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str="http://exslt.org/strings"
    exclude-result-prefixes="str">

<xsl:template match="/">
	<xsl:variable name="x" select="doc/strings/x"/>
	<xsl:variable name="y" select="doc/strings/y"/>
	<xsl:variable name="from" select="doc/strings/from"/>
	<xsl:variable name="to" select="doc/strings/to"/>
        <xsl:variable name="result" select="str:replace('a', 'b', 'c')"/>

<out>;
        result nodes: <xsl:value-of select="count($result)"/>
        result text nodes: <xsl:value-of select="count($result/self::text())"/>
        result string: <xsl:value-of select="$result/self::text()"/>

	str:replace('a, simple, list', ', ', '-')
	<xsl:copy-of select="str:replace('a, simple, list', ', ', '-')"/>

	str:replace('a, simple, list', 'a, ', 'the ')
	<xsl:copy-of select="str:replace('a, simple, list', 'a, ', 'the ')"/>

	str:replace('a, simple, list', 'list', 'array')
	<xsl:copy-of select="str:replace('a, simple, list', 'list', 'array')"/>

	str:replace('a, simple, list', 'i', 'I')
	<xsl:copy-of select="str:replace('a, simple, list', 'i', 'I')"/>

	str:replace('a, simple, list', ', ', '')
	<xsl:copy-of select="str:replace('a, simple, list', ', ', '')"/>

	str:replace('fee, fi, fo, fum', $x, $y)
	<xsl:copy-of select="str:replace('fee, fi, fo, fum', $x, $y)" />

	str:replace('fee, fi, fo, fum', $x, 'j')
	<xsl:copy-of select="str:replace('fee, fi, fo, fum', $x, 'j')" />

	str:replace('foo', '', 'baz')
	<xsl:copy-of select="str:replace('foo', '', 'baz')" />

	str:replace('Price is $1.10', $from, $to)
	<xsl:copy-of select="str:replace('Price is $1.10', $from, $to)" />

</out>
</xsl:template>

</xsl:stylesheet>
