<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:import href="diffspec.xsl"/>

<xsl:template match="loc[@role='erratumref']">
  <xsl:choose>
    <xsl:when test="$show.diff.markup='0'">
      <!-- nop -->
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="loc[@role='erratumref']" mode="text">
  <xsl:choose>
    <xsl:when test="$show.diff.markup='0'">
      <!-- nop -->
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


</xsl:stylesheet>

