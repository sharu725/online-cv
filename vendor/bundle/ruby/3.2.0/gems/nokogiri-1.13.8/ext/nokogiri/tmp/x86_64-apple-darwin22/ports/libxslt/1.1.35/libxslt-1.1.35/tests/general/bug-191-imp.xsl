<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:attribute-set name="att2" use-attribute-sets="att3">
    <xsl:attribute name="att2">2</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="att3" use-attribute-sets="att1">
    <xsl:attribute name="att3">3</xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>
