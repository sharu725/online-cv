<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

<!-- ==================================================================== -->

<xsl:template name="setup.pagemasters">
  <fo:layout-master-set>
    <!-- one sided, single column -->
    <fo:simple-page-master master-name="blank"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.outer}"
                           margin-right="{$page.margin.inner}">
      <fo:region-body
                      margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"/>
      <fo:region-before region-name="xsl-region-before-blank"
                        extent="{$region.before.extent}"/>
      <fo:region-after region-name="xsl-region-after-blank"
                       extent="{$region.after.extent}"/>
    </fo:simple-page-master>

    <!-- one sided, single column -->
    <fo:simple-page-master master-name="simple1"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.outer}"
                           margin-right="{$page.margin.inner}">
      <fo:region-body
                      margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"/>
      <fo:region-before extent="{$region.before.extent}"/>
      <fo:region-after extent="{$region.after.extent}"/>
    </fo:simple-page-master>

    <!-- for left-hand/even pages in twosided mode, single column -->
    <fo:simple-page-master master-name="left1"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.outer}"
                           margin-right="{$page.margin.inner}">
      <fo:region-body
                      margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"/>
      <fo:region-before region-name="xsl-region-before-left"
                        extent="{$region.before.extent}"/>
      <fo:region-after region-name="xsl-region-after-left"
                       extent="{$region.after.extent}"/>
    </fo:simple-page-master>

    <!-- for right-hand/odd pages in twosided mode, single column -->
    <fo:simple-page-master master-name="right1"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.inner}"
                           margin-right="{$page.margin.outer}">
      <fo:region-body
                      margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"/>
      <fo:region-before region-name="xsl-region-before-right"
                        extent="{$region.before.extent}"/>
      <fo:region-after region-name="xsl-region-after-right"
                       extent="{$region.after.extent}"/>
    </fo:simple-page-master>

    <!-- special case of first page in either mode, single column -->
    <fo:simple-page-master master-name="first1"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.inner}"
                           margin-right="{$page.margin.inner}">
      <fo:region-body
                      margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"/>
      <fo:region-before region-name="xsl-region-before-first"
                        extent="{$region.before.extent}"/>
      <fo:region-after region-name="xsl-region-after-first"
                       extent="{$region.after.extent}"/>
    </fo:simple-page-master>

    <!-- for pages in one-side mode, 2 column -->
    <fo:simple-page-master master-name="simple2"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.outer}"
                           margin-right="{$page.margin.inner}">
      <fo:region-body
                      column-count="{$column.count}"
                      margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"/>
      <fo:region-before extent="{$region.before.extent}"/>
      <fo:region-after extent="{$region.after.extent}"/>
    </fo:simple-page-master>

    <!-- for left-hand/even pages in twosided mode, 2 column -->
    <fo:simple-page-master master-name="left2"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.outer}"
                           margin-right="{$page.margin.inner}">
      <fo:region-body
                      column-count="{$column.count}"
                      margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"/>
      <fo:region-before region-name="xsl-region-before-left"
                        extent="{$region.before.extent}"/>
      <fo:region-after region-name="xsl-region-after-left"
                       extent="{$region.after.extent}"/>
    </fo:simple-page-master>

    <!-- for right-hand/odd pages in twosided mode, 2 column -->
    <fo:simple-page-master master-name="right2"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.inner}"
                           margin-right="{$page.margin.outer}">
      <fo:region-body
                      column-count="{$column.count}"
                      margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"/>
      <fo:region-before region-name="xsl-region-before-right"
                        extent="{$region.before.extent}"/>
      <fo:region-after region-name="xsl-region-after-right"
                       extent="{$region.after.extent}"/>
    </fo:simple-page-master>

    <!-- special case of first page in either mode -->
    <fo:simple-page-master master-name="first2"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}"
                           margin-left="{$page.margin.inner}"
                           margin-right="{$page.margin.inner}">
      <fo:region-body
                      column-count="1"
                      margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"/>
      <fo:region-before region-name="xsl-region-before-first"
                        extent="{$region.before.extent}"/>
      <fo:region-after region-name="xsl-region-after-first"
                       extent="{$region.after.extent}"/>
    </fo:simple-page-master>

    <!-- setup for title-page, 1 column -->
    <fo:page-sequence-master master-name="titlepage1">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-name="first1"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>

    <!-- setup for single-sided, 1 column -->
    <fo:page-sequence-master master-name="oneside1">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-name="simple1"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>

    <!-- setup for double-sided, 1 column -->
    <fo:page-sequence-master master-name="twoside1">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-name="blank"
                                              blank-or-not-blank="blank"/>
        <fo:conditional-page-master-reference master-name="right1"
                                              odd-or-even="odd"/>
        <fo:conditional-page-master-reference master-name="left1"
                                              odd-or-even="even"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>

    <!-- setup for title-page, 2 column -->
    <fo:page-sequence-master master-name="titlepage2">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-name="first2"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>

    <!-- setup for single-sided, 2 column -->
    <fo:page-sequence-master master-name="oneside2">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-name="simple2"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>

    <!-- setup for double-sided, 2 column -->
    <fo:page-sequence-master master-name="twoside2">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference master-name="blank"
                                              blank-or-not-blank="blank"/>
        <fo:conditional-page-master-reference master-name="right2"
                                              odd-or-even="odd"/>
        <fo:conditional-page-master-reference master-name="left2"
                                              odd-or-even="even"/>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>

    <xsl:call-template name="user.pagemasters"/>

    </fo:layout-master-set>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="user.pagemasters"/> <!-- intentionally empty -->

