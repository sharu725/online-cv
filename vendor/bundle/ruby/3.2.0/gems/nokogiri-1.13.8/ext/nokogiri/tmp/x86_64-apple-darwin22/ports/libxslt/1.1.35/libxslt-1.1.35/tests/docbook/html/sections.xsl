<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<!-- ==================================================================== -->

<xsl:template match="section">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <a name="{$id}"/>
    <xsl:call-template name="section.titlepage"/>
    <xsl:if test="$generate.section.toc != '0'
                  or refentry">
      <xsl:call-template name="section.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:call-template name="process.chunk.footnotes"/>
  </div>
</xsl:template>

<xsl:template name="section.title">
  <!-- the context node should be the title of a section when called -->
  <xsl:variable name="section" select="(ancestor::section
                                        |ancestor::simplesect
                                        |ancestor::sect1
                                        |ancestor::sect2
                                        |ancestor::sect3
                                        |ancestor::sect4
                                        |ancestor::sect5)[last()]"/>

  <xsl:variable name="level">
    <xsl:call-template name="section.level">
      <xsl:with-param name="node" select="$section"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:call-template name="section.heading">
    <xsl:with-param name="section" select=".."/>
    <xsl:with-param name="level" select="$level"/>
    <xsl:with-param name="title">
      <xsl:apply-templates select="$section" mode="object.title.markup"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="title" mode="section.titlepage.recto.mode">
  <xsl:call-template name="section.title"/>
</xsl:template>

<xsl:template match="x-title" mode="section.titlepage.recto.mode">
  <xsl:variable name="section" select="(ancestor::section
                                        |ancestor::simplesect
                                        |ancestor::sect1
                                        |ancestor::sect2
                                        |ancestor::sect3
                                        |ancestor::sect4
                                        |ancestor::sect5)[last()]"/>

  <xsl:variable name="level">
    <xsl:call-template name="section.level">
      <xsl:with-param name="node" select="$section"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:message>Level: <xsl:value-of select="$level"/>: <xsl:value-of select="."/></xsl:message>

  <xsl:element name="h{$level}">
    <xsl:attribute name="class">title</xsl:attribute>
    <xsl:if test="$css.decoration != '0'">
      <xsl:if test="$level&lt;3">
        <xsl:attribute name="style">clear: both</xsl:attribute>
      </xsl:if>
    </xsl:if>
    <a>
      <xsl:attribute name="name">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="$section"/>
        </xsl:call-template>
      </xsl:attribute>
    </a>
    <xsl:apply-templates select="$section" mode="object.title.markup"/>
  </xsl:element>
</xsl:template>

<xsl:template match="sect1">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <a name="{$id}"/>
    <xsl:call-template name="sect1.titlepage"/>
    <xsl:if test="$generate.section.toc != '0'
                  or refentry">
      <xsl:call-template name="section.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:call-template name="process.chunk.footnotes"/>
  </div>
</xsl:template>

<xsl:template match="title" mode="sect1.titlepage.recto.mode">
  <xsl:call-template name="section.title"/>
</xsl:template>

<xsl:template match="sect2">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <a name="{$id}"/>
    <xsl:call-template name="sect2.titlepage"/>
    <xsl:if test="$generate.section.toc != '0'
                  or refentry">
      <xsl:call-template name="section.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="title" mode="sect2.titlepage.recto.mode">
  <xsl:call-template name="section.title"/>
</xsl:template>

<xsl:template match="sect3">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <a name="{$id}"/>
    <xsl:call-template name="sect3.titlepage"/>

    <xsl:if test="$generate.section.toc != '0'
                  or refentry">
      <xsl:call-template name="section.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="title" mode="sect3.titlepage.recto.mode">
  <xsl:call-template name="section.title"/>
</xsl:template>

<xsl:template match="sect4">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <a name="{$id}"/>
    <xsl:call-template name="sect4.titlepage"/>
    <xsl:if test="$generate.section.toc != '0'
                  or refentry">
      <xsl:call-template name="section.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="title" mode="sect4.titlepage.recto.mode">
  <xsl:call-template name="section.title"/>
</xsl:template>

<xsl:template match="sect5">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <a name="{$id}"/>
    <xsl:call-template name="sect5.titlepage"/>
    <xsl:if test="$generate.section.toc != '0'
                  or refentry">
      <xsl:call-template name="section.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="title" mode="sect5.titlepage.recto.mode">
  <xsl:call-template name="section.title"/>
</xsl:template>

