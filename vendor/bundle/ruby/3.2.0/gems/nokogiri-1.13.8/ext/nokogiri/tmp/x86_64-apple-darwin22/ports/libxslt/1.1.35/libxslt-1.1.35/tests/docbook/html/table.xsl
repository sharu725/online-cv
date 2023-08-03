<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
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

<lxslt:component prefix="xtbl"
                 functions="adjustColumnWidths"/>

<xsl:template match="tgroup">
  <table>
    <xsl:choose>
      <!-- If there's a <?dbhtml table-summary="foo"?> PI, use it for
           the HTML table summary attribute -->
      <xsl:when test="processing-instruction('dbhtml')">
        <xsl:variable name="summary">
          <xsl:call-template name="dbhtml-attribute">
            <xsl:with-param name="pis"
                            select="processing-instruction('dbhtml')[1]"/>
            <xsl:with-param name="attribute" select="'table-summary'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$summary != ''">
          <xsl:attribute name="summary">
            <xsl:value-of select="$summary"/>
          </xsl:attribute>
        </xsl:if>
      </xsl:when>
      <!-- Otherwise, if there's a title, use that -->
      <xsl:when test="../title">
        <xsl:attribute name="summary">
          <xsl:value-of select="string(../title)"/>
        </xsl:attribute>
      </xsl:when>
      <!-- Otherwise, forget the whole idea -->
      <xsl:otherwise><!-- nevermind --></xsl:otherwise>
    </xsl:choose>

    <xsl:if test="../@pgwide=1">
      <xsl:attribute name="width">100%</xsl:attribute>
    </xsl:if>

<!-- this is wrong, align on tgroup gives the default alignment for table
     cells, not the alignment for the table itself...
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
-->

    <xsl:choose>
      <xsl:when test="../@frame='none'">
        <xsl:attribute name="border">0</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="border">1</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

    <xsl:variable name="colgroup">
      <colgroup>
        <xsl:call-template name="generate.colgroup">
          <xsl:with-param name="cols" select="@cols"/>
        </xsl:call-template>
      </colgroup>
    </xsl:variable>

    <xsl:variable name="explicit.table.width">
      <xsl:call-template name="dbhtml-attribute">
        <xsl:with-param name="pis"
                        select="../processing-instruction('dbhtml')[1]"/>
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

    <xsl:if test="$default.table.width != ''
                  or $explicit.table.width != ''">
      <xsl:attribute name="width">
        <xsl:choose>
          <xsl:when test="contains($table.width, '%')">
            <xsl:value-of select="$table.width"/>
          </xsl:when>
          <xsl:when test="$use.extensions != 0
                          and $tablecolumns.extension != 0">
            <xsl:choose>
              <xsl:when test="contains($vendor, 'SAXON 6')">
                <xsl:value-of select="stbl:convertLength($table.width)"/>
              </xsl:when>
              <xsl:when test="contains($vendor, 'SAXON 5')">
                <!-- the saxon5 extension doesn't support this (yet) -->
                <xsl:value-of select="$table.width"/>
              </xsl:when>
              <xsl:when test="contains($vendor, 'Apache Software Foundation')">
                <xsl:value-of select="xtbl:convertLength($table.width)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:message terminate="yes">
                  <xsl:text>Don't know how to do convert lengths with </xsl:text>
                  <xsl:value-of select="$vendor"/>
                </xsl:message>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$table.width"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$use.extensions != 0
                      and $tablecolumns.extension != 0">
        <xsl:choose>
          <xsl:when test="contains($vendor, 'SAXON 6')">
            <xsl:copy-of select="stbl:adjustColumnWidths($colgroup)"/>
          </xsl:when>
          <xsl:when test="contains($vendor, 'SAXON 5')">
            <!-- the saxon5 extension doesn't support this (yet) -->
            <xsl:copy-of select="$colgroup"/>
          </xsl:when>
          <xsl:when test="contains($vendor, 'Apache Software Foundation')">
            <xsl:copy-of select="xtbl:adjustColumnWidths($colgroup)"/>
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
        <xsl:copy-of select="$colgroup"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates select="thead"/>
    <xsl:apply-templates select="tbody"/>
    <xsl:apply-templates select="tfoot"/>

    <xsl:if test=".//footnote">
      <tr>
        <td colspan="{@cols}">
          <xsl:apply-templates select=".//footnote" 
                               mode="table.footnote.mode"/>
        </td>
      </tr>
    </xsl:if>
  </table>
</xsl:template>

<xsl:template match="tgroup/processing-instruction('dbhtml')">
  <xsl:variable name="summary">
    <xsl:call-template name="dbhtml-attribute">
      <xsl:with-param name="pis" select="."/>
      <xsl:with-param name="attribute" select="'table-summary'"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- Suppress the table-summary PI -->
  <xsl:if test="$summary = ''">
    <xsl:processing-instruction name="dbhtml">
      <xsl:value-of select="."/>
    </xsl:processing-instruction>
  </xsl:if>
