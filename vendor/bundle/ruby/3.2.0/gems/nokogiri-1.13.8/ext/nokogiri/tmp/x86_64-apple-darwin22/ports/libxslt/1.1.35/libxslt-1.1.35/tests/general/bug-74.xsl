<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">
<xsl:output method="xml" encoding="UTF-8"/>
<xsl:template match="TestNode">
<select>
<xsl:attribute name="onclick">aaaa
	bbbb</xsl:attribute>
</select>
</xsl:template>
</xsl:stylesheet>
