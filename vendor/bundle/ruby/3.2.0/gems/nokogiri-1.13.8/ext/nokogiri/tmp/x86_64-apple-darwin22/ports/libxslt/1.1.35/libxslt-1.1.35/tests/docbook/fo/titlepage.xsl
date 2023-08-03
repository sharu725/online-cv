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

<xsl:attribute-set name="book.titlepage.recto.style">
  <xsl:attribute name="font-family">
    <xsl:value-of select="$title.font.family"/>
  </xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="book.titlepage.verso.style">
  <xsl:attribute name="font-size">10pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="article.titlepage.recto.style"/>
<xsl:attribute-set name="article.titlepage.verso.style"/>

<xsl:attribute-set name="set.titlepage.recto.style"/>
<xsl:attribute-set name="set.titlepage.verso.style"/>

<xsl:attribute-set name="part.titlepage.recto.style">
  <xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="part.titlepage.verso.style"/>

<xsl:attribute-set name="partintro.titlepage.recto.style"/>
<xsl:attribute-set name="partintro.titlepage.verso.style"/>

<xsl:attribute-set name="reference.titlepage.recto.style"/>
<xsl:attribute-set name="reference.titlepage.verso.style"/>

<xsl:attribute-set name="dedication.titlepage.recto.style"/>
<xsl:attribute-set name="dedication.titlepage.verso.style"/>

<xsl:attribute-set name="preface.titlepage.recto.style"/>
<xsl:attribute-set name="preface.titlepage.verso.style"/>

<xsl:attribute-set name="chapter.titlepage.recto.style"/>
<xsl:attribute-set name="chapter.titlepage.verso.style"/>

<xsl:attribute-set name="appendix.titlepage.recto.style"/>
<xsl:attribute-set name="appendix.titlepage.verso.style"/>

<xsl:attribute-set name="bibliography.titlepage.recto.style"/>
<xsl:attribute-set name="bibliography.titlepage.verso.style"/>

<xsl:attribute-set name="glossary.titlepage.recto.style"/>
<xsl:attribute-set name="glossary.titlepage.verso.style"/>

<xsl:attribute-set name="index.titlepage.recto.style"/>
<xsl:attribute-set name="index.titlepage.verso.style"/>

<xsl:attribute-set name="section.titlepage.recto.style"/>
<xsl:attribute-set name="section.titlepage.verso.style"/>

<xsl:attribute-set name="sect1.titlepage.recto.style"
                   use-attribute-sets="section.titlepage.recto.style"/>
<xsl:attribute-set name="sect1.titlepage.verso.style"
                   use-attribute-sets="section.titlepage.verso.style"/>

<xsl:attribute-set name="sect2.titlepage.recto.style"
                   use-attribute-sets="section.titlepage.recto.style"/>
<xsl:attribute-set name="sect2.titlepage.verso.style"
                   use-attribute-sets="section.titlepage.verso.style"/>

<xsl:attribute-set name="sect3.titlepage.recto.style"
                   use-attribute-sets="section.titlepage.recto.style"/>
<xsl:attribute-set name="sect3.titlepage.verso.style"
                   use-attribute-sets="section.titlepage.verso.style"/>

<xsl:attribute-set name="sect4.titlepage.recto.style"
                   use-attribute-sets="section.titlepage.recto.style"/>
<xsl:attribute-set name="sect4.titlepage.verso.style"
                   use-attribute-sets="section.titlepage.verso.style"/>

<xsl:attribute-set name="sect5.titlepage.recto.style"
                   use-attribute-sets="section.titlepage.recto.style"/>
<xsl:attribute-set name="sect5.titlepage.verso.style"
                   use-attribute-sets="section.titlepage.verso.style"/>

<xsl:attribute-set name="simplesect.titlepage.recto.style"
                   use-attribute-sets="section.titlepage.recto.style"/>
<xsl:attribute-set name="simplesect.titlepage.verso.style"
                   use-attribute-sets="section.titlepage.verso.style"/>

<xsl:attribute-set name="table.of.contents.titlepage.recto.style"/>
<xsl:attribute-set name="table.of.contents.titlepage.verso.style"/>

<xsl:attribute-set name="list.of.tables.titlepage.recto.style"/>
<xsl:attribute-set name="list.of.tables.contents.titlepage.verso.style"/>

<xsl:attribute-set name="list.of.figures.titlepage.recto.style"/>
<xsl:attribute-set name="list.of.figures.contents.titlepage.verso.style"/>

<xsl:attribute-set name="list.of.equations.titlepage.recto.style"/>
<xsl:attribute-set name="list.of.equations.contents.titlepage.verso.style"/>

<xsl:attribute-set name="list.of.examples.titlepage.recto.style"/>
<xsl:attribute-set name="list.of.examples.contents.titlepage.verso.style"/>

<xsl:attribute-set name="list.of.unknowns.titlepage.recto.style"/>
<xsl:attribute-set name="list.of.unknowns.contents.titlepage.verso.style"/>

