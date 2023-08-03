<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
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

<!-- ==================================================================== -->
<!-- Graphic format tests for the FO backend -->

<!--
FIXME: make is.graphic.* work correctly depending on the backend!
<xsl:param name="passivetex.extensions" select="0" doc:type='boolean'/>
<xsl:param name="fop.extensions" select="0" doc:type='boolean'/>
-->

<xsl:template name="is.graphic.format">
  <xsl:param name="format"></xsl:param>
  <xsl:if test="$format = 'PNG'
                or $format = 'PDF'
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
                or $ext = 'pdf'
                or $ext = 'jpeg'
                or $ext = 'jpg'
                or $ext = 'gif'
                or $ext = 'bmp'">1</xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="screenshot">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="screeninfo">
</xsl:template>

<!-- ==================================================================== -->
<!-- Override these templates for FO -->
<!-- ==================================================================== -->

<xsl:template name="process.image">
  <!-- When this template is called, the current node should be  -->
  <!-- a graphic, inlinegraphic, imagedata, or videodata. All    -->
  <!-- those elements have the same set of attributes, so we can -->
  <!-- handle them all in one place.                             -->
  <xsl:variable name="input-filename">
    <xsl:choose>
      <xsl:when test="@entityref">
        <xsl:value-of select="unparsed-entity-uri(@entityref)"/>
      </xsl:when>
      <xsl:when test="@fileref">
        <!-- FIXME: is this right? What if @fileref is a relative -->
        <!-- URI? What if @fileref contains backslashes? -->
        <xsl:text>file:</xsl:text>
        <xsl:value-of select="@fileref"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>
          <xsl:text>Expected @entityref or @fileref on </xsl:text>
          <xsl:value-of select="name(.)"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="fileext">
    <xsl:call-template name="filename-extension">
      <xsl:with-param name="filename" select="$input-filename"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="filename">
    <xsl:choose>
      <xsl:when test="$fileext != ''">
        <xsl:value-of select="$input-filename"/>
      </xsl:when>
      <xsl:when test="$graphic.default.extension != ''">
        <xsl:value-of select="$input-filename"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$graphic.default.extension"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$input-filename"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="scale">
    <xsl:choose>
      <xsl:when test="@scale"><xsl:value-of select="@scale"/>%</xsl:when>
      <xsl:otherwise>auto</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="width">
    <xsl:choose>
      <xsl:when test="@width">
        <xsl:call-template name="length-spec">
          <xsl:with-param name="length" select="@width"/>
          <xsl:with-param name="default.units" select="$default.units"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>auto</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="height">
    <xsl:choose>
      <xsl:when test="@depth">
        <xsl:call-template name="length-spec">
          <xsl:with-param name="length" select="@depth"/>
          <xsl:with-param name="default.units" select="$default.units"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>auto</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Scaling seems to require calculating an absolute width and height
       from a scale factor and the intrinsic width and height (possibly
       with contributions from the specified width and height). I'm not
       sure how to specify that... -->

  <xsl:choose>
    <xsl:when test="$passivetex.extensions != 0
                    or $fop.extensions != 0
                    or $arbortext.extensions != 0">
      <fo:external-graphic src="{$filename}"
                           content-width="{$width}"
                           content-height="{$height}"
                           width="auto"
                           height="auto"/>
    </xsl:when>
    <xsl:otherwise>
      <fo:external-graphic src="url({$filename})"
                           content-width="{$width}"
                           content-height="{$height}"
                           width="auto"
                           height="auto"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="graphic">
  <fo:block>
    <xsl:call-template name="process.image"/>
  </fo:block>
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

<xsl:template match="mediaobject">
  <fo:block>
    <xsl:call-template name="select.mediaobject"/>
    <xsl:apply-templates select="caption"/>
  </fo:block>
</xsl:template>

<xsl:template match="inlinemediaobject">
  <xsl:call-template name="select.mediaobject"/>
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
      <xsl:call-template name="process.image"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="videoobject">
  <xsl:apply-templates select="videodata"/>
</xsl:template>

<xsl:template match="videodata">
  <xsl:call-template name="process.image"/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="audioobject">
  <xsl:apply-templates select="audiodata"/>
</xsl:template>

<xsl:template match="audiodata">
  <xsl:call-template name="process.image"/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="textobject">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="caption">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
