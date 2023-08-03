<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="in">
    <annotation>
      <xsl:copy-of select="."/>
      <value>
        <xsl:copy-of select="document(.)"/>
      </value>
    </annotation>
  </xsl:template>
  <xsl:template match="@*|node()">
    <xsl:apply-templates/>
  </xsl:template>
</xsl:stylesheet>
