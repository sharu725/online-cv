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

<xsl:param name="autotoc.label.separator" select="' '"/>

<xsl:template name="href.target">
  <xsl:param name="object" select="."/>
  <xsl:text>#</xsl:text>
  <xsl:call-template name="object.id">
    <xsl:with-param name="object" select="$object"/>
  </xsl:call-template>
</xsl:template>

<xsl:variable name="toc.listitem.type">
  <xsl:choose>
    <xsl:when test="$toc.list.type = 'dl'">dt</xsl:when>
    <xsl:otherwise>li</xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- this is just hack because dl and ul aren't completely isomorphic -->
<xsl:variable name="toc.dd.type">
  <xsl:choose>
    <xsl:when test="$toc.list.type = 'dl'">dd</xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:template name="set.toc">
  <xsl:variable name="nodes" select="book|setindex"/>
  <xsl:if test="$nodes">
    <div class="toc">
      <p>
        <b>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">TableofContents</xsl:with-param>
          </xsl:call-template>
        </b>
      </p>
      <xsl:element name="{$toc.list.type}">
        <xsl:apply-templates select="$nodes" mode="toc"/>
      </xsl:element>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="division.toc">
  <xsl:if test="$generate.division.toc != 0">
    <xsl:variable name="nodes" select="part|reference
                                       |preface|chapter|appendix
                                       |article
                                       |bibliography|glossary|index
                                       |refentry
                                       |bridgehead"/>
    <xsl:if test="$nodes">
      <div class="toc">
        <p>
          <b>
           <xsl:call-template name="gentext">
             <xsl:with-param name="key">TableofContents</xsl:with-param>
           </xsl:call-template>
          </b>
        </p>
        <xsl:element name="{$toc.list.type}">
          <xsl:apply-templates select="$nodes" mode="toc"/>
        </xsl:element>
      </div>
    </xsl:if>
  </xsl:if>
</xsl:template>

<xsl:template name="component.toc">
  <xsl:if test="$generate.component.toc != 0">
    <xsl:variable name="nodes" select="section|sect1|refentry
                                       |article|bibliography|glossary
                                       |appendix|bridgehead[not(@renderas)]
                                       |.//bridgehead[@renderas='sect1']"/>
    <xsl:if test="$nodes">
      <div class="toc">
        <p>
          <b>
           <xsl:call-template name="gentext">
             <xsl:with-param name="key">TableofContents</xsl:with-param>
           </xsl:call-template>
          </b>
        </p>
        <xsl:element name="{$toc.list.type}">
          <xsl:apply-templates select="$nodes" mode="toc"/>
        </xsl:element>
      </div>
    </xsl:if>
  </xsl:if>
</xsl:template>

<xsl:template name="section.toc">
  <xsl:variable name="nodes"
                select="section|sect1|sect2|sect3|sect4|sect5|refentry
                        |bridgehead"/>
  <xsl:if test="$nodes">
    <div class="toc">
      <p>
        <b>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">TableofContents</xsl:with-param>
          </xsl:call-template>
        </b>
      </p>
      <xsl:element name="{$toc.list.type}">
        <xsl:apply-templates select="$nodes" mode="toc"/>
      </xsl:element>
    </div>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="book|setindex" mode="toc">
  <xsl:variable name="nodes" select="part|reference
                                     |preface|chapter|appendix
                                     |article
                                     |bibliography|glossary|index
                                     |refentry
                                     |bridgehead"/>

  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:apply-templates mode="toc" select="$nodes"/>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:value-of select="$autotoc.label.separator"/>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
    <xsl:if test="$toc.listitem.type = 'li'
                  and $toc.section.depth>0 and count($nodes)&gt;0">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if>
  </xsl:element>
  <xsl:if test="$toc.listitem.type != 'li'
                and $toc.section.depth>0 and count($nodes)&gt;0">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if>
</xsl:template>

<xsl:template match="part|reference" mode="toc">
  <xsl:variable name="nodes" select="appendix|chapter|article
                                     |index|glossary|bibliography
                                     |preface|reference|refentry
                                     |bridgehead"/>

  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:apply-templates select="$nodes" mode="toc"/>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:value-of select="$autotoc.label.separator"/>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
    <xsl:if test="$toc.listitem.type = 'li'
                  and $toc.section.depth>0 and count($nodes) &gt; 0">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if>
  </xsl:element>
  <xsl:if test="$toc.listitem.type != 'li'
                and $toc.section.depth>0 and count($nodes) &gt; 0">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if>
</xsl:template>

<xsl:template match="preface|chapter|appendix|article" mode="toc">
  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:apply-templates select="section|sect1|bridgehead" mode="toc"/>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:value-of select="$autotoc.label.separator"/>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
    <xsl:if test="$toc.listitem.type = 'li'
                  and $toc.section.depth>0 and section|sect1">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if>
  </xsl:element>
  <xsl:if test="$toc.listitem.type != 'li'
                and $toc.section.depth>0 and section|sect1">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if>
