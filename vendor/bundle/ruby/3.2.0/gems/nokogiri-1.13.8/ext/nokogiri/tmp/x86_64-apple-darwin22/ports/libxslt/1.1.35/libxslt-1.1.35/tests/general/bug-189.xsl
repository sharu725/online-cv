<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes"/>
  <xsl:template match="/">
    <result>
      <elem xsl:use-attribute-sets="att1 att2"/>
      <elem xsl:use-attribute-sets="att3"/>
    </result>
  </xsl:template>
  <xsl:attribute-set name="att1">
    <xsl:attribute name="att1">1</xsl:attribute>
    <xsl:attribute name="commonatt">1</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="att2">
    <xsl:attribute name="att2">2</xsl:attribute>
    <xsl:attribute name="commonatt">2</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="att3">
    <xsl:attribute name="att3a">1</xsl:attribute>
    <xsl:attribute name="att3a">2</xsl:attribute>
    <xsl:attribute name="att3b">1</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="att3">
    <xsl:attribute name="att3b">2</xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>
