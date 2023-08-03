<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
 
  <xsl:attribute-set name="foo-attribs">
    <xsl:attribute name="size">+1</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="foo-dep-attribs"
    use-attribute-sets="foo-attribs">
    <xsl:attribute name="text-align">start</xsl:attribute>
  </xsl:attribute-set>
 
  <xsl:template match="/">
    <font xsl:use-attribute-sets="foo-dep-attribs">
    foo
    </font>
  </xsl:template>
 
</xsl:stylesheet>