</xsl:template>

<xsl:template match="sect1" mode="toc">
  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:apply-templates select="sect2|bridgehead" mode="toc"/>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:value-of select="$autotoc.label.separator"/>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
    <xsl:if test="$toc.listitem.type = 'li'
                  and $toc.section.depth>1 and sect2">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if>
  </xsl:element>
  <xsl:if test="$toc.listitem.type != 'li'
                and $toc.section.depth>1 and sect2">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if>
</xsl:template>

<xsl:template match="sect2" mode="toc">
  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:apply-templates select="sect3|bridgehead" mode="toc"/>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:value-of select="$autotoc.label.separator"/>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
    <xsl:if test="$toc.listitem.type = 'li'
                  and $toc.section.depth>2 and sect3">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if>
  </xsl:element>
  <xsl:if test="$toc.listitem.type != 'li'
                and $toc.section.depth>2 and sect3">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if>
</xsl:template>

<xsl:template match="sect3" mode="toc">
  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:apply-templates select="sect4|bridgehead" mode="toc"/>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:value-of select="$autotoc.label.separator"/>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
    <xsl:if test="$toc.listitem.type = 'li'
                  and $toc.section.depth>3 and sect4">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if>
  </xsl:element>
  <xsl:if test="$toc.listitem.type != 'li'
                and $toc.section.depth>3 and sect4">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if>
</xsl:template>

<xsl:template match="sect4" mode="toc">
  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:apply-templates select="sect5|bridgehead" mode="toc"/>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:value-of select="$autotoc.label.separator"/>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
    <xsl:if test="$toc.listitem.type = 'li'
                  and $toc.section.depth>4 and sect5">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if>
  </xsl:element>
  <xsl:if test="$toc.listitem.type != 'li'
                and $toc.section.depth>4 and sect5">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if>
</xsl:template>

<xsl:template match="sect5" mode="toc">
  <xsl:element name="{$toc.listitem.type}">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:value-of select="$autotoc.label.separator"/>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
  </xsl:element>
</xsl:template>

<xsl:template match="section" mode="toc">
  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:apply-templates select="section|bridgehead" mode="toc"/>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="toodeep">
    <xsl:choose>
      <!-- if the depth is less than 2, we're already deep enough -->
      <xsl:when test="$toc.section.depth &lt; 2">yes</xsl:when>
      <!-- if the current section has n-1 section ancestors -->
      <!-- then we've already reached depth n -->
      <xsl:when test="ancestor::section[position()=$toc.section.depth - 1]">
        <xsl:text>yes</xsl:text>
      </xsl:when>
      <!-- otherwise, keep going -->
      <xsl:otherwise>no</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:value-of select="$autotoc.label.separator"/>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
    <xsl:if test="$toc.listitem.type = 'li'
                  and $toodeep='no' and section">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if>
  </xsl:element>
  <xsl:if test="$toc.listitem.type != 'li'
                and $toodeep='no' and section">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if>
</xsl:template>

<xsl:template match="bridgehead" mode="toc">
  <xsl:if test="$bridgehead.in.toc != 0">
    <xsl:element name="{$toc.listitem.type}">
      <xsl:apply-templates select="." mode="label.markup"/>
      <xsl:value-of select="$autotoc.label.separator"/>
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target"/>
        </xsl:attribute>
        <xsl:apply-templates/>
      </a>
    </xsl:element>
  </xsl:if>
</xsl:template>

<xsl:template match="bibliography|glossary" mode="toc">
  <xsl:element name="{$toc.listitem.type}">
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
  </xsl:element>
</xsl:template>

<xsl:template match="index" mode="toc">
  <!-- If the index tag is empty, don't point at it from the TOC -->
  <xsl:if test="* or $generate.index">
    <xsl:element name="{$toc.listitem.type}">
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target"/>
        </xsl:attribute>
        <xsl:apply-templates select="." mode="title.markup"/>
      </a>
    </xsl:element>
  </xsl:if>
</xsl:template>

<xsl:template match="refentry" mode="toc">
  <xsl:variable name="refmeta" select=".//refmeta"/>
  <xsl:variable name="refentrytitle" select="$refmeta//refentrytitle"/>
  <xsl:variable name="refnamediv" select=".//refnamediv"/>
  <xsl:variable name="refname" select="$refnamediv//refname"/>
  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="$refentrytitle">
        <xsl:apply-templates select="$refentrytitle[1]" mode="title"/>
      </xsl:when>
      <xsl:when test="$refname">
        <xsl:apply-templates select="$refname[1]" mode="title"/>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:copy-of select="$title"/>
    </a>
  </xsl:element>
</xsl:template>

<xsl:template match="title" mode="toc">
  <a>
    <xsl:attribute name="href">
      <xsl:call-template name="href.target">
        <xsl:with-param name="object" select=".."/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:apply-templates/>
  </a>
</xsl:template>

</xsl:stylesheet>

