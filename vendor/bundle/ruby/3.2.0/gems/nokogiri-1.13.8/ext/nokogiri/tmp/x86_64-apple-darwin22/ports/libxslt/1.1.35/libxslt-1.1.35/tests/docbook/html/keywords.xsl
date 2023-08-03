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

<xsl:template match="keywordset"></xsl:template>
<xsl:template match="subjectset"></xsl:template>

<!-- ==================================================================== -->

<xsl:template match="keywordset" mode="html.header">
  <meta name="keywords">
    <xsl:attribute name="content">
      <xsl:apply-templates select="keyword" mode="html.header"/>
    </xsl:attribute>
  </meta>
</xsl:template>

<xsl:template match="keyword[position()!=last()]" mode="html.header">
  <xsl:apply-templates/><xsl:text>, </xsl:text>
</xsl:template>

<xsl:template match="keyword[position()=last()]" mode="html.header">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