<!-- ==================================================================== -->

<!-- $double.sided, $column.count, and context -->

<xsl:template name="select.pagemaster">
  <xsl:param name="element" select="local-name(.)"/>
  <xsl:choose>
    <xsl:when test="$double.sided != 0">
      <xsl:choose>
        <xsl:when test="$column.count &gt; 1">
          <xsl:call-template name="select.doublesided.multicolumn.pagemaster">
            <xsl:with-param name="element" select="$element"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="select.doublesided.pagemaster">
            <xsl:with-param name="element" select="$element"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$column.count &gt; 1">
          <xsl:call-template name="select.singlesided.multicolumn.pagemaster">
            <xsl:with-param name="element" select="$element"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="select.singlesided.pagemaster">
            <xsl:with-param name="element" select="$element"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="select.doublesided.multicolumn.pagemaster">
  <xsl:param name="element" select="local-name(.)"/>
  <xsl:choose>
    <xsl:when test="$element='set' or $element='book' or $element='part'">
      <xsl:text>titlepage2</xsl:text>
    </xsl:when>
    <xsl:otherwise>twoside2</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="select.doublesided.pagemaster">
  <xsl:param name="element" select="local-name(.)"/>
  <xsl:choose>
    <xsl:when test="$element='set' or $element='book' or $element='part'">
      <xsl:text>titlepage1</xsl:text>
    </xsl:when>
    <xsl:otherwise>twoside1</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="select.singlesided.multicolumn.pagemaster">
  <xsl:param name="element" select="local-name(.)"/>
  <xsl:choose>
    <xsl:when test="$element='set' or $element='book' or $element='part'">
      <xsl:text>titlepage2</xsl:text>
    </xsl:when>
    <xsl:otherwise>oneside2</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="select.singlesided.pagemaster">
  <xsl:param name="element" select="local-name(.)"/>
  <xsl:choose>
    <xsl:when test="$element='set' or $element='book' or $element='part'">
      <xsl:text>titlepage1</xsl:text>
    </xsl:when>
    <xsl:otherwise>oneside1</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="running.head.mode">
  <xsl:param name="master-name" select="'unknown'"/>
  <!-- by default, nothing -->
  <xsl:choose>
    <xsl:when test="$master-name='titlepage1'">
    </xsl:when>
    <xsl:when test="$master-name='oneside1'">
    </xsl:when>
    <xsl:when test="$master-name='twoside1'">
    </xsl:when>
    <xsl:when test="$master-name='titlepage2'">
    </xsl:when>
    <xsl:when test="$master-name='oneside2'">
    </xsl:when>
    <xsl:when test="$master-name='twoside2'">
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="chapter|appendix" mode="running.head.mode">
  <xsl:param name="master-name" select="'unknown'"/>
  <xsl:variable name="head">
    <fo:block font-size="{$body.font.size}">
      <xsl:apply-templates select="." mode="object.title.markup"/>
    </fo:block>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$master-name='titlepage1'"></xsl:when>
    <xsl:when test="$master-name='oneside1'">
      <fo:static-content flow-name="xsl-region-before">
        <fo:block text-align="center">
          <xsl:copy-of select="$head"/>
        </fo:block>
      </fo:static-content>
    </xsl:when>
    <xsl:when test="$master-name='twoside1'">
      <fo:static-content flow-name="xsl-region-before-left">
        <fo:block text-align="right">
          <xsl:copy-of select="$head"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-before-right">
        <fo:block text-align="left">
          <xsl:copy-of select="$head"/>
        </fo:block>
      </fo:static-content>
    </xsl:when>
    <xsl:when test="$master-name='titlepage2'"></xsl:when>
    <xsl:when test="$master-name='oneside2'">
      <fo:static-content flow-name="xsl-region-before">
        <fo:block text-align="center">
          <xsl:copy-of select="$head"/>
        </fo:block>
      </fo:static-content>
    </xsl:when>
    <xsl:when test="$master-name='twoside2'">
      <fo:static-content flow-name="xsl-region-before-left">
        <fo:block text-align="right">
          <xsl:copy-of select="$head"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-before-right">
        <fo:block text-align="left">
          <xsl:copy-of select="$head"/>
        </fo:block>
      </fo:static-content>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="*" mode="running.foot.mode">
  <xsl:param name="master-name" select="'unknown'"/>
  <xsl:variable name="foot">
    <fo:page-number/>
  </xsl:variable>
  <!-- by default, the page number -->
  <xsl:choose>
    <xsl:when test="$master-name='titlepage1'"></xsl:when>
    <xsl:when test="$master-name='oneside1'">
      <fo:static-content flow-name="xsl-region-after">
        <fo:block text-align="center" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
    </xsl:when>
    <xsl:when test="$master-name='twoside1'">
      <fo:static-content flow-name="xsl-region-after-left">
        <fo:block text-align="left" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-after-right">
        <fo:block text-align="right" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
    </xsl:when>
    <xsl:when test="$master-name='titlepage2'"></xsl:when>
    <xsl:when test="$master-name='oneside2'">
      <fo:static-content flow-name="xsl-after-before">
        <fo:block text-align="center" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
    </xsl:when>
    <xsl:when test="$master-name='twoside2'">
      <fo:static-content flow-name="xsl-region-after-left">
        <fo:block text-align="left" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-after-right">
        <fo:block text-align="right" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="set|book|part|reference" mode="running.foot.mode">
  <!-- nothing -->
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
