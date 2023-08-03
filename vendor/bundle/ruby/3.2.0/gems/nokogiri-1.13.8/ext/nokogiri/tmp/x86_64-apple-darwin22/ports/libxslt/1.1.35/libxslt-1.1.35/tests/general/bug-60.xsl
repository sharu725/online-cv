<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
<result xsl:version="6.1">
    <xsl:foo-of select="/Fuhrpark">
	<xsl:fallback>
	    <xsl:text>An error occoured, foo-of not known</xsl:text>
	</xsl:fallback>
    </xsl:foo-of>
</result>
</xsl:template>
</xsl:stylesheet>


