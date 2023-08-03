<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:stbl="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Table"
                xmlns:xtbl="com.nwalsh.xalan.Table"
                xmlns:lxslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="doc stbl xtbl lxslt"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

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
<title>Formatting Object Table Reference</title>

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

<!-- ==================================================================== -->

<lxslt:component prefix="xtbl"
                 functions="adjustColumnWidths"/>

<!-- ==================================================================== -->

<xsl:param name="table-border-thickness" select="'0.5pt'"/>
<xsl:param name="table-border-padding" select="'2pt'"/>
<xsl:param name="table-border-style" select="'solid'"/>
<xsl:param name="table-border-color" select="'black'"/>

<!-- ==================================================================== -->

<xsl:template name="border">
  <xsl:param name="side" select="'left'"/>
  <xsl:param name="padding" select="0"/>

  <xsl:attribute name="border-{$side}">
    <xsl:value-of select="$table-border-thickness"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$table-border-style"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$table-border-color"/>
    <xsl:text> </xsl:text>
  </xsl:attribute>
  <xsl:if test="$padding != 0">
    <xsl:attribute name="padding-{$side}">
      <xsl:value-of select="$table-border-padding"/>
    </xsl:attribute>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="tgroup">
  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:variable name="explicit.table.width">
    <xsl:call-template name="dbfo-attribute">
      <xsl:with-param name="pis"
                      select="../processing-instruction('dbfo')"/>
      <xsl:with-param name="attribute" select="'table-width'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="table.width">
    <xsl:choose>
      <xsl:when test="$explicit.table.width != ''">
        <xsl:value-of select="$explicit.table.width"/>
      </xsl:when>
      <xsl:when test="$default.table.width = ''">
        <xsl:text>100%</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$default.table.width"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="colspecs">
    <xsl:choose>
      <xsl:when test="$use.extensions != 0
                      and $tablecolumns.extension != 0">
        <xsl:call-template name="generate.colgroup.raw">
          <xsl:with-param name="cols" select="@cols"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="generate.colgroup">
          <xsl:with-param name="cols" select="@cols"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$use.extensions != 0
                    and $tablecolumns.extension != 0">
      <xsl:choose>
        <xsl:when test="contains($vendor, 'SAXON 6')">
          <xsl:copy-of select="stbl:adjustColumnWidths($colspecs)"/>
        </xsl:when>
        <xsl:when test="contains($vendor, 'SAXON 5')">
          <!-- the saxon5 extension doesn't support this (yet) -->
          <xsl:call-template name="generate.colgroup">
            <xsl:with-param name="cols" select="@cols"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($vendor, 'Apache Software Foundation')">
          <xsl:copy-of select="xtbl:adjustColumnWidths($colspecs)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message terminate="yes">
            <xsl:text>Don't know how to do adjust column widths with </xsl:text>
            <xsl:value-of select="$vendor"/>
          </xsl:message>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy-of select="$colspecs"/>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:apply-templates select="thead"/>
  <xsl:apply-templates select="tbody"/>
  <xsl:apply-templates select="tfoot"/>
</xsl:template>

<xsl:template match="colspec"></xsl:template>

<xsl:template match="spanspec"></xsl:template>

<xsl:template match="thead">
  <xsl:variable name="tgroup" select="parent::*"/>
  <xsl:variable name="frame" select="$tgroup/parent::*/@frame"/>

  <fo:table-header>
    <xsl:choose>
      <xsl:when test="$frame='topbot' or $frame='top'">
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'top'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$frame='sides'">
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'left'"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'right'"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
    <xsl:apply-templates/>
  </fo:table-header>
</xsl:template>

<xsl:template match="tbody">
  <xsl:variable name="tgroup" select="parent::*"/>
  <xsl:variable name="frame" select="$tgroup/parent::*/@frame"/>
  <fo:table-body>
    <xsl:choose>
      <xsl:when test="$frame='top'">
        <xsl:choose>
          <xsl:when test="preceding-sibling::thead">
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="border">
              <xsl:with-param name="side" select="'top'"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$frame='bottom'">
        <xsl:choose>
          <xsl:when test="preceding-sibling::tfoot">
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="border">
              <xsl:with-param name="side" select="'bottom'"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$frame='topbot'">
        <xsl:choose>
          <xsl:when test="preceding-sibling::thead">
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="border">
              <xsl:with-param name="side" select="'top'"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="preceding-sibling::tfoot">
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="border">
              <xsl:with-param name="side" select="'bottom'"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$frame='sides'">
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'left'"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'right'"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
    <xsl:apply-templates/>
  </fo:table-body>
