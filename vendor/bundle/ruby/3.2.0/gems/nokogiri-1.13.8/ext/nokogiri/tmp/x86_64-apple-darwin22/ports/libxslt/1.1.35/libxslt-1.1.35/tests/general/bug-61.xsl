<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
version="1.0">
<xsl:template match="/">
case 1:
<xsl:value-of select="format-number('', '#.#')"/>
case 2:
<xsl:value-of select="number('')"/>
case 3:
<xsl:value-of select="format-number(non/existing/path, '#.#')"/>
case 4:
<xsl:value-of select="number(non/existing/path)"/>
</xsl:template>
</xsl:stylesheet>
