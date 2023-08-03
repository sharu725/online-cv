<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Known to fail with libxml2 2.9.0 and 2.9.1. -->

<xsl:template match="node()"/>

<xsl:template match="text()[2]">
  <p>text()[2]: <xsl:value-of select="."/></p>
</xsl:template>
<xsl:template match="b[2]">
  <p>b[2]: <xsl:value-of select="."/></p>
</xsl:template>

<xsl:template match="/">
  <body>
    <xsl:apply-templates select="/root/body/node()"/>
  </body>
</xsl:template>

</xsl:stylesheet>
