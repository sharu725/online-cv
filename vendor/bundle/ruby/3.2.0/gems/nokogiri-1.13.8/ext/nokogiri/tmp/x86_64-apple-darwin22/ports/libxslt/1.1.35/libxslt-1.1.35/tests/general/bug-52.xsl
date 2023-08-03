<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:output method="html"/>

<xsl:template match="doc">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="img">
  <xsl:text>Graphic file=</xsl:text>
  <xsl:value-of select="unparsed-entity-uri(@entref)"/>
</xsl:template>

</xsl:stylesheet>