</xsl:template>

<xsl:template match="row">
  <fo:table-row>
    <xsl:if test="@rowsep='1'">
      <xsl:call-template name="border">
        <xsl:with-param name="side" select="'bottom'"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates/>
  </fo:table-row>
</xsl:template>

<xsl:template match="thead/row/entry">
  <xsl:call-template name="process.cell"/>
</xsl:template>

<xsl:template match="tbody/row/entry">
  <xsl:call-template name="process.cell"/>
</xsl:template>

<xsl:template match="tfoot/row/entry">
  <xsl:call-template name="process.cell"/>
</xsl:template>

<xsl:template name="process.cell">
  <xsl:variable name="row" select="parent::row"/>
  <xsl:variable name="group" select="$row/parent::*[1]"/>
  <xsl:variable name="frame" select="ancestor::tgroup/parent::*/@frame"/>

  <xsl:variable name="content">
    <xsl:apply-templates/>
  </xsl:variable>

  <fo:table-cell>
    <xsl:choose>
      <xsl:when test="$frame='all'">
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'left'"/>
          <xsl:with-param name="padding" select="1"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'right'"/>
          <xsl:with-param name="padding" select="1"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'top'"/>
          <xsl:with-param name="padding" select="1"/>
        </xsl:call-template>
        <xsl:call-template name="border">
          <xsl:with-param name="side" select="'bottom'"/>
          <xsl:with-param name="padding" select="1"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="@colsep='1'">
          <xsl:call-template name="border">
            <xsl:with-param name="side" select="'right'"/>
            <xsl:with-param name="padding" select="1"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:if test="@rowsep='1'">
          <xsl:call-template name="border">
            <xsl:with-param name="side" select="'bottom'"/>
            <xsl:with-param name="padding" select="1"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="@morerows">
      <xsl:attribute name="number-rows-spanned">
        <xsl:value-of select="@morerows+1"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@namest">
      <xsl:attribute name="number-columns-spanned">
        <xsl:call-template name="calculate.colspan"/>
      </xsl:attribute>
    </xsl:if>

    <fo:block>
      <xsl:copy-of select="$content"/>
    </fo:block>
  </fo:table-cell>
</xsl:template>