</xsl:template>

<xsl:template match="colspec"></xsl:template>

<xsl:template match="spanspec"></xsl:template>

<xsl:template match="thead|tfoot">
  <xsl:element name="{name(.)}">
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="tbody">
  <tbody>
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates/>
  </tbody>
</xsl:template>

<xsl:template match="row">
  <tr>
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates/>
  </tr>
</xsl:template>

<xsl:template match="thead/row/entry">
  <xsl:call-template name="process.cell">
    <xsl:with-param name="cellgi">th</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="tbody/row/entry">
  <xsl:call-template name="process.cell">
    <xsl:with-param name="cellgi">td</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="tfoot/row/entry">
  <xsl:call-template name="process.cell">
    <xsl:with-param name="cellgi">th</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="process.cell">
  <xsl:param name="cellgi">td</xsl:param>
  <xsl:variable name="empty.cell" select="count(node()) = 0"/>

  <xsl:variable name="entry.colnum">
    <xsl:call-template name="entry.colnum"/>
  </xsl:variable>

  <xsl:if test="$entry.colnum != ''">
    <xsl:variable name="prev.entry" select="preceding-sibling::*[1]"/>
    <xsl:variable name="prev.ending.colnum">
      <xsl:choose>
        <xsl:when test="$prev.entry">
          <xsl:call-template name="entry.ending.colnum">
            <xsl:with-param name="entry" select="$prev.entry"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- 1.31: removed add-empty-entries; there's no practical way for
         XSLT to keep track of "overhang" from morerows in previous rows.
         At least none that I can think of. -->
  </xsl:if>

  <xsl:element name="{$cellgi}">
    <xsl:if test="@morerows">
      <xsl:attribute name="rowspan">
        <xsl:value-of select="@morerows+1"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@namest">
      <xsl:attribute name="colspan">
        <xsl:call-template name="calculate.colspan"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@char">
      <xsl:attribute name="char">
        <xsl:value-of select="@char"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@charoff">
      <xsl:attribute name="charoff">
        <xsl:value-of select="@charoff"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:if test="not(preceding-sibling::*)
                  and ancestor::row/@id">
      <a name="{ancestor::row/@id}"/>
    </xsl:if>

    <xsl:if test="@id">
      <a name="{@id}"/>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$empty.cell">
        <xsl:text>&#160;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:element>
</xsl:template>

<xsl:template name="entry.colnum">
  <xsl:param name="entry" select="."/>

  <xsl:choose>
    <xsl:when test="$entry/@colname">
      <xsl:variable name="colname" select="$entry/@colname"/>
      <xsl:variable name="colspec"
                    select="$entry/ancestor::tgroup/colspec[@colname=$colname]"/>
      <xsl:call-template name="colspec.colnum">
        <xsl:with-param name="colspec" select="$colspec"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$entry/@namest">
      <xsl:variable name="namest" select="$entry/@namest"/>
      <xsl:variable name="colspec"
                    select="$entry/ancestor::tgroup/colspec[@colname=$namest]"/>
      <xsl:call-template name="colspec.colnum">
        <xsl:with-param name="colspec" select="$colspec"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="count($entry/preceding-sibling::*) = 0">1</xsl:when>
    <xsl:otherwise>
      <xsl:variable name="pcol">
        <xsl:call-template name="entry.ending.colnum">
          <xsl:with-param name="entry"
                          select="$entry/preceding-sibling::*[1]"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="$pcol + 1"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<doc:template name="entry.colnum" xmlns="">
<refpurpose>Determine the column number in which a given entry occurs</refpurpose>
<refdescription>
<para>If an <sgmltag>entry</sgmltag> has a
<sgmltag class="attribute">colname</sgmltag> or
<sgmltag class="attribute">namest</sgmltag> attribute, this template
will determine the number of the column in which the entry should occur.
For other <sgmltag>entry</sgmltag>s, nothing is returned.</para>
</refdescription>
<refparameter>
<variablelist>
<varlistentry><term>entry</term>
<listitem>
<para>The <sgmltag>entry</sgmltag>-element which is to be tested.</para>
</listitem>
</varlistentry>
</variablelist>
</refparameter>

<refreturn>
<para>This template returns the column number if it can be determined,
or nothing (the empty string)</para>
</refreturn>
</doc:template>

