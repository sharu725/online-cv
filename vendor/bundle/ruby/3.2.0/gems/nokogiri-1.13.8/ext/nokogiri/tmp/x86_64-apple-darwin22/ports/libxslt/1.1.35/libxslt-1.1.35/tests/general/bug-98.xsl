<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/">
    <result>
      <xsl:apply-templates/>
    </result>
  </xsl:template>
  <xsl:key name="k1" match="entry" use="@cat1"/>
  <xsl:key name="k2" match="entry" use="@cat2"/>
  <xsl:template match="list">
    <xsl:variable name="k">
      <xsl:choose>
        <xsl:when test="@type='one'">k1</xsl:when>
        <xsl:otherwise>k2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <total>
      <type>
        <xsl:value-of select="@type"/>
      </type>
      <a>
        <xsl:value-of select="sum( key($k,'a')/@qty )"/>
      </a>
      <b>
        <xsl:value-of select="sum( key($k,'b')/@qty )"/>
      </b>
    </total>
  </xsl:template>
  <xsl:template match="entries"/>
</xsl:stylesheet>
