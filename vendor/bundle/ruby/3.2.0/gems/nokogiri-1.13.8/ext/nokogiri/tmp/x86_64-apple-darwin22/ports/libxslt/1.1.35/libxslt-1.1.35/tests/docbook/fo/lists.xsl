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

<xsl:template match="itemizedlist">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <xsl:if test="title">
    <xsl:apply-templates select="title" mode="list.title.mode"/>
  </xsl:if>

  <fo:list-block id="{$id}" xsl:use-attribute-sets="list.block.spacing"
                 provisional-distance-between-starts="1.5em"
                 provisional-label-separation="0.2em">
    <xsl:apply-templates/>
  </fo:list-block>
</xsl:template>

<xsl:template match="itemizedlist/title|orderedlist/title|variablelist/title">
  <!--nop-->
</xsl:template>

<xsl:template match="itemizedlist/listitem">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:list-item id="{$id}" xsl:use-attribute-sets="list.item.spacing">
    <fo:list-item-label end-indent="label-end()">
      <fo:block>
        <xsl:text>&#x2022;</xsl:text>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <xsl:apply-templates/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template match="orderedlist">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <xsl:if test="title">
    <xsl:apply-templates select="title" mode="list.title.mode"/>
  </xsl:if>

  <fo:list-block id="{$id}" xsl:use-attribute-sets="list.block.spacing"
                 provisional-distance-between-starts="2em"
                 provisional-label-separation="0.2em">
    <xsl:apply-templates/>
  </fo:list-block>
</xsl:template>

<xsl:template match="orderedlist/listitem">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:list-item id="{$id}" xsl:use-attribute-sets="list.item.spacing">
    <fo:list-item-label end-indent="label-end()">
      <fo:block>
        <xsl:number count="listitem" format="1."/>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <xsl:apply-templates/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template match="listitem/para[1]
                     |listitem/simpara[1]
                     |listitem/formalpara[1]
                     |callout/para[1]
                     |callout/simpara[1]
                     |callout/formalpara[1]"
              priority="2">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="variablelist">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:variable name="termlength">
    <xsl:choose>
      <!-- FIXME: handle @termlength="1in" -->
      <xsl:when test="@termlength">
        <xsl:value-of select="@termlength"/>
        <xsl:text>em</xsl:text>
      </xsl:when>
      <!-- FIXME: calculate some reasonable width -->
      <xsl:otherwise>
        <xsl:text>1in</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="title">
    <xsl:apply-templates select="title" mode="list.title.mode"/>
  </xsl:if>

  <fo:list-block id="{$id}"
                 provisional-distance-between-starts="{$termlength}"
                 provisional-label-separation="0.25in"
                 xsl:use-attribute-sets="list.block.spacing">
    <xsl:apply-templates/>
  </fo:list-block>
</xsl:template>

<xsl:template match="varlistentry">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:list-item id="{$id}" xsl:use-attribute-sets="list.item.spacing">
    <fo:list-item-label end-indent="label-end()">
      <fo:block>
        <xsl:apply-templates select="term"/>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <xsl:apply-templates select="listitem"/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template match="varlistentry/term">
  <fo:inline><xsl:apply-templates/>, </fo:inline>
</xsl:template>

<xsl:template match="varlistentry/term[position()=last()]" priority="2">
  <fo:inline><xsl:apply-templates/></fo:inline>
</xsl:template>

<xsl:template match="varlistentry/listitem">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="title" mode="list.title.mode">
  <fo:block font-size="12pt" font-weight="bold">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="simplelist">
  <!-- with no type specified, the default is 'vert' -->
  <fo:table>
    <fo:table-body>
      <xsl:call-template name="simplelist.vert">
	<xsl:with-param name="cols">
	  <xsl:choose>
	    <xsl:when test="@columns">
	      <xsl:value-of select="@columns"/>
	    </xsl:when>
	    <xsl:otherwise>1</xsl:otherwise>
	  </xsl:choose>
	</xsl:with-param>
      </xsl:call-template>
    </fo:table-body>
  </fo:table>
</xsl:template>

<xsl:template match="simplelist[@type='inline']">
  <fo:inline><xsl:apply-templates/></fo:inline>
</xsl:template>

<xsl:template match="simplelist[@type='horiz']">
  <fo:table>
    <fo:table-body>
      <xsl:call-template name="simplelist.horiz">
	<xsl:with-param name="cols">
	  <xsl:choose>
	    <xsl:when test="@columns">
	      <xsl:value-of select="@columns"/>
	    </xsl:when>
	    <xsl:otherwise>1</xsl:otherwise>
	  </xsl:choose>
	</xsl:with-param>
      </xsl:call-template>
    </fo:table-body>
  </fo:table>
</xsl:template>