<xsl:template name="entry.ending.colnum">
  <xsl:param name="entry" select="."/>

  <xsl:choose>
    <xsl:when test="$entry/@colname">
      <xsl:variable name="colname" select="$entry/@colname"/>
      <xsl:variable name="colspec"
                    select="$entry/ancestor::tgroup/colspec[@colname=$colname]"/>
      <xsl:call-template name="colspec.colnum">
        <xsl:with-param name="colspec" select="$colspec"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$entry/@nameend">
      <xsl:variable name="nameend" select="$entry/@nameend"/>
      <xsl:variable name="colspec"
                    select="$entry/ancestor::tgroup/colspec[@colname=$nameend]"/>
      <xsl:call-template name="colspec.colnum">
        <xsl:with-param name="colspec" select="$colspec"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="count($entry/preceding-sibling::*) = 0">1</xsl:when>
    <xsl:otherwise>
      <xsl:variable name="pcol">
        <xsl:call-template name="entry.ending.colnum">
          <xsl:with-param name="entry"
                          select="$entry/preceding-sibling::*[1]"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="$pcol + 1"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="colspec.colnum">
  <xsl:param name="colspec" select="."/>
  <xsl:choose>
    <xsl:when test="$colspec/@colnum">
      <xsl:value-of select="$colspec/@colnum"/>
    </xsl:when>
    <xsl:when test="$colspec/preceding-sibling::colspec">
      <xsl:variable name="prec.colspec.colnum">
        <xsl:call-template name="colspec.colnum">
          <xsl:with-param name="colspec"
                          select="$colspec/preceding-sibling::colspec[1]"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="$prec.colspec.colnum + 1"/>
    </xsl:when>
    <xsl:otherwise>1</xsl:otherwise>
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

<xsl:template name="generate.col">
  <xsl:param name="countcol">1</xsl:param>
  <xsl:param name="colspecs" select="./colspec"/>
  <xsl:param name="count">1</xsl:param>
  <xsl:param name="colnum">1</xsl:param>

  <xsl:choose>
    <xsl:when test="$count>count($colspecs)">
      <col/>
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

      <xsl:choose>
        <xsl:when test="$colspec.colnum=$countcol">
          <col>
            <xsl:if test="$colspec/@colwidth
                          and $use.extensions != 0
                          and $tablecolumns.extension != 0">
              <xsl:attribute name="width">
                <xsl:value-of select="$colspec/@colwidth"/>
              </xsl:attribute>
            </xsl:if>

            <xsl:choose>
              <xsl:when test="$colspec/@align">
                <xsl:attribute name="align">
                  <xsl:value-of select="$colspec/@align"/>
                </xsl:attribute>
              </xsl:when>
              <!-- Suggested by Pavel ZAMPACH <zampach@nemcb.cz> -->
              <xsl:when test="$colspecs/ancestor::tgroup/@align">
                <xsl:attribute name="align">
                  <xsl:value-of select="$colspecs/ancestor::tgroup/@align"/>
                </xsl:attribute>
              </xsl:when>
            </xsl:choose>

            <xsl:if test="$colspec/@char">
              <xsl:attribute name="char">
                <xsl:value-of select="$colspec/@char"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:if test="$colspec/@charoff">
              <xsl:attribute name="charoff">
                <xsl:value-of select="$colspec/@charoff"/>
              </xsl:attribute>
            </xsl:if>
          </col>
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

<xsl:template name="colspec.colwidth">
  <!-- when this macro is called, the current context must be an entry -->
  <xsl:param name="colname"></xsl:param>
  <!-- .. = row, ../.. = thead|tbody, ../../.. = tgroup -->
  <xsl:param name="colspecs" select="../../../../tgroup/colspec"/>
  <xsl:param name="count">1</xsl:param>
  <xsl:choose>
    <xsl:when test="$count>count($colspecs)"></xsl:when>
    <xsl:otherwise>
      <xsl:variable name="colspec" select="$colspecs[$count=position()]"/>
      <xsl:choose>
        <xsl:when test="$colspec/@colname=$colname">
          <xsl:value-of select="$colspec/@colwidth"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="colspec.colwidth">
            <xsl:with-param name="colname" select="$colname"/>
            <xsl:with-param name="colspecs" select="$colspecs"/>
            <xsl:with-param name="count" select="$count+1"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="calculate.colspan">
  <xsl:param name="entry" select="."/>
  <xsl:variable name="namest" select="$entry/@namest"/>
  <xsl:variable name="nameend" select="$entry/@nameend"/>

  <xsl:variable name="scol">
    <xsl:call-template name="colspec.colnum">
      <xsl:with-param name="colspec"
                      select="$entry/ancestor::tgroup/colspec[@colname=$namest]"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="ecol">
    <xsl:call-template name="colspec.colnum">
      <xsl:with-param name="colspec"
                      select="$entry/ancestor::tgroup/colspec[@colname=$nameend]"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:value-of select="$ecol - $scol + 1"/>
</xsl:template>

</xsl:stylesheet>

