<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:stext="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.TextFactory"
                xmlns:xtext="com.nwalsh.xalan.Text"
                xmlns:lxslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="xlink stext xtext lxslt"
                extension-element-prefixes="stext xtext"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     Contributors:
     Colin Paul Adams, <colin@colina.demon.co.uk>

     ******************************************************************** -->

<lxslt:component prefix="xtext"
                 elements="insertfile"/>

<!-- ==================================================================== -->
<!-- Graphic format tests for the HTML backend -->

<xsl:template name="is.graphic.format">
  <xsl:param name="format"></xsl:param>
  <xsl:if test="$format = 'PNG'
                or $format = 'JPG'
                or $format = 'JPEG'
                or $format = 'linespecific'
                or $format = 'GIF'
                or $format = 'GIF87a'
                or $format = 'GIF89a'
                or $format = 'BMP'">1</xsl:if>
</xsl:template>

<xsl:template name="is.graphic.extension">
  <xsl:param name="ext"></xsl:param>
  <xsl:if test="$ext = 'png'
                or $ext = 'jpeg'
                or $ext = 'jpg'
                or $ext = 'avi'
                or $ext = 'mpg'
                or $ext = 'mpeg'
                or $ext = 'qt'
                or $ext = 'gif'
                or $ext = 'bmp'">1</xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="screenshot">
  <div class="{name(.)}">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="screeninfo">
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="process.image">
  <!-- When this template is called, the current node should be  -->
  <!-- a graphic, inlinegraphic, imagedata, or videodata. All    -->
  <!-- those elements have the same set of attributes, so we can -->
  <!-- handle them all in one place.                             -->
  <xsl:param name="tag" select="'img'"/>
  <xsl:param name="alt"/>

  <xsl:variable name="filename">
    <xsl:choose>
      <xsl:when test="local-name(.) = 'graphic'
                      or local-name(.) = 'inlinegraphic'">
        <xsl:choose>
          <xsl:when test="@fileref">
            <xsl:value-of select="@fileref"/>
          </xsl:when>
          <xsl:when test="@entityref">
            <xsl:value-of select="unparsed-entity-uri(@entityref)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:message>
              <xsl:text>A fileref or entityref is required on </xsl:text>
              <xsl:value-of select="local-name(.)"/>
            </xsl:message>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- imagedata, videodata, audiodata -->
        <xsl:call-template name="mediaobject.filename">
          <xsl:with-param name="object" select=".."/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="width">
    <xsl:choose>
      <xsl:when test="@scale"><xsl:value-of select="@scale"/>%</xsl:when>
      <xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="height">
    <xsl:choose>
      <xsl:when test="@scale"></xsl:when>
      <xsl:when test="@depth"><xsl:value-of select="@depth"/></xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="align">
    <xsl:value-of select="@align"/>
  </xsl:variable>

  <xsl:element name="{$tag}">
    <xsl:attribute name="src">
      <xsl:value-of select="$filename"/>
    </xsl:attribute>

    <xsl:if test="$align != ''">
      <xsl:attribute name="align">
        <xsl:value-of select="$align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="$height != ''">
      <xsl:attribute name="height">
        <xsl:value-of select="$height"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="$width != ''">
      <xsl:attribute name="width">
        <xsl:value-of select="$width"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="$alt != ''">
      <xsl:attribute name="alt">
        <xsl:value-of select="$alt"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:element>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="graphic">
  <p>
    <xsl:call-template name="process.image"/>
  </p>
</xsl:template>

<xsl:template match="inlinegraphic">
  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>
  <xsl:variable name="filename">
    <xsl:choose>
      <xsl:when test="@entityref">
        <xsl:value-of select="unparsed-entity-uri(@entityref)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@fileref"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="@format='linespecific'">
      <xsl:choose>
        <xsl:when test="$use.extensions != '0'
                        and $textinsert.extension != '0'">
          <xsl:choose>
            <xsl:when test="contains($vendor, 'SAXON')">
              <stext:insertfile href="{$filename}"/>
            </xsl:when>
            <xsl:when test="contains($vendor, 'Apache Software Foundation')">
              <xtext:insertfile href="{$filename}"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:message terminate="yes">
                <xsl:text>Don't know how to insert files with </xsl:text>
                <xsl:value-of select="$vendor"/>
              </xsl:message>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <a xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad"
             href="{$filename}"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="process.image"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="mediaobject|mediaobjectco">
  <div class="{name(.)}">
    <xsl:call-template name="select.mediaobject"/>
    <xsl:apply-templates select="caption"/>
  </div>
</xsl:template>

<xsl:template match="inlinemediaobject">
  <span class="{name(.)}">
    <xsl:call-template name="select.mediaobject"/>
  </span>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="imageobjectco">
  <xsl:apply-templates select="imageobject"/>
  <xsl:apply-templates select="calloutlist"/>
</xsl:template>

<xsl:template match="imageobject">
  <xsl:apply-templates select="imagedata"/>
</xsl:template>

<xsl:template match="imagedata">
  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>
  <xsl:variable name="filename">
    <xsl:call-template name="mediaobject.filename">
      <xsl:with-param name="object" select=".."/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="@format='linespecific'">
      <xsl:choose>
        <xsl:when test="$use.extensions != '0'
                        and $textinsert.extension != '0'">
          <xsl:choose>
            <xsl:when test="contains($vendor, 'SAXON')">
              <stext:insertfile href="{$filename}"/>
            </xsl:when>
            <xsl:when test="contains($vendor, 'Apache Software Foundation')">
              <xtext:insertfile href="{$filename}"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:message terminate="yes">
                <xsl:text>Don't know how to insert files with </xsl:text>
                <xsl:value-of select="$vendor"/>
              </xsl:message>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <a xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad"
             href="{$filename}"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="process.image">
        <xsl:with-param name="alt">
          <xsl:apply-templates select="(../../textobject/phrase)[1]"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="videoobject">
  <xsl:apply-templates select="videodata"/>
</xsl:template>

<xsl:template match="videodata">
  <xsl:call-template name="process.image">
    <xsl:with-param name="tag" select="'embed'"/>
    <xsl:with-param name="alt">
      <xsl:apply-templates select="(../../textobject/phrase)[1]"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="audioobject">
  <xsl:apply-templates select="audiodata"/>
</xsl:template>

<xsl:template match="audiodata">
  <xsl:call-template name="process.image">
    <xsl:with-param name="tag" select="'embed'"/>
    <xsl:with-param name="alt">
      <xsl:apply-templates select="(../../textobject/phrase)[1]"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="textobject">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="caption">
  <div class="{name(.)}">
    <xsl:apply-templates/>
  </div>
</xsl:template>

</xsl:stylesheet>
