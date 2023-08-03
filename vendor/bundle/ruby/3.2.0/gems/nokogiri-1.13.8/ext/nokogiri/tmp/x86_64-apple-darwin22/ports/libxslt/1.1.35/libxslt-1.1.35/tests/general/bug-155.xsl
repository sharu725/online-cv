<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
  <xsl:template match="object[@class='Literaturhinweis']"><h3>Literaturhinweis</h3>
<ul>
 <li><strong>Ältestenrat:</strong><xsl:value-of select="Ältestenrat"/></li>
</ul>
</xsl:template>
</xsl:stylesheet>

