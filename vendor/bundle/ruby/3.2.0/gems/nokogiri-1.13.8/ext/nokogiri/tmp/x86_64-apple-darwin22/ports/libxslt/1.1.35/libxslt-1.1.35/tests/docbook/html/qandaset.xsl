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

     ******************************************************************** -->

<!-- ==================================================================== -->

<xsl:template match="qandaset">
  <xsl:variable name="title" select="title"/>
  <xsl:variable name="rest" select="*[name(.)!='title']"/>

  <div class="{name(.)}">
    <xsl:apply-templates select="$title"/>
    <xsl:if test="$generate.qandaset.toc != '0'">
      <xsl:call-template name="process.qanda.toc"/>
    </xsl:if>
    <xsl:apply-templates select="$rest"/>
  </div>
</xsl:template>

<xsl:template match="qandaset/title">
  <xsl:variable name="qalevel">
    <xsl:call-template name="qanda.section.level"/>
  </xsl:variable>
  <xsl:element name="h{string(number($qalevel)+1)}">
    <xsl:attribute name="class">
      <xsl:value-of select="name(.)"/>
    </xsl:attribute>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="qandadiv">
  <xsl:variable name="title" select="title"/>
  <xsl:variable name="rest" select="*[name(.)!='title']"/>

  <div class="{name(.)}">
    <xsl:apply-templates select="$title"/>
    <xsl:if test="$generate.qandadiv.toc != '0'">
      <xsl:call-template name="process.qanda.toc"/>
    </xsl:if>
    <xsl:apply-templates select="$rest"/>
  </div>
</xsl:template>

<xsl:template match="qandadiv/title">
  <xsl:variable name="qalevel">
    <xsl:call-template name="qandadiv.section.level"/>
  </xsl:variable>
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="parent::*"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:element name="h{string(number($qalevel)+1)}">
    <xsl:attribute name="class">
      <xsl:value-of select="name(.)"/>
    </xsl:attribute>
    <a name="{$id}"/>
    <xsl:apply-templates select="parent::qandadiv" mode="label.markup"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="qandaentry">
  <div class="{name(.)}">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="question">
  <xsl:variable name="firstch" select="(*[name(.)!='label'
                                          and name(.)!='indexterm'])[1]"/>
  <xsl:variable name="restch" select="(*[name(.)!='label'
                                         and name(.)!='indexterm'])[position()!=1]
                                      |indexterm"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <p>
      <xsl:if test="../@id">
        <a>
          <xsl:attribute name="name">
            <xsl:call-template name="object.id">
              <xsl:with-param name="object" select="parent::*"/>
            </xsl:call-template>
          </xsl:attribute>
        </a>
      </xsl:if>
      <a name="{$id}"/>
      <b>
        <xsl:apply-templates select="." mode="label.markup"/>
        <xsl:text> </xsl:text>
      </b>
      <xsl:apply-templates select="$firstch" mode="no.wrapper.mode"/>
    </p>
    <xsl:apply-templates select="$restch"/>
  </div>
</xsl:template>

<xsl:template match="answer">
  <xsl:variable name="firstch" select="(*[name(.)!='label'])[1]"/>
  <xsl:variable name="restch" select="(*[name(.)!='label'])[position()!=1]"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <div class="{name(.)}">
    <p>
      <a name="{$id}"/>
      <b>
        <xsl:apply-templates select="." mode="label.markup"/>
        <xsl:text> </xsl:text>
      </b>
      <xsl:apply-templates select="$firstch" mode="no.wrapper.mode"/>
    </p>
    <xsl:apply-templates select="$restch"/>
  </div>
</xsl:template>

<xsl:template match="label">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="process.qanda.toc">
  <dl>
    <xsl:apply-templates select="qandadiv" mode="qandatoc.mode"/>
    <xsl:apply-templates select="qandaentry" mode="qandatoc.mode"/>
  </dl>
</xsl:template>

<xsl:template match="qandadiv" mode="qandatoc.mode">
  <dt><xsl:apply-templates select="title" mode="qandatoc.mode"/></dt>
  <dd><xsl:call-template name="process.qanda.toc"/></dd>
</xsl:template>

<xsl:template match="qandadiv/title" mode="qandatoc.mode">
  <xsl:variable name="qalevel">
    <xsl:call-template name="qandadiv.section.level"/>
  </xsl:variable>
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="parent::*"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:apply-templates select="parent::qandadiv" mode="label.markup"/>
  <xsl:text> </xsl:text>
  <a>
    <xsl:attribute name="href">
      <xsl:call-template name="href.target">
        <xsl:with-param name="object" select="parent::*"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:apply-templates/>
  </a>
</xsl:template>

<xsl:template match="qandaentry" mode="qandatoc.mode">
  <xsl:apply-templates mode="qandatoc.mode"/>
</xsl:template>

<xsl:template match="question" mode="qandatoc.mode">
  <xsl:variable name="firstch" select="(*[name(.)!='label'])[1]"/>

  <dt>
    <xsl:apply-templates select="." mode="label.markup"/>
    <xsl:text> </xsl:text>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:value-of select="$firstch"/>
    </a>
  </dt>
</xsl:template>

<xsl:template match="answer|revhistory" mode="qandatoc.mode">
  <!-- nop -->
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="no.wrapper.mode">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
