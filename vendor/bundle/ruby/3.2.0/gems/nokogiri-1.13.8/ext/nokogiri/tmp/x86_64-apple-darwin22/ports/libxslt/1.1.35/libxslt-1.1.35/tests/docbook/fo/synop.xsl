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

<!-- ==================================================================== -->

<xsl:template match="synopsis">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="cmdsynopsis">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="cmdsynopsis/command">
  <xsl:call-template name="inline.monoseq"/>
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="cmdsynopsis/command[1]" priority="2">
  <xsl:call-template name="inline.monoseq"/>
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="group|arg">
  <xsl:variable name="choice" select="@choice"/>
  <xsl:variable name="rep" select="@rep"/>
  <xsl:variable name="sepchar">
    <xsl:choose>
      <xsl:when test="ancestor-or-self::*/@sepchar">
        <xsl:value-of select="ancestor-or-self::*/@sepchar"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:if test="position()>1"><xsl:value-of select="$sepchar"/></xsl:if>
  <xsl:choose>
    <xsl:when test="$choice='plain'">
      <xsl:value-of select="$arg.choice.plain.open.str"/>
    </xsl:when>
    <xsl:when test="$choice='req'">
      <xsl:value-of select="$arg.choice.req.open.str"/>
    </xsl:when>
    <xsl:when test="$choice='opt'">
      <xsl:value-of select="$arg.choice.opt.open.str"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$arg.choice.def.open.str"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:apply-templates/>
  <xsl:choose>
    <xsl:when test="$rep='repeat'">
      <xsl:value-of select="$arg.rep.repeat.str"/>
    </xsl:when>
    <xsl:when test="$rep='norepeat'">
      <xsl:value-of select="$arg.rep.norepeat.str"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$arg.rep.def.str"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="$choice='plain'">
      <xsl:value-of select="$arg.choice.plain.close.str"/>
    </xsl:when>
    <xsl:when test="$choice='req'">
      <xsl:value-of select="$arg.choice.req.close.str"/>
    </xsl:when>
    <xsl:when test="$choice='opt'">
      <xsl:value-of select="$arg.choice.opt.close.str"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$arg.choice.def.close.str"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="group/arg">
  <xsl:variable name="choice" select="@choice"/>
  <xsl:variable name="rep" select="@rep"/>
  <xsl:if test="position()>1"><xsl:value-of select="$arg.or.sep"/></xsl:if>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="sbr">
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="synopfragmentref">
  <xsl:variable name="target" select="id(@linkend)"/>
  <xsl:variable name="snum">
    <xsl:apply-templates select="$target" mode="synopfragment.number"/>
  </xsl:variable>
  <fo:inline font-style="italic">
    <xsl:text>(</xsl:text>
    <xsl:value-of select="$snum"/>
    <xsl:text>)</xsl:text>
  </fo:inline>
</xsl:template>

<xsl:template match="synopfragment" mode="synopfragment.number">
  <xsl:number format="1"/>
</xsl:template>

<xsl:template match="synopfragment">
  <xsl:variable name="snum">
    <xsl:apply-templates select="." mode="synopfragment.number"/>
  </xsl:variable>
  <fo:block>
    <xsl:text>(</xsl:text>
    <xsl:value-of select="$snum"/>
    <xsl:text>)</xsl:text>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>   

<xsl:template match="funcsynopsis">
  <xsl:call-template name="informal.object"/>
</xsl:template>

<xsl:template match="funcsynopsisinfo">
  <fo:block><xsl:apply-templates/></fo:block>
</xsl:template>

<xsl:template match="funcprototype">
  <fo:block font-family="{$monospace.font.family}">
    <xsl:apply-templates/>
    <xsl:if test="$funcsynopsis.style='kr'">
      <xsl:apply-templates select="./paramdef" mode="kr-funcsynopsis-mode"/>
    </xsl:if>
  </fo:block>
</xsl:template>

<xsl:template match="funcdef">
  <fo:inline font-family="{$monospace.font.family}">
    <xsl:apply-templates/>
  </fo:inline>
</xsl:template>

<xsl:template match="funcdef/function">
  <xsl:choose>
    <xsl:when test="$funcsynopsis.decoration != 0">
      <fo:inline font-weight="bold">
        <xsl:apply-templates/>
      </fo:inline>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="void">
  <xsl:choose>
    <xsl:when test="$funcsynopsis.style='ansi'">
      <xsl:text>(void);</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>();</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="varargs">
  <xsl:text>(...);</xsl:text>
</xsl:template>

<xsl:template match="paramdef">
  <xsl:variable name="paramnum">
    <xsl:number count="paramdef" format="1"/>
  </xsl:variable>
  <xsl:if test="$paramnum=1">(</xsl:if>
  <xsl:choose>
    <xsl:when test="$funcsynopsis.style='ansi'">
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="./parameter"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="following-sibling::paramdef">
      <xsl:text>, </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>);</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="paramdef/parameter">
  <xsl:choose>
    <xsl:when test="$funcsynopsis.decoration != 0">
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:if test="following-sibling::parameter">
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:template>  

<xsl:template match="paramdef" mode="kr-funcsynopsis-mode">
  <xsl:apply-templates/>
  <xsl:text>;</xsl:text>
</xsl:template>

<xsl:template match="funcparams">
  <xsl:text>(</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>)</xsl:text>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
