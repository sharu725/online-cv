<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:mml="http://www.w3.org/1998/Math/MathML"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<xsl:template match="inlineequation">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="alt">
</xsl:template>

<!-- just send the MathML all the way through... -->
<xsl:template match="mml:*">
  <xsl:element name="{name(.)}">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates select="node()"/>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