<xsl:template match="simplesect">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <a name="{$id}"/>
    <xsl:call-template name="simplesect.titlepage"/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="title" mode="simplesect.titlepage.recto.mode">
  <xsl:call-template name="section.title"/>
</xsl:template>

<xsl:template match="section/title"></xsl:template>
<xsl:template match="section/subtitle"></xsl:template>
<xsl:template match="sectioninfo"></xsl:template>

<xsl:template match="sect1/title"></xsl:template>
<xsl:template match="sect1/subtitle"></xsl:template>
<xsl:template match="sect1info"></xsl:template>

<xsl:template match="sect2/title"></xsl:template>
<xsl:template match="sect2/subtitle"></xsl:template>
<xsl:template match="sect2info"></xsl:template>

<xsl:template match="sect3/title"></xsl:template>
<xsl:template match="sect3/subtitle"></xsl:template>
<xsl:template match="sect3info"></xsl:template>

<xsl:template match="sect4/title"></xsl:template>
<xsl:template match="sect4/subtitle"></xsl:template>
<xsl:template match="sect4info"></xsl:template>

<xsl:template match="sect5/title"></xsl:template>
<xsl:template match="sect5/subtitle"></xsl:template>
<xsl:template match="sect5info"></xsl:template>

<xsl:template match="simplesect/title"></xsl:template>
<xsl:template match="simplesect/subtitle"></xsl:template>

<!-- ==================================================================== -->

<xsl:template name="section.heading">
  <xsl:param name="section" select="."/>
  <xsl:param name="level" select="'1'"/>
  <xsl:param name="title"/>
  <xsl:element name="h{$level}">
    <xsl:attribute name="class">title</xsl:attribute>
    <xsl:if test="$css.decoration != '0'">
      <xsl:if test="$level&lt;3">
        <xsl:attribute name="style">clear: both</xsl:attribute>
      </xsl:if>
    </xsl:if>
    <a>
      <xsl:attribute name="name">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="$section"/>
        </xsl:call-template>
      </xsl:attribute>
    </a>
    <xsl:copy-of select="$title"/>
  </xsl:element>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="bridgehead">
  <xsl:variable name="container"
                select="(ancestor::appendix
                        |ancestor::article
                        |ancestor::bibliography
                        |ancestor::chapter
                        |ancestor::glossary
                        |ancestor::glossdiv
                        |ancestor::index
                        |ancestor::partintro
                        |ancestor::preface
                        |ancestor::refsect1
                        |ancestor::refsect2
                        |ancestor::refsect3
                        |ancestor::sect1
                        |ancestor::sect2
                        |ancestor::sect3
                        |ancestor::sect4
                        |ancestor::sect5
                        |ancestor::section
                        |ancestor::setindex
                        |ancestor::simplesect)[last()]"/>

  <xsl:variable name="clevel">
    <xsl:choose>
      <xsl:when test="local-name($container) = 'appendix'
                      or local-name($container) = 'chapter'
                      or local-name($container) = 'article'
                      or local-name($container) = 'bibliography'
                      or local-name($container) = 'glossary'
                      or local-name($container) = 'index'
                      or local-name($container) = 'partintro'
                      or local-name($container) = 'preface'
                      or local-name($container) = 'setindex'">2</xsl:when>
      <xsl:when test="local-name($container) = 'glossdiv'">
        <xsl:value-of select="count(ancestor::glossdiv)+2"/>
      </xsl:when>
      <xsl:when test="local-name($container) = 'sect1'
                      or local-name($container) = 'sect2'
                      or local-name($container) = 'sect3'
                      or local-name($container) = 'sect4'
                      or local-name($container) = 'sect5'
                      or local-name($container) = 'refsect1'
                      or local-name($container) = 'refsect2'
                      or local-name($container) = 'refsect3'
                      or local-name($container) = 'section'
                      or local-name($container) = 'simplesect'">
        <xsl:variable name="slevel">
          <xsl:call-template name="section.level">
            <xsl:with-param name="node" select="$container"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$slevel + 1"/>
      </xsl:when>
      <xsl:otherwise>2</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="level">
    <xsl:choose>
      <xsl:when test="@renderas = 'sect1'">2</xsl:when>
      <xsl:when test="@renderas = 'sect2'">3</xsl:when>
      <xsl:when test="@renderas = 'sect3'">4</xsl:when>
      <xsl:when test="@renderas = 'sect4'">5</xsl:when>
      <xsl:when test="@renderas = 'sect5'">6</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$clevel"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="h{$level}">
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>

