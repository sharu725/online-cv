<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output encoding="utf-8"/>

<xsl:template match="table">
  <table>
    <xsl:apply-templates/>
  </table>
</xsl:template>

<xsl:template match="row">
  <row>
    <xsl:apply-templates/>
  </row>
</xsl:template>

<xsl:template match="*">
  <xsl:element name="column">
    <xsl:attribute name="name"><xsl:value-of select="name(.)"/></xsl:attribute>
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
