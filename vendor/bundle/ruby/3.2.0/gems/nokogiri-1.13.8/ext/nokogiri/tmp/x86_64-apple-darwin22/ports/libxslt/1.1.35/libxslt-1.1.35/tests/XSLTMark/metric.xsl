<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8"/>


  <xsl:template match="measurement">
    <xsl:variable name="m">
      <xsl:choose>
        <xsl:when test="@fromunit='km'">
          <xsl:value-of select=". * 1000"/>
        </xsl:when>
        <xsl:when test="@fromunit='m'">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:when test="@fromunit='cm'">
          <xsl:value-of select=". * 0.01"/>
        </xsl:when>
        <xsl:when test="@fromunit='mm'">
          <xsl:value-of select=". * 0.001"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <measurement unit="{@tounit}">
      <xsl:choose>
        <xsl:when test="@tounit='mi'">
          <xsl:value-of select="0.00062137 * $m"/>
        </xsl:when>
        <xsl:when test="@tounit='yd'">
          <xsl:value-of select="1.09361 * $m"/>
        </xsl:when>
        <xsl:when test="@tounit='ft'">
          <xsl:value-of select="3.2808 * $m"/>
        </xsl:when>
        <xsl:when test="@tounit='in'">
        <xsl:value-of select="39.37 * $m"/>
      </xsl:when>
    </xsl:choose>
    </measurement>


  </xsl:template>
</xsl:stylesheet>