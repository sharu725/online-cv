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

<!-- These templates define the "default behavior" for info
     elements.  Even if you don't process the *info wrappers,
     some of these elements are needed because the elements are
     processed from named templates that are called with modes.
     Since modes aren't sticky, these rules apply. 
     (TODO: clarify this comment) -->

<!-- ==================================================================== -->
<!-- called from named templates in a given mode -->

<xsl:template match="corpauthor">
  <span class="{name(.)}">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="jobtitle">
  <span class="{name(.)}">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="orgname">
  <span class="{name(.)}">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="orgdiv">
  <span class="{name(.)}">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
