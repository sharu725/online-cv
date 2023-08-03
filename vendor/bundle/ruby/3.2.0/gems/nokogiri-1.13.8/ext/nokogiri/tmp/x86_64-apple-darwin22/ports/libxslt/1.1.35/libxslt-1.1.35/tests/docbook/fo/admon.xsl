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

<xsl:template match="note|important|warning|caution|tip">
  <xsl:choose>
    <xsl:when test="$admon.graphics != 0">
      <xsl:call-template name="graphical.admonition"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="nongraphical.admonition"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="admon.graphic.width">
  <xsl:param name="node" select="."/>
  <xsl:text>36pt</xsl:text>
</xsl:template>

<xsl:template name="admon.graphic">
  <xsl:param name="node" select="."/>
  <xsl:value-of select="$admon.graphics.path"/>
  <xsl:choose>
    <xsl:when test="name($node)='note'">note</xsl:when>
    <xsl:when test="name($node)='warning'">warning</xsl:when>
    <xsl:when test="name($node)='caution'">caution</xsl:when>
    <xsl:when test="name($node)='tip'">tip</xsl:when>
    <xsl:when test="name($node)='important'">important</xsl:when>
    <xsl:otherwise>note</xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="$admon.graphics.extension"/>
</xsl:template>

<xsl:template name="graphical.admonition">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block id="{$id}">
    <fo:table>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell number-rows-spanned="2">
            <fo:block>
              <fo:external-graphic width="auto" height="auto">
                <xsl:attribute name="src">
                  <xsl:call-template name="admon.graphic"/>
                </xsl:attribute>
                <xsl:attribute name="content-width">
                  <xsl:call-template name="admon.graphic.width"/>
                </xsl:attribute>
              </fo:external-graphic>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block>
              <xsl:apply-templates select="." mode="object.title.markup"/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
        <fo:table-row>
          <fo:table-cell number-columns-spanned="2">
            <fo:block>
              <xsl:apply-templates/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </fo:block>
</xsl:template>

<xsl:template name="nongraphical.admonition">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block space-before.minimum="0.8em"
            space-before.optimum="1em"
            space-before.maximum="1.2em"
            start-indent="0.25in"
            end-indent="0.25in"
            id="{$id}">
    <fo:block font-size="14pt" font-weight="bold" keep-with-next='always'>
      <xsl:apply-templates select="." mode="object.title.markup"/>
    </fo:block>

    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="note/title"></xsl:template>
<xsl:template match="important/title"></xsl:template>
<xsl:template match="warning/title"></xsl:template>
<xsl:template match="caution/title"></xsl:template>
<xsl:template match="tip/title"></xsl:template>

<xsl:template match="title" mode="admonition.title.mode">
  <fo:block font-size="14pt" font-weight="bold" keep-with-next='always'>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
