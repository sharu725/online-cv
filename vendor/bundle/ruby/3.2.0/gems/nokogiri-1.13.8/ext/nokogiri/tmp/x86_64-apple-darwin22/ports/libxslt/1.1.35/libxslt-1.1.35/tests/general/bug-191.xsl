<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="bug-191-imp.xsl"/>
  <xsl:template match="/">
    <b xsl:use-attribute-sets="att1"/>
  </xsl:template>
  <xsl:attribute-set name="att1" use-attribute-sets="att2">
    <xsl:attribute name="att1">1</xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>
