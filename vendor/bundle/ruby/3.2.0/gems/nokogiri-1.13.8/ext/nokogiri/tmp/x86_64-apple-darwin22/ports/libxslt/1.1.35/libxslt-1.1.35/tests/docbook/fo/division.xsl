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

<!-- ==================================================================== -->

<xsl:template name="division.title">
  <xsl:param name="node" select="."/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="$node"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="title">
    <xsl:apply-templates select="$node" mode="title.markup"/>
  </xsl:variable>

  <xsl:if test="$passivetex.extensions != 0">
    <fotex:bookmark xmlns:fotex="http://www.tug.org/fotex"
                    fotex-bookmark-level="1"
                    fotex-bookmark-label="{$id}">
      <xsl:value-of select="$title"/>
    </fotex:bookmark>
  </xsl:if>

  <fo:block keep-with-next.within-column="always"
            hyphenate="false">
    <xsl:copy-of select="$title"/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="set">
  <xsl:variable name="preamble"
                select="*[not(self::book or self::setindex)]"/>
  <xsl:variable name="content" select="book|setindex"/>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="master-name">
    <xsl:call-template name="select.pagemaster"/>
  </xsl:variable>

  <xsl:if test="$preamble">
    <fo:page-sequence id="{$id}"
                      hyphenate="{$hyphenate}"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>
      <xsl:if test="$double.sided != 0">
        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="set.titlepage"/>
      </fo:flow>
    </fo:page-sequence>
  </xsl:if>

  <xsl:apply-templates select="$content"/>
</xsl:template>

<xsl:template match="set/setinfo"></xsl:template>
<xsl:template match="set/title"></xsl:template>
<xsl:template match="set/subtitle"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="book">
  <xsl:variable name="preamble"
                select="title|subtitle|titleabbrev|bookinfo"/>
  <xsl:variable name="content"
                select="*[not(self::title or self::subtitle
                            or self::titleabbrev
                            or self::bookinfo)]"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="master-name">
    <xsl:call-template name="select.pagemaster"/>
  </xsl:variable>

  <xsl:if test="$preamble">
    <fo:page-sequence id="{$id}"
                      hyphenate="{$hyphenate}"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>
      <xsl:if test="$double.sided != 0">
        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="book.titlepage"/>
      </fo:flow>
    </fo:page-sequence>
  </xsl:if>

  <xsl:if test="$generate.book.toc != '0'">
    <fo:page-sequence hyphenate="{$hyphenate}"
                      format="i"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>
      <xsl:if test="$double.sided != 0">
        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="division.toc"/>
      </fo:flow>
    </fo:page-sequence>
  </xsl:if>

  <xsl:if test="$generate.book.figure.lot != '0' and .//figure">
    <fo:page-sequence hyphenate="{$hyphenate}"
                      format="i"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>
      <xsl:if test="$double.sided != 0">
        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="list.of.titles">
          <xsl:with-param name="titles" select="'figure'"/>
          <xsl:with-param name="nodes" select=".//figure"/>
        </xsl:call-template>
      </fo:flow>
    </fo:page-sequence>
  </xsl:if>

  <xsl:if test="$generate.book.table.lot != '0' and .//table">
    <fo:page-sequence hyphenate="{$hyphenate}"
                      format="i"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>
      <xsl:if test="$double.sided != 0">
        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="list.of.titles">
          <xsl:with-param name="titles" select="'table'"/>
          <xsl:with-param name="nodes" select=".//table"/>
        </xsl:call-template>
      </fo:flow>
    </fo:page-sequence>
  </xsl:if>

  <xsl:if test="$generate.book.example.lot != '0' and .//example">
    <fo:page-sequence hyphenate="{$hyphenate}"
                      format="i"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>
      <xsl:if test="$double.sided != 0">
        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="list.of.titles">
          <xsl:with-param name="titles" select="'example'"/>
          <xsl:with-param name="nodes" select=".//example"/>
        </xsl:call-template>
      </fo:flow>
    </fo:page-sequence>
  </xsl:if>

  <xsl:if test="$generate.book.equation.lot != '0' and .//equation">
    <fo:page-sequence hyphenate="{$hyphenate}"
                      format="i"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>
      <xsl:if test="$double.sided != 0">
        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="list.of.titles">
          <xsl:with-param name="titles" select="'equation'"/>
          <xsl:with-param name="nodes" select=".//equation"/>
        </xsl:call-template>
      </fo:flow>
    </fo:page-sequence>
  </xsl:if>

  <xsl:apply-templates select="dedication" mode="dedication"/>

  <xsl:apply-templates select="$content"/>
</xsl:template>

<xsl:template match="book/bookinfo"></xsl:template>
<xsl:template match="book/title"></xsl:template>
<xsl:template match="book/subtitle"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="part">
  <xsl:if test="not(partintro)">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
    <xsl:variable name="master-name">
      <xsl:call-template name="select.pagemaster"/>
    </xsl:variable>

    <fo:page-sequence id="{$id}"
                      hyphenate="{$hyphenate}"
                      master-name="{$master-name}">
      <xsl:attribute name="language">
        <xsl:call-template name="l10n.language"/>
      </xsl:attribute>
      <xsl:if test="$double.sided != 0">
        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
      </xsl:if>

      <xsl:apply-templates select="." mode="running.head.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="running.foot.mode">
        <xsl:with-param name="master-name" select="$master-name"/>
      </xsl:apply-templates>

      <fo:flow flow-name="xsl-region-body">
        <xsl:call-template name="part.titlepage"/>
      </fo:flow>
    </fo:page-sequence>
  </xsl:if>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="part" mode="part.titlepage.mode">
  <!-- done this way to force the context node to be the part -->
  <xsl:call-template name="part.titlepage"/>
</xsl:template>

<xsl:template match="part/docinfo|partinfo"></xsl:template>
<xsl:template match="part/title"></xsl:template>
<xsl:template match="part/subtitle"></xsl:template>

<xsl:template match="part/partintro">
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="ancestor::part"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="master-name">
    <xsl:call-template name="select.pagemaster"/>
  </xsl:variable>

  <fo:page-sequence id="{$id}"
                    hyphenate="{$hyphenate}"
                    master-name="{$master-name}">
    <xsl:attribute name="language">
      <xsl:call-template name="l10n.language"/>
    </xsl:attribute>
    <xsl:if test="$double.sided != 0">
      <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
    </xsl:if>

    <xsl:apply-templates select="." mode="running.head.mode">
      <xsl:with-param name="master-name" select="$master-name"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="." mode="running.foot.mode">
      <xsl:with-param name="master-name" select="$master-name"/>
    </xsl:apply-templates>

    <fo:flow flow-name="xsl-region-body">
      <xsl:apply-templates select=".." mode="part.titlepage.mode"/>
      <xsl:if test="title">
        <xsl:call-template name="partintro.titlepage"/>
      </xsl:if>
      <xsl:apply-templates/>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template match="partintro/title"></xsl:template>
<xsl:template match="partintro/subtitle"></xsl:template>
<xsl:template match="partintro/titleabbrev"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="book" mode="division.number">
  <xsl:number from="set" count="book" format="1."/>
</xsl:template>

<xsl:template match="part" mode="division.number">
  <xsl:number from="book" count="part" format="I."/>
</xsl:template>

</xsl:stylesheet>

