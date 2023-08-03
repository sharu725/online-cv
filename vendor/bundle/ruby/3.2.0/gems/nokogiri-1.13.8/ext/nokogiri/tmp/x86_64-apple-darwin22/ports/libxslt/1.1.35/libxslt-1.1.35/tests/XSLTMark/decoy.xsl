<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="utf-8"/>
<!-- 
       decoy stylesheet is same as patterns.xsl, but has lots of decoy patterns 
       to distract the matching process...
     -->

  <xsl:template match="decoy" priority="2">
    <ERROR>
      <xsl:apply-templates/>
    </ERROR>
  </xsl:template>
  <!--
  <xsl:template match="*/*/*/*/*">
    <ERROR/>
  </xsl:template>
-->
  <xsl:template match="decoy2" priority="-100">
    <ERROR/>
  </xsl:template>
  
  <xsl:template name="decoy">
    <ERROR/>
  </xsl:template>
    
  <xsl:template match="/decoy/*/*/*/*">
    <ERROR/>
  </xsl:template>

  <xsl:template match="/foo/bar/baz/quux">
    <ERROR/>
  </xsl:template>

  <xsl:template match="text()[*/../*/../foobar]">
    <ERROR/>
  </xsl:template>

  <xsl:template match="foobar[../*/../*/baz]">
    <ERROR/>
  </xsl:template>

  <xsl:template match="foobar[3]">
    <ERROR/>
  </xsl:template>

  <xsl:template match="foo|bar|baz|quux|metasyntactic|variable|fubar">
    <ERROR/>
  </xsl:template>

  <xsl:template match="foobar/table/row/id">
    <ERROR/>
  </xsl:template>

  <xsl:template match="table/row[id='abcdefg']" priority="3">
    <ERROR/>
  </xsl:template>

  <xsl:template match="text()[contains(.,'decoy')]">
    <ERROR/>
  </xsl:template>



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