<xsl:template match="simplelist[@type='vert']">
  <fo:table>
    <fo:table-body>
      <xsl:call-template name="simplelist.vert">
	<xsl:with-param name="cols">
	  <xsl:choose>
	    <xsl:when test="@columns">
	      <xsl:value-of select="@columns"/>
	    </xsl:when>
	    <xsl:otherwise>1</xsl:otherwise>
	  </xsl:choose>
	</xsl:with-param>
      </xsl:call-template>
    </fo:table-body>
  </fo:table>
</xsl:template>

<xsl:template name="simplelist.horiz">
  <xsl:param name="cols">1</xsl:param>
  <xsl:param name="cell">1</xsl:param>
  <xsl:param name="members" select="./member"/>

  <xsl:if test="$cell &lt;= count($members)">
    <fo:table-row>
      <xsl:call-template name="simplelist.horiz.row">
        <xsl:with-param name="cols" select="$cols"/>
        <xsl:with-param name="cell" select="$cell"/>
        <xsl:with-param name="members" select="$members"/>
      </xsl:call-template>
   </fo:table-row>
    <xsl:call-template name="simplelist.horiz">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="cell" select="$cell + $cols"/>
      <xsl:with-param name="members" select="$members"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="simplelist.horiz.row">
  <xsl:param name="cols">1</xsl:param>
  <xsl:param name="cell">1</xsl:param>
  <xsl:param name="members" select="./member"/>
  <xsl:param name="curcol">1</xsl:param>

  <xsl:if test="$curcol &lt;= $cols">
    <fo:table-cell>
      <fo:block>
        <xsl:if test="$members[position()=$cell]">
          <xsl:apply-templates select="$members[position()=$cell]"/>
        </xsl:if>
      </fo:block>
    </fo:table-cell>
    <xsl:call-template name="simplelist.horiz.row">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="cell" select="$cell+1"/>
      <xsl:with-param name="members" select="$members"/>
      <xsl:with-param name="curcol" select="$curcol+1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="simplelist.vert">
  <xsl:param name="cols">1</xsl:param>
  <xsl:param name="cell">1</xsl:param>
  <xsl:param name="members" select="./member"/>
  <xsl:param name="rows"
             select="floor((count($members)+$cols - 1) div $cols)"/>

  <xsl:if test="$cell &lt;= $rows">
    <fo:table-row>
      <xsl:call-template name="simplelist.vert.row">
        <xsl:with-param name="cols" select="$cols"/>
        <xsl:with-param name="rows" select="$rows"/>
        <xsl:with-param name="cell" select="$cell"/>
        <xsl:with-param name="members" select="$members"/>
      </xsl:call-template>
   </fo:table-row>
    <xsl:call-template name="simplelist.vert">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="cell" select="$cell+1"/>
      <xsl:with-param name="members" select="$members"/>
      <xsl:with-param name="rows" select="$rows"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="simplelist.vert.row">
  <xsl:param name="cols">1</xsl:param>
  <xsl:param name="rows">1</xsl:param>
  <xsl:param name="cell">1</xsl:param>
  <xsl:param name="members" select="./member"/>
  <xsl:param name="curcol">1</xsl:param>

  <xsl:if test="$curcol &lt;= $cols">
    <fo:table-cell>
      <fo:block>
        <xsl:if test="$members[position()=$cell]">
          <xsl:apply-templates select="$members[position()=$cell]"/>
        </xsl:if>
      </fo:block>
    </fo:table-cell>
    <xsl:call-template name="simplelist.vert.row">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="cell" select="$cell+$rows"/>
      <xsl:with-param name="members" select="$members"/>
      <xsl:with-param name="curcol" select="$curcol+1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template match="member">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="simplelist[@type='inline']/member">
  <xsl:apply-templates/>
  <xsl:text>, </xsl:text>
</xsl:template>

<xsl:template match="simplelist[@type='inline']/member[position()=last()]"
              priority="2">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="procedure">
  <xsl:variable name="title" select="title"/>
  <xsl:variable name="preamble"
                select="*[not(self::step or self::title)]"/>
  <xsl:variable name="steps" select="step"/>

  <fo:block space-before.optimum="1em"
            space-before.minimum="0.8em"
            space-before.maximum="1.2em">
    <xsl:if test="./title">
      <fo:block font-weight="bold">
        <xsl:apply-templates select="./title" mode="procedure.title.mode"/>
      </fo:block>
    </xsl:if>

    <xsl:apply-templates select="$preamble"/>

    <fo:list-block xsl:use-attribute-sets="list.block.spacing"
                   provisional-distance-between-starts="2em"
                   provisional-label-separation="0.2em">
      <xsl:apply-templates select="$steps"/>
    </fo:list-block>
  </fo:block>
</xsl:template>

<xsl:template match="procedure/title">
</xsl:template>

