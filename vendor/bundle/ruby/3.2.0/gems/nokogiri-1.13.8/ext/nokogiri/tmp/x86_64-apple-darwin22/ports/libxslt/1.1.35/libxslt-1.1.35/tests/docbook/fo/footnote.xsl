<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<xsl:template match="footnote">
  <fo:footnote>
    <fo:inline>
      <xsl:text>[</xsl:text>
      <xsl:apply-templates select="." mode="footnote.number"/>
      <xsl:text>]</xsl:text>
    </fo:inline>
    <fo:footnote-body font-size="{$footnote.font.size}">
      <xsl:apply-templates/>
    </fo:footnote-body>
  </fo:footnote>
</xsl:template>

<xsl:template match="footnoteref">
  <xsl:variable name="footnote" select="id(@linkend)"/>
  <fo:inline>
    <xsl:text>[</xsl:text>
    <xsl:apply-templates select="$footnote" mode="footnote.number"/>
    <xsl:text>]</xsl:text>
  </fo:inline>
</xsl:template>

<xsl:template match="footnote" mode="footnote.number">
  <xsl:number level="any" format="1"/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="footnote/para[1]
                     |footnote/simpara[1]
                     |footnote/formalpara[1]"
              priority="2">
  <!-- this only works if the first thing in a footnote is a para, -->
  <!-- which is ok, because it usually is. -->
  <fo:block>
    <xsl:text>[</xsl:text>
    <xsl:apply-templates select="ancestor::footnote" mode="footnote.number"/>
    <xsl:text>] </xsl:text>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
