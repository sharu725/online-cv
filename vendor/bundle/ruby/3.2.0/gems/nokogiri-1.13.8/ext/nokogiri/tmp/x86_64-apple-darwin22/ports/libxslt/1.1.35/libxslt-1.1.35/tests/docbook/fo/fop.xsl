<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xml.apache.org/fop/extensions"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************
     (c) Stephane Bline Peregrine Systems 2001
     Driver file to allow pdf bookmarking (based on fop implementation).
     ******************************************************************** -->

<xsl:template match="set" mode="outline">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fox:outline internal-destination="{$id}">
    <fox:label>
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:apply-templates select="." mode="title.markup"/>
    </fox:label>

  <xsl:if test="book">
      <xsl:apply-templates select="book"
                           mode="outline"/>
  </xsl:if>
  </fox:outline>
</xsl:template>

<xsl:template match="book" mode="outline">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fox:outline internal-destination="{$id}">
    <fox:label>
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:apply-templates select="." mode="title.markup"/>
    </fox:label>

  <xsl:if test="part|preface|chapter|appendix">
      <xsl:apply-templates select="part|preface|chapter|appendix"
                           mode="outline"/>
  </xsl:if>
  </fox:outline>
</xsl:template>


<xsl:template match="part" mode="outline">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fox:outline internal-destination="{$id}">
    <fox:label>
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:apply-templates select="." mode="title.markup"/>
    </fox:label>

  <xsl:if test="chapter|appendix|preface|reference">
      <xsl:apply-templates select="chapter|appendix|preface|reference"
                           mode="outline"/>
  </xsl:if>
  </fox:outline>
</xsl:template>

<xsl:template match="preface|chapter|appendix"
              mode="outline">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fox:outline internal-destination="{$id}">
    <fox:label>
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:apply-templates select="." mode="title.markup"/>
    </fox:label>

  <xsl:if test="section|sect1">
      <xsl:apply-templates select="section|sect1"
                           mode="outline"/>
  </xsl:if>
  </fox:outline>
</xsl:template>

<xsl:template match="section|sect1|sect2|sect3|sect4|sect5"
              mode="outline">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fox:outline internal-destination="{$id}">
    <fox:label>
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:apply-templates select="." mode="title.markup"/>
    </fox:label>

  <xsl:if test="section|sect2|sect3|sect4|sect5">
      <xsl:apply-templates select="section|sect2|sect3|sect4|sect5"
                           mode="outline"/>
  </xsl:if>
  </fox:outline>
</xsl:template>

<xsl:template match="bibliography|glossary|index"
              mode="outline">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fox:outline internal-destination="{$id}">
    <fox:label>
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:apply-templates select="." mode="title.markup"/>
    </fox:label>
  </fox:outline>
</xsl:template>

<xsl:template match="title" mode="outline">
  <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>

