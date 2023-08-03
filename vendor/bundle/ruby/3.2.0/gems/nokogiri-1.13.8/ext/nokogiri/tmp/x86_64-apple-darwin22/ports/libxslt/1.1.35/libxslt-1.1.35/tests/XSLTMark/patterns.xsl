<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="utf-8"/>

  <xsl:template match="table/row[6]" priority="5">
    <row6>
      <xsl:apply-templates/>
    </row6>
  </xsl:template>

  <xsl:template match="table/row[id='0091']">
    <id91>
      <xsl:apply-templates/>
    </id91>
  </xsl:template>

  <xsl:template match="//row[firstname='Egon']">
    <egon>
      <xsl:apply-templates/>
    </egon>
  </xsl:template>

  <xsl:template match="table//row[*[.='Aranow']]">
    <aranow>
      <xsl:apply-templates/>
    </aranow>
  </xsl:template>

  <xsl:template match="row" priority="-1">
    <row>
      <xsl:apply-templates/>
    </row>
  </xsl:template>

  <xsl:template match="row[id mod 3 = 2][following-sibling::row[4]/firstname='Bob']">
    <crazy>
      <xsl:apply-templates/>
    </crazy>
  </xsl:template>

  <xsl:template match="id|firstname|lastname|street|city|state|zip">
    <xsl:copy><xsl:value-of select="."/></xsl:copy>
  </xsl:template>

</xsl:stylesheet>


