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

<!-- ==================================================================== -->

<xsl:template match="index|setindex">
  <!-- some implementations use completely empty index tags to indicate -->
  <!-- where an automatically generated index should be inserted. so -->
  <!-- if the index is completely empty, skip it. Unless generate.index -->
  <!-- is non-zero, in which case, this is where the automatically -->
  <!-- generated index should go. -->

  <xsl:if test="count(*)>0 or $generate.index != '0'">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <div id="{$id}" class="{name(.)}">
      <xsl:call-template name="index.titlepage"/>
      <xsl:apply-templates/>

      <xsl:if test="count(indexentry) = 0 and count(indexdiv) = 0">
        <xsl:call-template name="generate-index"/>
      </xsl:if>

      <xsl:call-template name="process.footnotes"/>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template match="index/title"></xsl:template>
<xsl:template match="index/subtitle"></xsl:template>
<xsl:template match="index/titleabbrev"></xsl:template>

<xsl:template match="index/title" mode="component.title.mode">
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select=".."/>
    </xsl:call-template>
  </xsl:variable>
  <h2 class="title">
    <a name="{$id}">
      <xsl:apply-templates/>
    </a>
  </h2>
</xsl:template>

<xsl:template match="index/subtitle" mode="component.title.mode">
  <h3>
    <i><xsl:apply-templates/></i>
  </h3>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="indexdiv">
  <div class="{name(.)}">
    <xsl:apply-templates mode="not-indexentrys"/>
    <dl>
      <xsl:apply-templates select="indexentry"/>
    </dl>
  </div>
</xsl:template>

<xsl:template match="indexentry" mode="not-indexentrys">
  <!-- suppress -->
</xsl:template>

<xsl:template match="indexdiv/title">
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select=".."/>
    </xsl:call-template>
  </xsl:variable>
  <h3 class="{name(.)}">
    <a name="{$id}">
      <xsl:apply-templates/>
    </a>
  </h3>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="indexterm">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <a class="indexterm" name="{$id}"/>
</xsl:template>

<xsl:template match="primary|secondary|tertiary|see|seealso">
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="indexentry">
  <xsl:apply-templates select="primaryie"/>
</xsl:template>

<xsl:template match="primaryie">
  <dt>
    <xsl:apply-templates/>
  </dt>
  <xsl:choose>
    <xsl:when test="following-sibling::secondaryie">
      <dd>
        <dl>
          <xsl:apply-templates select="following-sibling::secondaryie"/>
        </dl>
      </dd>
    </xsl:when>
    <xsl:when test="following-sibling::seeie
                    |following-sibling::seealsoie">
      <dd>
        <dl>
          <xsl:apply-templates select="following-sibling::seeie
                                       |following-sibling::seealsoie"/>
        </dl>
      </dd>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="secondaryie">
  <dt>
    <xsl:apply-templates/>
  </dt>
  <xsl:choose>
    <xsl:when test="following-sibling::tertiaryie">
      <dd>
        <dl>
          <xsl:apply-templates select="following-sibling::tertiaryie"/>
        </dl>
      </dd>
    </xsl:when>
    <xsl:when test="following-sibling::seeie
                    |following-sibling::seealsoie">
      <dd>
        <dl>
          <xsl:apply-templates select="following-sibling::seeie
                                       |following-sibling::seealsoie"/>
        </dl>
      </dd>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="tertiaryie">
  <dt>
    <xsl:apply-templates/>
  </dt>
  <xsl:if test="following-sibling::seeie
                |following-sibling::seealsoie">
    <dd>
      <dl>
        <xsl:apply-templates select="following-sibling::seeie
                                     |following-sibling::seealsoie"/>
      </dl>
    </dd>
  </xsl:if>
</xsl:template>

<xsl:template match="seeie|seealsoie">
  <dt>
    <xsl:apply-templates/>
  </dt>
</xsl:template>

<xsl:template name="generate-index">
  <!-- nop: use autoidx.xsl to get automatic indexing -->
</xsl:template>

</xsl:stylesheet>
