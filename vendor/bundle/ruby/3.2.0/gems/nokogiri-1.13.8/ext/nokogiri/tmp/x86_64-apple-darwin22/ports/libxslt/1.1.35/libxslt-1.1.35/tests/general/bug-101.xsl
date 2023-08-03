<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <xsl:element xmlns="http://baz.xml" name="foo">
      <xsl:element name="bar"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
