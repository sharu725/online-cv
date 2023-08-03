<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:strip-space elements="*"/>

<xsl:template match="foo">
  <FOO>
    <xsl:apply-templates/>
  </FOO>
</xsl:template>

<xsl:template match="bar">
  <BAR INDEX="{position()}">
    <xsl:value-of select="."/>
  </BAR>
</xsl:template>

</xsl:stylesheet>
