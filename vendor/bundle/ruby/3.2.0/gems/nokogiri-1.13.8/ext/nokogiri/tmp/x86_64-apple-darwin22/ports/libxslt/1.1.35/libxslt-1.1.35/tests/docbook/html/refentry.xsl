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

<xsl:template match="reference">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <xsl:if test="@id">
      <a name="{$id}"/>
    </xsl:if>
    <xsl:call-template name="reference.titlepage"/>
    <xsl:if test="not(partintro) and $generate.reference.toc != '0'">
      <xsl:call-template name="division.toc"/>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="reference" mode="division.number">
  <xsl:number from="book" count="reference" format="I."/>
</xsl:template>

<xsl:template match="reference/docinfo"></xsl:template>
<xsl:template match="reference/referenceinfo"></xsl:template>
<xsl:template match="reference/title"></xsl:template>
<xsl:template match="reference/subtitle"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="refentry">
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

  <div class="{name(.)}">
    <h1 class="title">
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <xsl:copy-of select="$title"/>
    </h1>
    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </div>
</xsl:template>

<xsl:template match="refentry/docinfo|refentry/refentryinfo"></xsl:template>

<xsl:template match="refentrytitle|refname" mode="title">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="refmeta">
</xsl:template>

<xsl:template match="manvolnum">
  <xsl:if test="$refentry.xref.manvolnum != 0">
    <xsl:text>(</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>)</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="refmiscinfo">
</xsl:template>

<xsl:template match="refentrytitle">
  <xsl:call-template name="inline.charseq"/>
</xsl:template>

<xsl:template match="refnamediv">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="refname">
  <xsl:apply-templates/>
  <xsl:if test="following-sibling::refname">
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="refname[1]">
  <xsl:if test="$refentry.generate.name != 0">
    <h2>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'RefName'"/>
      </xsl:call-template>
    </h2>
  </xsl:if>
  <xsl:apply-templates/>
  <xsl:if test="following-sibling::refname">
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="refpurpose">
  <xsl:text> </xsl:text>
  <xsl:call-template name="dingbat">
    <xsl:with-param name="dingbat">em-dash</xsl:with-param>
  </xsl:call-template>
  <xsl:text> </xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="refdescriptor">
  <!-- todo: finish this -->
</xsl:template>

<xsl:template match="refclass">
  <p>
    <b>
      <xsl:if test="@role">
        <xsl:value-of select="@role"/>
        <xsl:text>: </xsl:text>
      </xsl:if>
      <xsl:apply-templates/>
    </b>
  </p>
</xsl:template>

<xsl:template match="refsynopsisdiv">
  <div class="{name(.)}">
    <a>
      <xsl:attribute name="name">
        <xsl:call-template name="object.id"/>
      </xsl:attribute>
    </a>
    <h2>Synopsis</h2>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="refsynopsisdivinfo"></xsl:template>

<xsl:template match="refsynopsisdiv/title">
</xsl:template>

<xsl:template match="refsect1|refsect2|refsect3">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="refsect1/title">
  <h2>
    <a>
      <xsl:attribute name="name">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="ancestor::refsect1"/>
        </xsl:call-template>
      </xsl:attribute>
    </a>
    <xsl:apply-templates/>
  </h2>
</xsl:template>

<xsl:template match="refsect2/title">
  <h3>
    <a>
      <xsl:attribute name="name">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="ancestor::refsect2"/>
        </xsl:call-template>
      </xsl:attribute>
    </a>
    <xsl:apply-templates/>
  </h3>
</xsl:template>

<xsl:template match="refsect3/title">
  <h4>
    <a>
      <xsl:attribute name="name">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="ancestor::refsect3"/>
        </xsl:call-template>
      </xsl:attribute>
    </a>
    <xsl:apply-templates/>
  </h4>
</xsl:template>

<xsl:template match="refsect1info"></xsl:template>
<xsl:template match="refsect2info"></xsl:template>
<xsl:template match="refsect3info"></xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
