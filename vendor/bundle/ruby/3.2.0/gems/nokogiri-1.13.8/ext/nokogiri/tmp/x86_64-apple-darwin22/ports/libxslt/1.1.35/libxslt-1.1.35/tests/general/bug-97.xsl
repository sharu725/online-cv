<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:car="http://www.example.com/xmlns/car"
  xmlns:manu="http://www.example.com/xmlns/manufacturer">

  <xsl:output method="text" encoding="UTF-8" />
  <xsl:strip-space elements="*" />

  <xsl:template match="/">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="car:models">
    <xsl:text>My Car Models:&#xA;</xsl:text>
    <xsl:apply-templates select="car:model/@car:name"></xsl:apply-templates>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="manu:manufacturers">
    <xsl:text>The Manufacturers:&#xA;</xsl:text>
    <xsl:apply-templates select="manu:manufacturer/@manu:name"></xsl:apply-templates>
  </xsl:template>

  <xsl:template match="@*[local-name()='name']">
    <xsl:value-of select="." />
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>


