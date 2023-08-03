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

<xsl:template match="bibliography">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <div id="{$id}" class="{name(.)}">
    <xsl:call-template name="bibliography.titlepage"/>
    <xsl:apply-templates/>
    <xsl:call-template name="process.footnotes"/>
  </div>
</xsl:template>

<xsl:template match="bibliography/bibliographyinfo"></xsl:template>
<xsl:template match="bibliography/title"></xsl:template>
<xsl:template match="bibliography/subtitle"></xsl:template>
<xsl:template match="bibliography/titleabbrev"></xsl:template>

<xsl:template match="bibliography/title" mode="component.title.mode">
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

<xsl:template match="bibliography/subtitle" mode="component.title.mode">
  <h3>
    <i><xsl:apply-templates/></i>
  </h3>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="bibliodiv">
  <div class="{name(.)}">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="bibliodiv/title">
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

<xsl:template match="biblioentry">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <div id="{$id}" class="{name(.)}">
    <a name="{$id}"/>
    <p>
      <xsl:apply-templates mode="bibliography.mode"/>
    </p>
  </div>
</xsl:template>

<xsl:template match="bibliomixed">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
  <div id="{$id}" class="{name(.)}">
    <a name="{$id}"/>
    <p>
      <xsl:choose>
	<xsl:when test="local-name(*[1]) = 'abbrev'">
	  <xsl:apply-templates select="*[position()>1]|text()"
                               mode="bibliomixed.mode"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates mode="bibliomixed.mode"/>
	</xsl:otherwise>
      </xsl:choose>
    </p>
  </div>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="bibliography.mode">
  <xsl:apply-templates select="."/><!-- try the default mode -->
</xsl:template>

<xsl:template match="abbrev" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:text>[</xsl:text>
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:text>] </xsl:text>
  </span>
</xsl:template>

<xsl:template match="abstract" mode="bibliography.mode">
  <!-- suppressed -->
</xsl:template>

<xsl:template match="address" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="affiliation" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="shortaffil" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="jobtitle" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="artheader|articleinfo" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="artpagenums" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="author" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:call-template name="person.name"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="authorblurb" mode="bibliography.mode">
  <!-- suppressed -->
</xsl:template>

<xsl:template match="authorgroup" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:call-template name="person.name.list"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="authorinitials" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="bibliomisc" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="bibliomset" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="biblioset" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
  </span>
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
      <I><xsl:apply-templates/></I>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="$biblioentry.item.separator"/>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="bookbiblio" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="citetitle" mode="bibliography.mode">
  <span class="{name(.)}">
    <i><xsl:apply-templates mode="bibliography.mode"/></i>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="collab" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="collabname" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="confgroup" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="confdates" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="conftitle" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="confnum" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="confsponsor" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="contractnum" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="contractsponsor" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="contrib" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="copyright" mode="bibliography.mode">
  <span class="{name(.)}">
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
  </span>
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
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="corpname" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="date" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="edition" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="editor" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:call-template name="person.name"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="firstname" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="honorific" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="indexterm" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="invpartnumber" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="isbn" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="issn" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="issuenum" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="lineage" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="orgname" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="orgdiv" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="othercredit" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="othername" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="pagenums" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="printhistory" mode="bibliography.mode">
  <!-- suppressed -->
</xsl:template>

<xsl:template match="productname" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="productnumber" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="pubdate" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="publisher" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
  </span>
</xsl:template>

<xsl:template match="publishername" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="pubsnumber" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="releaseinfo" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="revhistory" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="seriesinfo" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
  </span>
</xsl:template>

<xsl:template match="seriesvolnums" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="subtitle" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="surname" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="title" mode="bibliography.mode">
  <span class="{name(.)}">
    <I><xsl:apply-templates mode="bibliography.mode"/></I>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="titleabbrev" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<xsl:template match="volumenum" mode="bibliography.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliography.mode"/>
    <xsl:value-of select="$biblioentry.item.separator"/>
  </span>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="bibliomixed.mode">
  <xsl:apply-templates select="."/><!-- try the default mode -->
</xsl:template>

<xsl:template match="abbrev" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="abstract" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="address" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="affiliation" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="shortaffil" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="jobtitle" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="artpagenums" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="author" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="authorblurb" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="authorgroup" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="authorinitials" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="bibliomisc" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="bibliomset" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
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
      <I><xsl:apply-templates/></I>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ================================================== -->

<xsl:template match="biblioset" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="citetitle" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <i><xsl:apply-templates mode="bibliomixed.mode"/></i>
  </span>
</xsl:template>

<xsl:template match="collab" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="confgroup" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="contractnum" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="contractsponsor" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="contrib" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="copyright" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="corpauthor" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="corpname" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="date" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="edition" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="editor" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="firstname" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="honorific" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="indexterm" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="invpartnumber" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="isbn" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="issn" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="issuenum" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="lineage" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="orgname" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="othercredit" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="othername" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="pagenums" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="printhistory" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="productname" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="productnumber" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="pubdate" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="publisher" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="publishername" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="pubsnumber" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="releaseinfo" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="revhistory" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="seriesvolnums" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="subtitle" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="surname" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="title" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="titleabbrev" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<xsl:template match="volumenum" mode="bibliomixed.mode">
  <span class="{name(.)}">
    <xsl:apply-templates mode="bibliomixed.mode"/>
  </span>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
