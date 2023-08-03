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

<xsl:attribute-set name="book.titlepage.recto.style"/>
<xsl:attribute-set name="book.titlepage.verso.style"/>

<xsl:attribute-set name="article.titlepage.recto.style"/>
<xsl:attribute-set name="article.titlepage.verso.style"/>

<xsl:attribute-set name="set.titlepage.recto.style"/>
<xsl:attribute-set name="set.titlepage.verso.style"/>

<xsl:attribute-set name="part.titlepage.recto.style"/>
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
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="abstract" mode="titlepage.mode">
  <div class="{name(.)}">
    <xsl:call-template name="formal.object.heading">
      <xsl:with-param name="title">
        <xsl:apply-templates select="." mode="title.markup"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates mode="titlepage.mode"/>
  </div>
</xsl:template>

<xsl:template match="abstract/title" mode="titlepage.mode">
</xsl:template>

<xsl:template match="address" mode="titlepage.mode">
  <xsl:apply-templates select="."/>
</xsl:template>

<xsl:template match="affiliation" mode="titlepage.mode">
  <div class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </div>
</xsl:template>

<xsl:template match="artpagenums" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="author" mode="titlepage.mode">
  <h3 class="{name(.)}"><xsl:call-template name="person.name"/></h3>
  <xsl:apply-templates mode="titlepage.mode" select="./affiliation"/>
</xsl:template>

<xsl:template match="authorblurb" mode="titlepage.mode">
  <div class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </div>
</xsl:template>

<xsl:template match="authorgroup" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="authorinitials" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="bibliomisc" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="bibliomset" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="collab" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="confgroup" mode="titlepage.mode">
  <div class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </div>
</xsl:template>

<xsl:template match="confdates" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="conftitle" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="confnum" mode="titlepage.mode">
  <!-- suppress -->
</xsl:template>

<xsl:template match="contractnum" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="contractsponsor" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="contrib" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="copyright" mode="titlepage.mode">
  <xsl:variable name="years" select="year"/>
  <xsl:variable name="holders" select="holder"/>

  <p class="{name(.)}">
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'Copyright'"/>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="dingbat">
      <xsl:with-param name="dingbat">copyright</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:apply-templates select="$years" mode="titlepage.mode"/>
    <xsl:call-template name="gentext.space"/>
<!--
    <xsl:call-template name="gentext.by"/>
    <xsl:call-template name="gentext.space"/>
-->
    <xsl:apply-templates select="$holders" mode="titlepage.mode"/>
  </p>
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
  <h3 class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </h3>
</xsl:template>

<xsl:template match="corpname" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="date" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="edition" mode="titlepage.mode">
  <p class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'Edition'"/>
    </xsl:call-template>
  </p>
</xsl:template>

<xsl:template match="editor" mode="titlepage.mode">
  <h3 class="{name(.)}"><xsl:call-template name="person.name"/></h3>
</xsl:template>

<xsl:template match="editor[position()=1]" mode="titlepage.mode">
  <h4 class="editedby"><xsl:call-template name="gentext.edited.by"/></h4>
  <h3 class="{name(.)}"><xsl:call-template name="person.name"/></h3>
</xsl:template>

<xsl:template match="firstname" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="graphic" mode="titlepage.mode">
  <!-- use the normal graphic handling code -->
  <xsl:apply-templates select="."/>
</xsl:template>

<xsl:template match="honorific" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="isbn" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="issn" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="itermset" mode="titlepage.mode">
</xsl:template>

<xsl:template match="invpartnumber" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="issuenum" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="jobtitle" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="keywordset" mode="titlepage.mode">
</xsl:template>

<xsl:template match="legalnotice " mode="titlepage.mode">
  <div class="{local-name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </div>
</xsl:template>

<xsl:template match="legalnotice/title" mode="titlepage.mode">
  <p class="legalnotice-title"><b><xsl:apply-templates/></b></p>
</xsl:template>

<xsl:template match="lineage" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="modespec" mode="titlepage.mode">
</xsl:template>

