<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:test="http://example.org/"
		extension-element-prefixes="test"
		exclude-result-prefixes="test"
                version='1.0'>
<xsl:template match="/">
<test:test>
<xsl:fallback><doc>SUCCESS</doc></xsl:fallback>
</test:test>
</xsl:template>
</xsl:stylesheet>
