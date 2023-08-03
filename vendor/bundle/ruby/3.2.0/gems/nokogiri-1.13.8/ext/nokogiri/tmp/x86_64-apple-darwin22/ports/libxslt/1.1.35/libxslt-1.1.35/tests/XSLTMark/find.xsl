<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="utf-8"/>
  <xsl:template match="element[@needle=1]">
    <found>
      <xsl:apply-templates/>
    </found>
  </xsl:template>

  <xsl:template match="element">
    <element>
      <xsl:apply-templates/>
    </element>
  </xsl:template>

</xsl:stylesheet>