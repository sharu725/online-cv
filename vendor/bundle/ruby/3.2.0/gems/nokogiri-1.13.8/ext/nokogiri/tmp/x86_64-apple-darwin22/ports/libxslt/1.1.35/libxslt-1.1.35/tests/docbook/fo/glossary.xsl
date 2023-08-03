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

<xsl:variable name="glossterm-width">2in</xsl:variable>
<xsl:variable name="glossterm-sep">0.25in</xsl:variable>

<!-- ==================================================================== -->

<xsl:template match="glossary">
  <xsl:variable name="divs" select="glossdiv"/>
  <xsl:variable name="entries" select="glossentry"/>
  <xsl:variable name="preamble"
                select="*[not(self::title
                            or self::subtitle
                            or self::glossdiv
                            or self::glossentry)]"/>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block id="{$id}">
    <xsl:call-template name="component.separator"/>

    <xsl:call-template name="glossary.titlepage"/>

    <xsl:if test="$preamble">
      <xsl:apply-templates select="$preamble"/>
    </xsl:if>

    <xsl:if test="$divs">
      <xsl:apply-templates select="$divs"/>
    </xsl:if>

    <xsl:if test="$entries">
      <fo:list-block provisional-distance-between-starts="{$glossterm-width}"
                     provisional-label-separation="{$glossterm-sep}"
                     xsl:use-attribute-sets="normal.para.spacing">
        <xsl:apply-templates select="$entries"/>
      </fo:list-block>
    </xsl:if>
  </fo:block>
</xsl:template>

<xsl:template match="book/glossary">
  <xsl:variable name="divs" select="glossdiv"/>
  <xsl:variable name="entries" select="glossentry"/>
  <xsl:variable name="preamble"
                select="*[not(self::title
                            or self::subtitle
                            or self::glossdiv
                            or self::glossentry)]"/>

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
      <xsl:call-template name="glossary.titlepage"/>

      <xsl:if test="$preamble">
        <xsl:apply-templates select="$preamble"/>
      </xsl:if>

      <xsl:if test="$divs">
        <xsl:apply-templates select="$divs"/>
      </xsl:if>

      <xsl:if test="$entries">
        <fo:list-block provisional-distance-between-starts="{$glossterm-width}"
                       provisional-label-separation="{$glossterm-sep}"
                       xsl:use-attribute-sets="normal.para.spacing">
          <xsl:apply-templates select="$entries"/>
        </fo:list-block>
      </xsl:if>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template match="glossary/glossaryinfo"></xsl:template>
<xsl:template match="glossary/title"></xsl:template>
<xsl:template match="glossary/subtitle"></xsl:template>
<xsl:template match="glossary/titleabbrev"></xsl:template>

<xsl:template match="glossary/title" mode="component.title.mode">
  <fo:block font-size="18pt"
            font-weight="bold"
            keep-with-next.within-column="always"
            hyphenate="false">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="glossary/subtitle" mode="component.title.mode">
  <fo:block font-size="16pt"
            font-weight="bold"
            font-style="italic"
            keep-with-next.within-column="always"
            hyphenate="false">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="glosslist">
  <fo:list-block provisional-distance-between-starts="{$glossterm-width}"
                 provisional-label-separation="{$glossterm-sep}"
                 xsl:use-attribute-sets="normal.para.spacing">
      <xsl:apply-templates/>
    </fo:list-block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="glossdiv">
  <xsl:variable name="entries" select="glossentry"/>
  <xsl:variable name="preamble"
                select="*[not(self::title
                            or self::subtitle
                            or self::glossentry)]"/>

  <xsl:apply-templates select="title|subtitle"/>
  <xsl:apply-templates select="$preamble"/>
  <fo:list-block provisional-distance-between-starts="{$glossterm-width}"
                 provisional-label-separation="{$glossterm-sep}"
                 xsl:use-attribute-sets="normal.para.spacing">
    <xsl:apply-templates select="$entries"/>
  </fo:list-block>
</xsl:template>

<xsl:template match="glossdiv/title">
  <fo:block font-size="16pt" font-weight="bold">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<!--
GlossEntry ::=
  GlossTerm, Acronym?, Abbrev?,
  (IndexTerm)*,
  RevHistory?,
  (GlossSee | GlossDef+)
-->

<xsl:template match="glossentry">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:list-item id="{$id}"
                xsl:use-attribute-sets="normal.para.spacing">
    <xsl:apply-templates/>
  </fo:list-item>
</xsl:template>

<xsl:template match="glossentry/glossterm">
  <fo:list-item-label end-indent="label-end()">
    <fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </fo:list-item-label>
</xsl:template>

<xsl:template match="glossentry/acronym">
</xsl:template>

<xsl:template match="glossentry/abbrev">
</xsl:template>

<xsl:template match="glossentry/revhistory">
</xsl:template>

<xsl:template match="glossentry/glosssee">
  <xsl:variable name="otherterm" select="@otherterm"/>
  <xsl:variable name="targets" select="//node()[@id=$otherterm]"/>
  <xsl:variable name="target" select="$targets[1]"/>
  <fo:list-item-body start-indent="body-start()">
    <fo:block>
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'glossary'"/>
        <xsl:with-param name="name" select="'see'"/>
      </xsl:call-template>
      <xsl:choose>
        <xsl:when test="@otherterm">
          <xsl:apply-templates select="$target" mode="xref"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>.</xsl:text>
    </fo:block>
  </fo:list-item-body>
</xsl:template>

<xsl:template match="glossentry/glossdef">
  <fo:list-item-body start-indent="body-start()">
    <xsl:apply-templates select="*[local-name(.) != 'glossseealso']"/>
    <xsl:if test="glossseealso">
      <fo:block>
        <xsl:call-template name="gentext.template">
          <xsl:with-param name="context" select="'glossary'"/>
          <xsl:with-param name="name" select="'seealso'"/>
        </xsl:call-template>
        <xsl:apply-templates select="glossseealso"/>
      </fo:block>
    </xsl:if>
  </fo:list-item-body>
</xsl:template>

<xsl:template match="glossentry/glossdef/para[1]">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="glossseealso">
  <xsl:variable name="otherterm" select="@otherterm"/>
  <xsl:variable name="targets" select="//node()[@id=$otherterm]"/>
  <xsl:variable name="target" select="$targets[1]"/>

  <xsl:choose>
    <xsl:when test="@otherterm">
      <xsl:apply-templates select="$target" mode="xref"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="position() = last()">
      <xsl:text>.</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>, </xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="glossentry" mode="xref">
  <xsl:apply-templates select="./glossterm[1]" mode="xref"/>
</xsl:template>

<xsl:template match="glossterm" mode="xref">
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="parent::glossentry"/>
    </xsl:call-template>
  </xsl:variable>

  <fo:basic-link internal-destination="{$id}"
                 xsl:use-attribute-sets="xref.properties">
    <xsl:apply-templates/>
    <xsl:call-template name="insert.page.citation">
      <xsl:with-param name="id" select="$id"/>
    </xsl:call-template>
  </fo:basic-link>
</xsl:template>


<!-- ==================================================================== -->

</xsl:stylesheet>
