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

<xsl:template name="block.object">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="para">
  <fo:block xsl:use-attribute-sets="normal.para.spacing">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="simpara">
  <fo:block xsl:use-attribute-sets="normal.para.spacing">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="formalpara">
  <fo:block xsl:use-attribute-sets="normal.para.spacing">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="formalpara/title">
  <fo:inline font-weight="bold"
             keep-with-next.within-line="always"
             padding-end="1em">
    <xsl:apply-templates/>
  </fo:inline>
</xsl:template>

<xsl:template match="formalpara/para">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="blockquote">
  <fo:block start-indent="0.5in" end-indent="0.5in">
    <xsl:call-template name="semiformal.object"/>
  </fo:block>
</xsl:template>

<xsl:template match="epigraph">
  <fo:block>
    <xsl:apply-templates select="para"/>
    <fo:inline>
      <xsl:text>--</xsl:text>
      <xsl:apply-templates select="attribution"/>
    </fo:inline>
  </fo:block>
</xsl:template>

<xsl:template match="attribution">
  <fo:inline><xsl:apply-templates/></fo:inline>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="sidebar">
  <fo:block>
    <xsl:if test="./title">
      <fo:block font-weight="bold"
                keep-with-next.within-column="always"
                hyphenate="false">
        <xsl:apply-templates select="./title" mode="sidebar.title.mode"/>
      </fo:block>
    </xsl:if>

    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="sidebar/title">
</xsl:template>

<xsl:template match="sidebar/title" mode="sidebar.title.mode">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="abstract">
  <fo:block>
    <xsl:if test="@id">
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
    </xsl:if>
    <xsl:call-template name="formal.object.heading">
      <xsl:with-param name="title">
        <xsl:apply-templates select="." mode="title.markup"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="abstract/title">
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="msgset">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgentry">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="msg">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="msgmain">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgsub">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgrel">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgtext">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msginfo">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="msglevel">
  <fo:block>
    <fo:inline font-weight="bold"
               keep-with-next.within-line="always">
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'msgset'"/>
        <xsl:with-param name="name" select="'MsgLevel'"/>
      </xsl:call-template>
    </fo:inline>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="msgorig">
  <fo:block>
    <fo:inline font-weight="bold"
               keep-with-next.within-line="always">
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'msgset'"/>
        <xsl:with-param name="name" select="'MsgOrig'"/>
      </xsl:call-template>
    </fo:inline>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="msgaud">
  <fo:block>
    <fo:inline font-weight="bold"
               keep-with-next.within-line="always">
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'msgset'"/>
        <xsl:with-param name="name" select="'MsgAud'"/>
      </xsl:call-template>
    </fo:inline>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="msgexplan">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="msgexplan/title">
  <fo:block font-weight="bold"
            keep-with-next.within-column="always"
            hyphenate="false">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="highlights">
  <xsl:call-template name="block.object"/>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
