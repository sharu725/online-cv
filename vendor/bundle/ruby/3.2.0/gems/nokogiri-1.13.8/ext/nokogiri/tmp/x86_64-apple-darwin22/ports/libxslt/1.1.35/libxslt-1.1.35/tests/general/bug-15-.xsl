<?xml version = "1.0" encoding = "UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match='doc'>
<html>
<body>
<ul>
    <xsl:for-each select='items'>
    <xsl:sort/>
    <li><xsl:value-of select='.'/></li>
    </xsl:for-each>
</ul>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
