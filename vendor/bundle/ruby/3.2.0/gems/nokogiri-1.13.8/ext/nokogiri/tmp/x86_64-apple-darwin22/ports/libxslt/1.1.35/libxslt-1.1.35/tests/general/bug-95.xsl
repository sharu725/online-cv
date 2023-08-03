<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="ISO-8859-1"/>

<xsl:decimal-format name="czf"
     decimal-separator=","
     grouping-separator="&#160;"/>

<xsl:template match="Kapital">
<html>
<title>Example xsltproc</title>
<body>
	<xsl:apply-templates select="Vklad"/>
</body>
</html>
</xsl:template>	

<xsl:template match="Vklad" >
<xsl:value-of select="format-number(Kc,  '#&#160;###,00 Kè', 'czf')"/>
</xsl:template>

</xsl:stylesheet>
