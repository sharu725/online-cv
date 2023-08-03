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

<xsl:template name="dingbat">
  <xsl:param name="dingbat">bullet</xsl:param>
  <xsl:choose>
    <xsl:when test="$dingbat='bullet'">o</xsl:when>
    <xsl:when test="$dingbat='copyright'">&#x00A9;</xsl:when>
    <xsl:when test="$dingbat='trademark'">&#x2122;</xsl:when>
    <xsl:when test="$dingbat='trade'">&#x2122;</xsl:when>
    <xsl:when test="$dingbat='registered'">&#x00AE;</xsl:when>
    <xsl:when test="$dingbat='service'">(SM)</xsl:when>
    <xsl:when test="$dingbat='ldquo'">"</xsl:when>
    <xsl:when test="$dingbat='rdquo'">"</xsl:when>
    <xsl:when test="$dingbat='lsquo'">'</xsl:when>
    <xsl:when test="$dingbat='rsquo'">'</xsl:when>
    <xsl:when test="$dingbat='em-dash'">--</xsl:when>
    <xsl:when test="$dingbat='en-dash'">-</xsl:when>
    <xsl:otherwise>o</xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>

