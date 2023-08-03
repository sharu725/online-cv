<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:attribute-set name="as1">
    <xsl:attribute name="a1">as1</xsl:attribute>
    <xsl:attribute name="a2">as1</xsl:attribute>
    <xsl:attribute name="a3">as1</xsl:attribute>
    <xsl:attribute name="a4">as1</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="as2">
    <xsl:attribute name="a1">as2</xsl:attribute>
    <xsl:attribute name="a2">as2</xsl:attribute>
    <xsl:attribute name="a3">as2</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="foo">
    <bar xsl:use-attribute-sets="as1 as2" a1="element" a2="element">
      <xsl:attribute name="a1">attr</xsl:attribute>
    </bar>
  </xsl:template>
</xsl:stylesheet>
