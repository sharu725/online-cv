<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="bug-188-imp.xsl"/>
  <xsl:output indent="yes"/>

  <xsl:template match="/">
    <result>
      <xsl:element name="elem" use-attribute-sets="set"/>
    </result>
  </xsl:template>

  <xsl:attribute-set name="set" use-attribute-sets="used">
    <xsl:attribute name="other">GOOD</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="used">
    <xsl:attribute name="attr">GOOD</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