<xsl:template match="orgdiv" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="orgname" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="othercredit" mode="titlepage.mode">
  <h3 class="{name(.)}"><xsl:call-template name="person.name"/></h3>
  <xsl:apply-templates mode="titlepage.mode"
   select="./affiliation"/>
</xsl:template>

<xsl:template match="othername" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="pagenums" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="printhistory" mode="titlepage.mode">
  <div class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </div>
</xsl:template>

<xsl:template match="productname" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="productnumber" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="pubdate" mode="titlepage.mode">
  <p class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </p>
</xsl:template>

<xsl:template match="publisher" mode="titlepage.mode">
  <p class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </p>
</xsl:template>

<xsl:template match="publishername" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="pubsnumber" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="releaseinfo" mode="titlepage.mode">
  <p class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </p>
</xsl:template>

<xsl:template match="revhistory" mode="titlepage.mode">
  <xsl:variable name="numcols">
    <xsl:choose>
      <xsl:when test="//authorinitials">3</xsl:when>
      <xsl:otherwise>2</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <div class="{name(.)}">
    <table border="1" width="100%" summary="Revision history">
      <tr>
        <th align="left" valign="top" colspan="{$numcols}">
          <b>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'RevHistory'"/>
            </xsl:call-template>
          </b>
        </th>
      </tr>
      <xsl:apply-templates mode="titlepage.mode">
        <xsl:with-param name="numcols" select="$numcols"/>
      </xsl:apply-templates>
    </table>
  </div>
</xsl:template>

<xsl:template match="revhistory/revision" mode="titlepage.mode">
  <xsl:param name="numcols" select="'3'"/>
  <xsl:variable name="revnumber" select=".//revnumber"/>
  <xsl:variable name="revdate"   select=".//date"/>
  <xsl:variable name="revauthor" select=".//authorinitials"/>
  <xsl:variable name="revremark" select=".//revremark|.//revdescription"/>
  <tr>
    <td align="left">
      <xsl:if test="$revnumber">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'Revision'"/>
        </xsl:call-template>
        <xsl:call-template name="gentext.space"/>
        <xsl:apply-templates select="$revnumber[1]" mode="titlepage.mode"/>
      </xsl:if>
    </td>
    <td align="left">
      <xsl:apply-templates select="$revdate[1]" mode="titlepage.mode"/>
    </td>
    <xsl:choose>
      <xsl:when test="$revauthor">
        <td align="left">
          <xsl:apply-templates select="$revauthor[1]" mode="titlepage.mode"/>
        </td>
      </xsl:when>
      <xsl:when test="$numcols &gt; 2">
        <td>&#160;</td>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </tr>
  <xsl:if test="$revremark">
    <tr>
      <td align="left" colspan="{$numcols}">
        <xsl:apply-templates select="$revremark[1]" mode="titlepage.mode"/>
      </td>
    </tr>
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

<xsl:template match="revision/revdescription" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="seriesvolnums" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="shortaffil" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="subjectset" mode="titlepage.mode">
</xsl:template>

<xsl:template match="subtitle" mode="titlepage.mode">
  <h2 class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
  </h2>
</xsl:template>

<xsl:template match="surname" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<xsl:template match="title" mode="titlepage.mode">
  <xsl:variable name="id">
    <xsl:choose>
      <!-- if title is in an *info wrapper, get the grandparent -->
      <xsl:when test="contains(local-name(..), 'info')">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="../.."/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select=".."/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <h1 class="{name(.)}">
    <a name="{$id}"/>
    <xsl:choose>
      <xsl:when test="$show.revisionflag and @revisionflag">
	<span class="{@revisionflag}">
	  <xsl:apply-templates mode="titlepage.mode"/>
	</span>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates mode="titlepage.mode"/>
      </xsl:otherwise>
    </xsl:choose>
  </h1>
</xsl:template>

<xsl:template match="titleabbrev" mode="titlepage.mode">
  <!-- nop; title abbreviations don't belong on the title page! -->
</xsl:template>

<xsl:template match="volumenum" mode="titlepage.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="titlepage.mode"/>
    <br/>
  </span>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
