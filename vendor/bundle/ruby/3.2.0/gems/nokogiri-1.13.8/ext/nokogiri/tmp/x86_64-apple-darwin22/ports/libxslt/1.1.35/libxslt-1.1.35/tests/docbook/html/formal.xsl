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

<xsl:template name="formal.object">
  <div class="{name(.)}">
    <xsl:call-template name="formal.object.heading">
       <xsl:with-param name="title">
         <xsl:apply-templates select="." mode="title.markup"/>
       </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template name="formal.object.heading">
  <p>
    <a>
      <xsl:attribute name="name">
	<xsl:call-template name="object.id"/>
      </xsl:attribute>
    </a>
    <b><xsl:apply-templates select="." mode="object.title.markup"/></b>
  </p>
</xsl:template>

<xsl:template name="informal.object">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <div class="{name(.)}" id="{$id}">
    <xsl:if test="$spacing.paras != 0"><p/></xsl:if>
    <a name="{$id}"/>
    <xsl:apply-templates/>
    <xsl:if test="$spacing.paras != 0"><p/></xsl:if>
  </div>
</xsl:template>

<xsl:template name="semiformal.object">
  <xsl:choose>
    <xsl:when test="title">
      <xsl:call-template name="formal.object"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="informal.object"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="figure|table|example">
  <xsl:call-template name="formal.object"/>
</xsl:template>

<xsl:template match="equation">
  <xsl:call-template name="semiformal.object"/>
</xsl:template>

<xsl:template match="figure/title"></xsl:template>
<xsl:template match="table/title"></xsl:template>
<xsl:template match="example/title"></xsl:template>
<xsl:template match="equation/title"></xsl:template>

<xsl:template match="informalfigure">
  <xsl:call-template name="informal.object"/>
</xsl:template>

<xsl:template match="informalexample">
  <xsl:call-template name="informal.object"/>
</xsl:template>

<xsl:template match="informaltable">
  <xsl:call-template name="informal.object"/>
</xsl:template>

<xsl:template match="informalequation">
  <xsl:call-template name="informal.object"/>
</xsl:template>

</xsl:stylesheet>
