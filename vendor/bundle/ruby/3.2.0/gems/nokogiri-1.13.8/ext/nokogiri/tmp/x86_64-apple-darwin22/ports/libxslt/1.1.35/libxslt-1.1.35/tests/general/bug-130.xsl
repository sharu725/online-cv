<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/TR/REC-html40">

<xsl:import href="./bug-130-imp1.imp"/>
<xsl:import href="./bug-130-imp2.imp"/>
<xsl:import href="./bug-130-imp3.imp"/>
<xsl:import href="./bug-130-imp4.imp"/>

<xsl:output method="html" indent="no"/>

<xsl:variable name="g.doc.root" select="document('../docs/bug-130.doc')"/>

<xsl:template match="/">
  <html>
    <head></head>
    <body><xsl:apply-templates select="/frame"/></body>
  </html>
</xsl:template>

</xsl:stylesheet>
