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

<xsl:template match="bibliography">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block id="{$id}">
    <xsl:call-template name="component.separator"/>
    <xsl:call-template name="bibliography.titlepage"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="book/bibliography">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="master-name">
    <xsl:call-template name="select.pagemaster"/>
  </xsl:variable>

  <fo:page-sequence id="{$id}"
                    hyphenate="{$hyphenate}"
                    master-name="{$master-name}">
    <xsl:attribute name="language">
      <xsl:call-template name="l10n.language"/>
    </xsl:attribute>
    <xsl:if test="$double.sided != 0">
      <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
    </xsl:if>

    <xsl:apply-templates select="." mode="running.head.mode">
      <xsl:with-param name="master-name" select="$master-name"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="." mode="running.foot.mode">
      <xsl:with-param name="master-name" select="$master-name"/>
    </xsl:apply-templates>

    <fo:flow flow-name="xsl-region-body">
      <xsl:call-template name="bibliography.titlepage"/>
      <xsl:apply-templates/>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template match="bibliography/bibliographyinfo"></xsl:template>
<xsl:template match="bibliography/title"></xsl:template>
<xsl:template match="bibliography/subtitle"></xsl:template>
<xsl:template match="bibliography/titleabbrev"></xsl:template>

<xsl:template match="bibliography/title" mode="component.title.mode">
  <fo:block xsl:use-attribute-sets="component.title.properties">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="bibliography/subtitle" mode="component.title.mode">
  <fo:block font-size="18pt" font-weight="bold" font-style="italic">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="bibliodiv">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="bibliodiv/title">
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select=".."/>
    </xsl:call-template>
  </xsl:variable>
  <fo:block font-size="16pt" font-weight="bold">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="biblioentry">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:block id="{$id}" xsl:use-attribute-sets="normal.para.spacing">
    <xsl:apply-templates mode="bibliography.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="bibliomixed">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <fo:block id="{$id}" xsl:use-attribute-sets="normal.para.spacing">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="bibliography.mode">
  <xsl:apply-templates select="."/><!-- try the default mode -->
</xsl:template>

<xsl:template match="abbrev" mode="bibliography.mode">
  <fo:inline>
    <xsl:text>[</xsl:text>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:text>] </xsl:text>
  </fo:inline>
</xsl:template>

<xsl:template match="abstract" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="address" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="affiliation" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="shortaffil" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="jobtitle" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="artheader|articleinfo" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="artpagenums" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="author" mode="bibliography.mode">
  <fo:inline>
    <xsl:call-template name="person.name"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="authorblurb" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="authorgroup" mode="bibliography.mode">
  <fo:inline>
    <xsl:call-template name="person.name.list"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="authorinitials" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="bibliomisc" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="bibliomset" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="biblioset" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="biblioset/title|biblioset/citetitle" 
              mode="bibliography.mode">
  <xsl:variable name="relation" select="../@relation"/>
  <xsl:choose>
    <xsl:when test="$relation='article'">
      <xsl:call-template name="dingbat">
        <xsl:with-param name="dingbat">ldquo</xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates/>
      <xsl:call-template name="dingbat">
        <xsl:with-param name="dingbat">rdquo</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <fo:inline font-style="italic">
        <xsl:apply-templates/>
      </fo:inline>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="$biblioentry.item.separator"/>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="bookbiblio" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="citetitle" mode="bibliography.mode">
  <fo:inline>
    <fo:inline font-style="italic">
      <xsl:apply-templates mode="bibliography.mode"/>
    </fo:inline>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="collab" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="confgroup" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="contractnum" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="contractsponsor" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="contrib" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="copyright" mode="bibliography.mode">
  <fo:inline>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'Copyright'"/>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="dingbat">
      <xsl:with-param name="dingbat">copyright</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:apply-templates select="year" mode="bibliography.mode"/>
    <xsl:if test="holder">
      <xsl:call-template name="gentext.space"/>
      <xsl:apply-templates select="holder" mode="bibliography.mode"/>
    </xsl:if>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="year" mode="bibliography.mode">
  <xsl:apply-templates/><xsl:text>, </xsl:text>
</xsl:template>

<xsl:template match="year[position()=last()]" mode="bibliography.mode">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="holder" mode="bibliography.mode">
  <xsl:apply-templates/>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="corpauthor" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="corpname" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="date" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="edition" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="editor" mode="bibliography.mode">
  <fo:inline>
    <xsl:call-template name="person.name"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="firstname" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="honorific" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="indexterm" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="invpartnumber" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="isbn" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="issn" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="issuenum" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="lineage" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="orgname" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="othercredit" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="othername" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="pagenums" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="printhistory" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="productname" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="productnumber" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="pubdate" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="publisher" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="publishername" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="pubsnumber" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="releaseinfo" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="revhistory" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="seriesinfo" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="seriesvolnums" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="subtitle" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="surname" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="title" mode="bibliography.mode">
  <fo:inline>
    <fo:inline font-style="italic">
      <xsl:apply-templates mode="bibliography.mode"/>
    </fo:inline>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="titleabbrev" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="volumenum" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="orgdiv" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="collabname" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="confdates" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="conftitle" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="confnum" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<xsl:template match="confsponsor" mode="bibliography.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </fo:inline>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="bibliomixed.mode">
  <xsl:apply-templates select="."/><!-- try the default mode -->
</xsl:template>

<xsl:template match="abbrev" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="abstract" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="address" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="affiliation" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="shortaffil" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="jobtitle" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliography.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="artpagenums" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="author" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:call-template name="person.name"/>
  </fo:inline>
</xsl:template>

<xsl:template match="authorblurb" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="authorgroup" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="authorinitials" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="bibliomisc" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="bibliomset" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="bibliomset/title|bibliomset/citetitle" 
              mode="bibliomixed.mode">
  <xsl:variable name="relation" select="../@relation"/>
  <xsl:choose>
    <xsl:when test="$relation='article'">
      <xsl:call-template name="dingbat">
        <xsl:with-param name="dingbat">ldquo</xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates/>
      <xsl:call-template name="dingbat">
        <xsl:with-param name="dingbat">rdquo</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <fo:inline font-style="italic">
        <xsl:apply-templates/>
      </fo:inline>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="biblioset" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="citetitle" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="collab" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="confgroup" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="contractnum" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="contractsponsor" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="contrib" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="copyright" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="corpauthor" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="corpname" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="date" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="edition" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="editor" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="firstname" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="honorific" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="indexterm" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="invpartnumber" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="isbn" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="issn" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="issuenum" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="lineage" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="orgname" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="othercredit" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="othername" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="pagenums" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="printhistory" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="productname" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="productnumber" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="pubdate" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="publisher" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="publishername" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="pubsnumber" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="releaseinfo" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="revhistory" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="seriesvolnums" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="subtitle" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="surname" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="title" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="titleabbrev" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<xsl:template match="volumenum" mode="bibliomixed.mode">
  <fo:inline>
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </fo:inline>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
