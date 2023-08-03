<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                
<xsl:import href="./bug-147-3.imp"/>
<xsl:import href="./bug-147-2.imp"/>
<xsl:import href="./bug-147-1.imp"/>
<xsl:import href="./bug-147-4.imp"/>


<xsl:output method="html"/>


<xsl:template match="/">
  <html>
    <head></head>
    <body><xsl:apply-templates select="/dokument"/></body>
  </html>
</xsl:template>


<xsl:template match="dokument">
  <div>
    <xsl:apply-imports/>
    <xsl:apply-templates select="navigation[@location='bottom']"/>
  </div>
</xsl:template>

</xsl:stylesheet>
