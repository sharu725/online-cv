<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="p/text()">
    <xsl:value-of
      select="concat('text in ', name(..), ' = &#x22;')"/>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>&#x22;&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>