<xsl:template name="generate.colgroup.raw">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="count" select="1"/>

  <xsl:choose>
    <xsl:when test="$count>$cols"></xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="generate.col.raw">
        <xsl:with-param name="countcol" select="$count"/>
      </xsl:call-template>
      <xsl:call-template name="generate.colgroup.raw">
        <xsl:with-param name="cols" select="$cols"/>
        <xsl:with-param name="count" select="$count+1"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="generate.colgroup">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="count" select="1"/>

  <xsl:choose>
    <xsl:when test="$count>$cols"></xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="generate.col">
        <xsl:with-param name="countcol" select="$count"/>
      </xsl:call-template>
      <xsl:call-template name="generate.colgroup">
        <xsl:with-param name="cols" select="$cols"/>
        <xsl:with-param name="count" select="$count+1"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="generate.col.raw">
  <!-- generate the table-column for column countcol -->
  <xsl:param name="countcol">1</xsl:param>
  <xsl:param name="colspecs" select="./colspec"/>
  <xsl:param name="count">1</xsl:param>
  <xsl:param name="colnum">1</xsl:param>

  <xsl:choose>
    <xsl:when test="$count>count($colspecs)">
      <fo:table-column column-number="{$countcol}"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="colspec" select="$colspecs[$count=position()]"/>

      <xsl:variable name="colspec.colnum">
        <xsl:choose>
          <xsl:when test="$colspec/@colnum">
            <xsl:value-of select="$colspec/@colnum"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$colnum"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="colspec.colwidth">
        <xsl:choose>
          <xsl:when test="$colspec/@colwidth">
            <xsl:value-of select="$colspec/@colwidth"/>
          </xsl:when>
          <xsl:otherwise>1*</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$colspec.colnum=$countcol">
          <fo:table-column column-number="{$countcol}">
            <xsl:attribute name="column-width">
              <xsl:value-of select="$colspec.colwidth"/>
            </xsl:attribute>
          </fo:table-column>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="generate.col.raw">
            <xsl:with-param name="countcol" select="$countcol"/>
            <xsl:with-param name="colspecs" select="$colspecs"/>
            <xsl:with-param name="count" select="$count+1"/>
            <xsl:with-param name="colnum">
              <xsl:choose>
                <xsl:when test="$colspec/@colnum">
                  <xsl:value-of select="$colspec/@colnum + 1"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$colnum + 1"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
           </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="generate.col">
  <!-- generate the table-column for column countcol -->
  <xsl:param name="countcol">1</xsl:param>
  <xsl:param name="colspecs" select="./colspec"/>
  <xsl:param name="count">1</xsl:param>
  <xsl:param name="colnum">1</xsl:param>

  <xsl:choose>
    <xsl:when test="$count>count($colspecs)">
      <fo:table-column column-number="{$countcol}">
	<xsl:variable name="colwidth">
	  <xsl:call-template name="calc.column.width"/>
	</xsl:variable>
	<xsl:if test="$colwidth != 'proportional-column-width(1)'">
	  <xsl:attribute name="column-width">
	    <xsl:value-of select="$colwidth"/>
	  </xsl:attribute>
	</xsl:if>
      </fo:table-column>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="colspec" select="$colspecs[$count=position()]"/>

      <xsl:variable name="colspec.colnum">
        <xsl:choose>
          <xsl:when test="$colspec/@colnum">
            <xsl:value-of select="$colspec/@colnum"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$colnum"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="colspec.colwidth">
        <xsl:choose>
          <xsl:when test="$colspec/@colwidth">
            <xsl:value-of select="$colspec/@colwidth"/>
          </xsl:when>
          <xsl:otherwise>1*</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$colspec.colnum=$countcol">
          <fo:table-column column-number="{$countcol}">
	    <xsl:variable name="colwidth">
              <xsl:call-template name="calc.column.width">
                <xsl:with-param name="colwidth">
                  <xsl:value-of select="$colspec.colwidth"/>
                </xsl:with-param>
	      </xsl:call-template>
	    </xsl:variable>
	    <xsl:if test="$colwidth != 'proportional-column-width(1)'">
	      <xsl:attribute name="column-width">
		<xsl:value-of select="$colwidth"/>
	      </xsl:attribute>
	    </xsl:if>
	  </fo:table-column>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="generate.col">
            <xsl:with-param name="countcol" select="$countcol"/>
            <xsl:with-param name="colspecs" select="$colspecs"/>
            <xsl:with-param name="count" select="$count+1"/>
            <xsl:with-param name="colnum">
              <xsl:choose>
                <xsl:when test="$colspec/@colnum">
                  <xsl:value-of select="$colspec/@colnum + 1"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$colnum + 1"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
           </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<doc:template name="calc.column.width" xmlns="">
<refpurpose>Calculate an XSL FO table column width specification from a
CALS table column width specification.</refpurpose>

<refdescription>
<para>CALS expresses table column widths in the following basic
forms:</para>

<itemizedlist>
<listitem>
<para><emphasis>99.99units</emphasis>, a fixed length specifier.</para>
</listitem>
<listitem>
<para><emphasis>99.99</emphasis>, a fixed length specifier without any units.</para>
</listitem>
<listitem>
<para><emphasis>99.99*</emphasis>, a relative length specifier.</para>
</listitem>
<listitem>
<para><emphasis>99.99*+99.99units</emphasis>, a combination of both.</para>
</listitem>
</itemizedlist>

<para>The CALS units are points (pt), picas (pi), centimeters (cm),
millimeters (mm), and inches (in). These are the same units as XSL,
except that XSL abbreviates picas "pc" instead of "pi". If a length
specifier has no units, the CALS default unit (pt) is assumed.</para>

<para>Relative length specifiers are represented in XSL with the
proportional-column-width() function.</para>

<para>Here are some examples:</para>

<itemizedlist>
<listitem>
<para>"36pt" becomes "36pt"</para>
</listitem>
<listitem>
<para>"3pi" becomes "3pc"</para>
</listitem>
<listitem>
<para>"36" becomes "36pt"</para>
</listitem>
<listitem>
<para>"3*" becomes "proportional-column-width(3)"</para>
</listitem>
<listitem>
<para>"3*+2pi" becomes "proportional-column-width(3)+2pc"</para>
</listitem>
<listitem>
<para>"1*+2" becomes "proportional-column-width(1)+2pt"</para>
</listitem>
</itemizedlist>
</refdescription>

