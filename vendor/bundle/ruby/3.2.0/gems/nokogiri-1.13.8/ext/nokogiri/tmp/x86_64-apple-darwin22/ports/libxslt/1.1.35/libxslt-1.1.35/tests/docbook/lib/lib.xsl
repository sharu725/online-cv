<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     This module implements DTD-independent functions

     ******************************************************************** -->

<doc:reference xmlns="">
<referenceinfo>
<releaseinfo role="meta">
$Id$
</releaseinfo>
<author><surname>Walsh</surname>
<firstname>Norman</firstname></author>
<copyright><year>1999</year><year>2000</year>
<holder>Norman Walsh</holder>
</copyright>
</referenceinfo>
<title>Library Template Reference</title>

<partintro>
<section><title>Introduction</title>

<para>This is technical reference documentation for the DocBook XSL
Stylesheets; it documents (some of) the parameters, templates, and
other elements of the stylesheets.</para>

<para>This is not intended to be <quote>user</quote> documentation.
It is provided for developers writing customization layers for the
stylesheets, and for anyone who's interested in <quote>how it
works</quote>.</para>

<para>Although I am trying to be thorough, this documentation is known
to be incomplete. Don't forget to read the source, too :-)</para>
</section>
</partintro>
</doc:reference>

<xsl:template name="dot.count">
  <!-- Returns the number of "." characters in a string -->
  <xsl:param name="string"></xsl:param>
  <xsl:param name="count" select="0"/>
  <xsl:choose>
    <xsl:when test="contains($string, '.')">
      <xsl:call-template name="dot.count">
        <xsl:with-param name="string" select="substring-after($string, '.')"/>
        <xsl:with-param name="count" select="$count+1"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$count"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ================================================================== -->

<xsl:template name="copy-string">
  <!-- returns 'count' copies of 'string' -->
  <xsl:param name="string"></xsl:param>
  <xsl:param name="count" select="0"/>
  <xsl:param name="result"></xsl:param>

  <xsl:choose>
    <xsl:when test="$count>0">
      <xsl:call-template name="copy-string">
        <xsl:with-param name="string" select="$string"/>
        <xsl:with-param name="count" select="$count - 1"/>
        <xsl:with-param name="result">
          <xsl:value-of select="$result"/>
          <xsl:value-of select="$string"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$result"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ====================================================================== -->

<doc:template name="string.subst" xmlns="">
<refpurpose>Substitute one text string for another in a string</refpurpose>
<refdescription>
<para>The <function>string.subst</function> template replaces all
occurances of <parameter>target</parameter> in <parameter>string</parameter>
with <parameter>replacement</parameter> and returns the result.
</para>
</refdescription>
</doc:template>

<xsl:template name="string.subst">
  <xsl:param name="string"></xsl:param>
  <xsl:param name="target"></xsl:param>
  <xsl:param name="replacement"></xsl:param>

  <xsl:choose>
    <xsl:when test="contains($string, $target)">
      <xsl:variable name="rest">
        <xsl:call-template name="string.subst">
          <xsl:with-param name="string"
                          select="substring-after($string, $target)"/>
          <xsl:with-param name="target" select="$target"/>
          <xsl:with-param name="replacement" select="$replacement"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="concat(substring-before($string, $target),
                                   $replacement,
                                   $rest)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$string"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ================================================================== -->

<doc:template name="xpointer.idref" xmlns="">
<refpurpose>Extract IDREF from an XPointer</refpurpose>
<refdescription>
<para>The <function>xpointer.idref</function> template returns the
ID portion of an XPointer which is a pointer to an ID within the current
document, or the empty string if it is not.</para>
<para>In other words, <function>xpointer.idref</function> returns
<quote>foo</quote> when passed either <literal>#foo</literal>
or <literal>#xpointer(id('foo'))</literal>, otherwise it returns
the empty string.</para>
</refdescription>
</doc:template>

<xsl:template name="xpointer.idref">
  <xsl:param name="xpointer">http://...</xsl:param>
  <xsl:choose>
    <xsl:when test="starts-with($xpointer, '#xpointer(id(')">
      <xsl:variable name="rest" select="substring-after($xpointer, '#xpointer(id(')"/>
      <xsl:variable name="quote" select="substring($rest, 1, 1)"/>
      <xsl:value-of select="substring-before(substring-after($xpointer, $quote), $quote)"/>
    </xsl:when>
    <xsl:when test="starts-with($xpointer, '#')">
      <xsl:value-of select="substring-after($xpointer, '#')"/>
    </xsl:when>
    <!-- otherwise it's a pointer to some other document -->
  </xsl:choose>
</xsl:template>

<!-- ================================================================== -->

<doc:template name="length-magnitude" xmlns="">
<refpurpose>Return the unqualified dimension from a length specification</refpurpose>
<refdescription>
<para>The <function>length-magnitude</function> template returns the
unqualified length ("20" for "20pt") from a dimension.
</para>
</refdescription>
</doc:template>

<xsl:template name="length-magnitude">
  <xsl:param name="length" select="'0pt'"/>

  <xsl:choose>
    <xsl:when test="string-length($length) = 0"/>
    <xsl:when test="substring($length,1,1) = '0'
                    or substring($length,1,1) = '1'
                    or substring($length,1,1) = '2'
                    or substring($length,1,1) = '3'
                    or substring($length,1,1) = '4'
                    or substring($length,1,1) = '5'
                    or substring($length,1,1) = '6'
                    or substring($length,1,1) = '7'
                    or substring($length,1,1) = '8'
                    or substring($length,1,1) = '9'
                    or substring($length,1,1) = '.'">
      <xsl:value-of select="substring($length,1,1)"/>
      <xsl:call-template name="length-magnitude">
        <xsl:with-param name="length" select="substring($length,2)"/>
      </xsl:call-template>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<!-- ================================================================== -->

<doc:template name="length-spec" xmlns="">
<refpurpose>Return a fully qualified length specification</refpurpose>
<refdescription>
<para>The <function>length-spec</function> template returns the
qualified length from a dimension. If an unqualified length is given,
the <parameter>default.units</parameter> will be added to it.
</para>
</refdescription>
</doc:template>

<xsl:template name="length-spec">
  <xsl:param name="length" select="'0pt'"/>
  <xsl:param name="default.units" select="'pt'"/>
  <xsl:variable name="magnitude">
    <xsl:call-template name="length-magnitude">
      <xsl:with-param name="length" select="$length"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="units">
    <xsl:value-of select="substring($length, string-length($magnitude)+1)"/>
  </xsl:variable>

  <xsl:value-of select="$magnitude"/>
  <xsl:choose>
    <xsl:when test="$units='cm'
                    or $units='mm'
                    or $units='in'
                    or $units='pt'
                    or $units='pc'
                    or $units='px'
                    or $units='em'">
      <xsl:value-of select="$units"/>
    </xsl:when>
    <xsl:when test="$units = ''">
      <xsl:value-of select="$default.units"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>
        <xsl:text>Unrecognized unit of measure: </xsl:text>
        <xsl:value-of select="$units"/>
        <xsl:text>.</xsl:text>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