<!-- ==================================================================== -->

<xsl:template match="*" mode="titlepage.mode">
  <!-- if an element isn't found in this mode, try the default mode -->
  <xsl:apply-templates select="."/>
</xsl:template>

<xsl:template match="abbrev" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="abstract" mode="titlepage.mode">
  <fo:block>
    <xsl:if test="title"> <!-- FIXME: add param for using default title? -->
      <xsl:call-template name="formal.object.heading">
        <xsl:with-param name="title">
          <xsl:apply-templates select="." mode="title.markup"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="abstract/title" mode="titlepage.mode"/>

<xsl:template match="abstract/title" mode="titlepage.abstract.title.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="address" mode="titlepage.mode">
  <!-- use the normal address handling code -->
  <xsl:apply-templates select="."/>
</xsl:template>

<xsl:template match="affiliation" mode="titlepage.mode">
  <fo:block>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="artpagenums" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="author" mode="titlepage.mode">
  <xsl:call-template name="person.name"/>
  <xsl:apply-templates select="affiliation" mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="authorblurb" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="authorgroup" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="authorinitials" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="bibliomisc" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="bibliomset" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="collab" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="confgroup" mode="titlepage.mode">
  <fo:block>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="confdates" mode="titlepage.mode">
  <fo:block>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="conftitle" mode="titlepage.mode">
  <fo:block>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="confnum" mode="titlepage.mode">
  <!-- suppress -->
</xsl:template>

<xsl:template match="contractnum" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="contractsponsor" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="contrib" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="copyright" mode="titlepage.mode">
  <xsl:variable name="years" select="year"/>
  <xsl:variable name="holders" select="holder"/>

  <xsl:call-template name="gentext">
    <xsl:with-param name="key" select="'Copyright'"/>
  </xsl:call-template>
  <xsl:call-template name="gentext.space"/>
  <xsl:call-template name="dingbat">
    <xsl:with-param name="dingbat">copyright</xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="gentext.space"/>
  <xsl:apply-templates select="$years" mode="titlepage.mode"/>
  <xsl:if test="holder">
    <xsl:call-template name="gentext.space"/>
    <xsl:apply-templates select="$holders" mode="titlepage.mode"/>
  </xsl:if>
</xsl:template>

<xsl:template match="year" mode="titlepage.mode">
  <xsl:apply-templates/><xsl:text>, </xsl:text>
</xsl:template>

<xsl:template match="year[position()=last()]" mode="titlepage.mode">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="holder" mode="titlepage.mode">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="corpauthor" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="corpname" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="date" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="edition" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
  <xsl:call-template name="gentext.space"/>
  <xsl:call-template name="gentext">
    <xsl:with-param name="key" select="'Edition'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="editor" mode="titlepage.mode">
  <xsl:call-template name="person.name"/>
</xsl:template>

<xsl:template match="editor[position()=1]" priority="2" mode="titlepage.mode">
  <xsl:call-template name="gentext.edited.by"/>
  <xsl:call-template name="person.name"/>
</xsl:template>

<xsl:template match="firstname" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="graphic" mode="titlepage.mode">
  <!-- use the normal graphic handling code -->
  <xsl:apply-templates select="."/>
</xsl:template>

<xsl:template match="honorific" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="isbn" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="issn" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="itermset" mode="titlepage.mode">
  <!-- discard -->
</xsl:template>

<xsl:template match="invpartnumber" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="issuenum" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="jobtitle" mode="titlepage.mode">
  <fo:block>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="keywordset" mode="titlepage.mode">
</xsl:template>

<xsl:template match="legalnotice" mode="titlepage.mode">
  <fo:block>
    <xsl:if test="title"> <!-- FIXME: add param for using default title? -->
    <xsl:call-template name="formal.object.heading">
        <xsl:with-param name="title">
          <xsl:apply-templates select="." mode="title.markup"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="legalnotice/title" mode="titlepage.mode">
</xsl:template>

<xsl:template match="legalnotice/title" mode="titlepage.legalnotice.title.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="lineage" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="modespec" mode="titlepage.mode">
  <!-- discard -->
</xsl:template>

<xsl:template match="orgdiv" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="orgname" mode="titlepage.mode">
  <fo:block>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="othercredit" mode="titlepage.mode">
  <xsl:call-template name="person.name"/>
  <xsl:apply-templates mode="titlepage.mode" select="affiliation"/>
</xsl:template>

<xsl:template match="othername" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="pagenums" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="printhistory" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="productname" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="productnumber" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="pubdate" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="publisher" mode="titlepage.mode">
  <fo:block>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="publishername" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="pubsnumber" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="releaseinfo" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="revhistory" mode="titlepage.mode">
  <fo:table table-layout="fixed">
    <fo:table-column column-number="1" column-width="33%"/>
    <fo:table-column column-number="2" column-width="33%"/>
    <fo:table-column column-number="3" column-width="33%"/>
    <fo:table-body>
      <fo:table-row>
        <fo:table-cell number-columns-spanned="3">
          <fo:block>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'RevHistory'"/>
            </xsl:call-template>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
      <xsl:apply-templates mode="titlepage.mode"/>
    </fo:table-body>
  </fo:table>
