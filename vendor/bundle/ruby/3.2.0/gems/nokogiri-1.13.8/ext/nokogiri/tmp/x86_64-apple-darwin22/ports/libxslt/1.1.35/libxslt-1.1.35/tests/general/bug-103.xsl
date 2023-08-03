<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	>

	<xsl:template match="/">
		<report xmlns="http://examplotron.org/namespaces/example">
			<xsl:copy-of select="foo"/>
		</report>
	</xsl:template>
	
</xsl:stylesheet>

