<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>
  <xsl:attribute-set name="foo-attribs">
    <xsl:attribute name="size">+1</xsl:attribute>
  </xsl:attribute-set>
  <xsl:template match="foo">
    <font xsl:use-attribute-sets="foo-attribs">
foo
    </font>
  </xsl:template>
</xsl:stylesheet>