</xsl:template>

<xsl:template match="revhistory/revision" mode="titlepage.mode">
  <xsl:variable name="revnumber" select=".//revnumber"/>
  <xsl:variable name="revdate"   select=".//date"/>
  <xsl:variable name="revauthor" select=".//authorinitials"/>
  <xsl:variable name="revremark" select=".//revremark"/>
  <fo:table-row>
    <fo:table-cell>
      <fo:block>
        <xsl:if test="$revnumber">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="'Revision'"/>
          </xsl:call-template>
          <xsl:call-template name="gentext.space"/>
          <xsl:apply-templates select="$revnumber[1]" mode="titlepage.mode"/>
        </xsl:if>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell>
      <fo:block>
        <xsl:apply-templates select="$revdate[1]" mode="titlepage.mode"/>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell>
      <fo:block>
        <xsl:apply-templates select="$revauthor[1]" mode="titlepage.mode"/>
      </fo:block>
    </fo:table-cell>
  </fo:table-row>
  <xsl:if test="$revremark">
    <fo:table-row>
      <fo:table-cell number-columns-spanned="3">
        <fo:block>
          <xsl:apply-templates select="$revremark[1]" mode="titlepage.mode"/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:if>
</xsl:template>

<xsl:template match="revision/revnumber" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="revision/date" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="revision/authorinitials" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="revision/revremark" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="seriesvolnums" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="shortaffil" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="subjectset" mode="titlepage.mode">
  <!-- discard -->
</xsl:template>

<xsl:template match="subtitle" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="surname" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="titleabbrev" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="volumenum" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<!-- ==================================================================== -->
<!-- Book templates -->

<!-- book recto -->

<xsl:template match="authorgroup" mode="book.titlepage.recto.mode">
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode"/>
</xsl:template>

<!-- book verso -->

<xsl:template match="title" mode="book.titlepage.verso.mode">
  <fo:block>
    <xsl:apply-templates mode="book.titlepage.verso.mode"/>

    <xsl:if test="following-sibling::subtitle
                  |following-sibling::bookinfo/subtitle">
      <xsl:text>: </xsl:text>

      <xsl:apply-templates select="(following-sibling::subtitle
                                   |following-sibling::bookinfo/subtitle)[1]"
                           mode="book.titlepage.verso.mode"/>
    </xsl:if>
  </fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="book.titlepage.verso.mode">
  <xsl:apply-templates mode="book.titlepage.verso.mode"/>
  <xsl:if test="following-sibling::subtitle">
    <xsl:text>: </xsl:text>
    <xsl:apply-templates select="following-sibling::subtitle[1]"/>
  </xsl:if>
</xsl:template>

<xsl:template match="bookinfo/author" mode="book.titlepage.verso.mode">
  <fo:block>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'by'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="person.name"/>
  </fo:block>
</xsl:template>

<xsl:template match="bookinfo/corpauthor" mode="book.titlepage.verso.mode">
  <fo:block>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'by'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="book.titlepage.verso.mode">
  <fo:block>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'by'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:apply-templates mode="book.titlepage.verso.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="authorgroup/author" mode="book.titlepage.verso.mode">
  <xsl:variable name="before" select="count(preceding-sibling::*)"/>
  <xsl:variable name="after" select="count(following-sibling::*)"/>

  <xsl:choose>
    <xsl:when test="$before &gt; 1">
      <xsl:text>, </xsl:text>
    </xsl:when>
    <xsl:when test="$before = 1 and $after &gt; 0">
      <xsl:text>, </xsl:text>
    </xsl:when>
  </xsl:choose>

  <xsl:if test="$before &gt; 0 and $after = 0">
    <xsl:text> </xsl:text>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'and'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
  </xsl:if>

  <xsl:call-template name="person.name"/>
</xsl:template>

<xsl:template match="authorgroup/corpauthor" mode="book.titlepage.verso.mode">
  <xsl:variable name="before" select="count(preceding-sibling::*)"/>
  <xsl:variable name="after" select="count(following-sibling::*)"/>

  <xsl:choose>
    <xsl:when test="$before &gt; 1">
      <xsl:text>, </xsl:text>
    </xsl:when>
    <xsl:when test="$before = 1 and $after &gt; 0">
      <xsl:text>, </xsl:text>
    </xsl:when>
  </xsl:choose>

  <xsl:if test="$after = 0 and $before &gt; 0">
    <xsl:text> </xsl:text>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'and'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
  </xsl:if>

  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="pubdate" mode="book.titlepage.verso.mode">
  <fo:block>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'published'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:apply-templates mode="book.titlepage.verso.mode"/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->
<!-- Part templates -->

<!-- part recto -->

<xsl:template match="title" mode="part.titlepage.recto.mode">
  <xsl:apply-templates select="ancestor::part" mode="title.markup"/>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