<refparameter>
<variablelist>
<varlistentry><term>colwidth</term>
<listitem>
<para>The CALS column width specification.</para>
</listitem>
</varlistentry>
</variablelist>
</refparameter>

<refreturn>
<para>The XSL column width specification.</para>
</refreturn>
</doc:template>

<xsl:template name="calc.column.width">
  <xsl:param name="colwidth">1*</xsl:param>

  <!-- Ok, the colwidth could have any one of the following forms: -->
  <!--        1*       = proportional width -->
  <!--     1unit       = 1.0 units wide -->
  <!--         1       = 1pt wide -->
  <!--  1*+1unit       = proportional width + some fixed width -->
  <!--      1*+1       = proportional width + some fixed width -->

  <!-- If it has a proportional width, translate it to XSL -->
  <xsl:if test="contains($colwidth, '*')">
    <xsl:text>proportional-column-width(</xsl:text>
    <xsl:value-of select="substring-before($colwidth, '*')"/>
    <xsl:text>)</xsl:text>
  </xsl:if>

  <!-- Now grab the non-proportional part of the specification -->
  <xsl:variable name="width-units">
    <xsl:choose>
      <xsl:when test="contains($colwidth, '*')">
        <xsl:value-of
             select="normalize-space(substring-after($colwidth, '*'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space($colwidth)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Ok, now the width-units could have any one of the following forms: -->
  <!--                 = <empty string> -->
  <!--     1unit       = 1.0 units wide -->
  <!--         1       = 1pt wide -->
  <!-- with an optional leading sign -->

  <!-- Grab the width part by blanking out the units part and discarding -->
  <!-- whitespace. It's not pretty, but it works. -->
  <xsl:variable name="width"
       select="normalize-space(translate($width-units,
                                         '+-0123456789.abcdefghijklmnopqrstuvwxyz',
                                         '+-0123456789.'))"/>

  <!-- Grab the units part by blanking out the width part and discarding -->
  <!-- whitespace. It's not pretty, but it works. -->
  <xsl:variable name="units"
       select="normalize-space(translate($width-units,
                                         'abcdefghijklmnopqrstuvwxyz+-0123456789.',
                                         'abcdefghijklmnopqrstuvwxyz'))"/>

  <!-- Output the width -->
  <xsl:value-of select="$width"/>

  <!-- Output the units, translated appropriately -->
  <xsl:choose>
    <xsl:when test="$units = 'pi'">pc</xsl:when>
    <xsl:when test="$units = '' and $width != ''">pt</xsl:when>
    <xsl:otherwise><xsl:value-of select="$units"/></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="colspec.colnum">
  <!-- when this macro is called, the current context must be an entry -->
  <xsl:param name="colname"></xsl:param>
  <!-- .. = row, ../.. = thead|tbody, ../../.. = tgroup -->
  <xsl:param name="colspecs" select="../../../../tgroup/colspec"/>
  <xsl:param name="count">1</xsl:param>
  <xsl:param name="colnum">1</xsl:param>
  <xsl:choose>
    <xsl:when test="$count>count($colspecs)"></xsl:when>
    <xsl:otherwise>
      <xsl:variable name="colspec" select="$colspecs[$count=position()]"/>
<!--
      <xsl:value-of select="$count"/>:
      <xsl:value-of select="$colspec/@colname"/>=
      <xsl:value-of select="$colnum"/>
-->
      <xsl:choose>
        <xsl:when test="$colspec/@colname=$colname">
          <xsl:choose>
            <xsl:when test="$colspec/@colnum">
              <xsl:value-of select="$colspec/@colnum"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$colnum"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="colspec.colnum">
            <xsl:with-param name="colname" select="$colname"/>
            <xsl:with-param name="colspecs" select="$colspecs"/>
            <xsl:with-param name="count" select="$count+1"/>
            <xsl:with-param name="colnum">
              <xsl:choose>
                <xsl:when test="$colspec/@colnum">
                  <xsl:value-of select="$colspec/@colnum + 1"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$colnum + 1"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
           </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="calculate.colspan">
  <xsl:variable name="scol">
    <xsl:call-template name="colspec.colnum">
      <xsl:with-param name="colname" select="@namest"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="ecol">
    <xsl:call-template name="colspec.colnum">
      <xsl:with-param name="colname" select="@nameend"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:value-of select="$ecol - $scol + 1"/>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
