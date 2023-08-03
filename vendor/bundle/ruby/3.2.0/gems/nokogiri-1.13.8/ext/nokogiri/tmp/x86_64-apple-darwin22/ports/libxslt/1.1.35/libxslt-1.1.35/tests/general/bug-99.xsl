<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:output method="xml"/>

<xsl:template match="/">
  <xsl:element name="doc" namespace="ns1">
    <xsl:attribute name="attr" namespace="ns1">
      <xsl:text>foo!</xsl:text>
    </xsl:attribute>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>

