<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:libxslt="http://xmlsoft.org/XSLT/"
		xmlns:test="http://xmlsoft.org/XSLT/"
		extension-element-prefixes="libxslt test"
                version='1.0'>
<!-- the prefix is registered twice to check single initialization -->
<xsl:template match="/">
<libxslt:test/>
<xsl:value-of select="libxslt:test('SUCCESS')"/>
</xsl:template>
</xsl:stylesheet>