<xsl:template match="procedure/title" mode="procedure.title.mode">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="substeps">
  <fo:list-block xsl:use-attribute-sets="list.block.spacing"
                 provisional-distance-between-starts="2em"
                 provisional-label-separation="0.2em">
    <xsl:apply-templates/>
  </fo:list-block>
</xsl:template>

<xsl:template match="step">
  <xsl:variable name="depth" select="count(ancestor::substeps)"/>
  <xsl:variable name="type" select="$depth mod 5"/>

  <fo:list-item>
    <fo:list-item-label end-indent="label-end()">
      <fo:block>
        <xsl:choose>
          <xsl:when test="$depth = 0">
            <xsl:number count="step" format="1."/>
          </xsl:when>
          <xsl:when test="$type = 1">
            <xsl:number count="step" format="a."/>
          </xsl:when>
          <xsl:when test="$type = 2">
            <xsl:number count="step" format="i."/>
          </xsl:when>
          <xsl:when test="$type = 3">
            <xsl:number count="step" format="A."/>
          </xsl:when>
          <xsl:when test="$type = 4">
            <xsl:number count="step" format="I."/>
          </xsl:when>
          <xsl:when test="$type = 0">
            <xsl:number count="step" format="1."/>
          </xsl:when>
        </xsl:choose>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <xsl:apply-templates/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="segmentedlist">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="segmentedlist/title">
  <fo:block font-weight="bold">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="segtitle">
</xsl:template>

<xsl:template match="segtitle" mode="segtitle-in-seg">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="seglistitem">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="seg">
  <xsl:variable name="segnum" select="position()"/>
  <xsl:variable name="seglist" select="ancestor::segmentedlist"/>
  <xsl:variable name="segtitles" select="$seglist/segtitle"/>

  <!--
     Note: segtitle is only going to be the right thing in a well formed
     SegmentedList.  If there are too many Segs or too few SegTitles,
     you'll get something odd...maybe an error
  -->

  <fo:block>
    <fo:inline font-weight="bold">
      <xsl:apply-templates select="$segtitles[$segnum=position()]"
                           mode="segtitle-in-seg"/>
      <xsl:text>: </xsl:text>
    </fo:inline>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="calloutlist">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <fo:block id="{$id}">
    <xsl:if test="./title">
      <fo:block font-weight="bold">
        <xsl:apply-templates select="./title" mode="calloutlist.title.mode"/>
      </fo:block>
    </xsl:if>

    <fo:list-block space-before.optimum="1em"
                   space-before.minimum="0.8em"
                   space-before.maximum="1.2em"
                   provisional-distance-between-starts="2.2em"
                   provisional-label-separation="0.2em">
      <xsl:apply-templates/>
    </fo:list-block>
  </fo:block>
</xsl:template>

<xsl:template match="calloutlist/title">
</xsl:template>

<xsl:template match="calloutlist/title" mode="calloutlist.title.mode">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="callout">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:list-item id="{$id}">
    <fo:list-item-label end-indent="label-end()">
      <fo:block>
        <xsl:call-template name="callout.arearefs">
          <xsl:with-param name="arearefs" select="@arearefs"/>
        </xsl:call-template>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <xsl:apply-templates/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template name="callout.arearefs">
  <xsl:param name="arearefs"></xsl:param>
  <xsl:if test="$arearefs!=''">
    <xsl:choose>
      <xsl:when test="substring-before($arearefs,' ')=''">
        <xsl:call-template name="callout.arearef">
          <xsl:with-param name="arearef" select="$arearefs"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="callout.arearef">
          <xsl:with-param name="arearef"
                          select="substring-before($arearefs,' ')"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="callout.arearefs">
      <xsl:with-param name="arearefs"
                      select="substring-after($arearefs,' ')"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="callout.arearef">
  <xsl:param name="arearef"></xsl:param>
  <xsl:variable name="targets" select="id($arearef)"/>
  <xsl:variable name="target" select="$targets[1]"/>

  <xsl:choose>
    <xsl:when test="count($target)=0">
      <xsl:value-of select="$arearef"/>
      <xsl:text>: ???</xsl:text>
    </xsl:when>
    <xsl:when test="local-name($target)='co'">
      <xsl:apply-templates select="$target" mode="callout-bug"/>
    </xsl:when>
    <xsl:when test="local-name($target)='areaset'">
      <xsl:call-template name="callout-bug">
        <xsl:with-param name="conum">
          <xsl:apply-templates select="$target" mode="conumber"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="local-name($target)='area'">
      <xsl:choose>
        <xsl:when test="$target/parent::areaset">
          <xsl:call-template name="callout-bug">
            <xsl:with-param name="conum">
              <xsl:apply-templates select="$target/parent::areaset"
                                   mode="conumber"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="callout-bug">
            <xsl:with-param name="conum">
              <xsl:apply-templates select="$target" mode="conumber"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>???</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>

