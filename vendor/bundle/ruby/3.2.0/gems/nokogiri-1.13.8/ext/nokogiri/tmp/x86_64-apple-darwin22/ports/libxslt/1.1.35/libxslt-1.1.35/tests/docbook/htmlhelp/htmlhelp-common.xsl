<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                version="1.0">

<!-- ********************************************************************
     $Id$
     ******************************************************************** 

     This file is used by htmlhelp.xsl if you want to generate source
     files for HTML Help.  It is based on the XSL DocBook Stylesheet
     distribution (especially on JavaHelp code) from Norman Walsh.

     ******************************************************************** -->

<!-- ==================================================================== -->
<xsl:param name="htmlhelp.encoding" select="'iso-8859-1'"/>

<doc:param name="htmlhelp.encoding" xmlns="">
<refpurpose>Character encoding to use in files for HTML Help compiler.</refpurpose>
<refdescription>
<para>HTML Help Compiler is not UTF-8 aware, so you should always use
apropriate single-byte encoding here.</para>
</refdescription>
</doc:param>

<xsl:param name="suppress.navigation" select="1"/>

<!-- ==================================================================== -->

<xsl:template match="/">
  <xsl:apply-templates/>
  <xsl:call-template name="hhp"/>
  <xsl:call-template name="hhc"/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="hhp">
  <xsl:call-template name="write.text.chunk">
    <xsl:with-param name="filename" select="'htmlhelp.hhp'"/>
    <xsl:with-param name="method" select="'text'"/>
    <xsl:with-param name="content">
      <xsl:call-template name="hhp-main"/>
    </xsl:with-param>
    <xsl:with-param name="encoding" select="$htmlhelp.encoding"/>
  </xsl:call-template>
</xsl:template>

<!-- ==================================================================== -->
<xsl:template name="hhp-main">
<xsl:text>[OPTIONS]
</xsl:text>
<xsl:if test="//indexterm">
<xsl:text>Auto Index=Yes
</xsl:text></xsl:if>
<xsl:text>Compatibility=1.1 or later
Compiled file=htmlhelp.chm
Contents file=toc.hhc
Default topic=</xsl:text>
 <xsl:call-template name="make-relative-filename">
   <xsl:with-param name="base.dir" select="$base.dir"/>
   <xsl:with-param name="base.name">
     <xsl:apply-templates mode="chunk-filename" select="/"/>
   </xsl:with-param>
 </xsl:call-template>
<xsl:text>
Display compile progress=No
Full-text search=Yes
Language=</xsl:text>
<xsl:if test="//@lang">
  <xsl:variable name="lang" select="//@lang[1]"/>
  <xsl:value-of select="document('langcodes.xml')//gentext[@lang=string($lang)]"/>
</xsl:if>
<xsl:if test="not(//@lang)">
  <xsl:text>0x0409 English (United States)
</xsl:text></xsl:if>
<xsl:text>
Title=</xsl:text><xsl:value-of select="//title[1]"/>
<xsl:text>

[FILES]
</xsl:text>
<xsl:apply-templates mode="enumerate-files"/>
</xsl:template>
<!-- ==================================================================== -->

<xsl:template match="set|book|part|preface|chapter|appendix
                     |article
                     |reference|refentry
                     |sect1[position()>1]
                     |section[position()>1 and name(parent::*) != 'section']
                     |book/glossary|article/glossary
                     |book/bibliography|article/bibliography
                     |colophon"
              mode="enumerate-files">
  <xsl:variable name="ischunk"><xsl:call-template name="chunk"/></xsl:variable>
  <xsl:if test="$ischunk='1'">
    <xsl:call-template name="make-relative-filename">
      <xsl:with-param name="base.dir" select="$base.dir"/>
      <xsl:with-param name="base.name">
        <xsl:apply-templates mode="chunk-filename" select="."/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text>&#10;</xsl:text>
  </xsl:if>
  <xsl:apply-templates select="*" mode="enumerate-files"/>
</xsl:template>

<xsl:template match="text()" mode="enumerate-files">
</xsl:template>

<!-- ==================================================================== -->

<!-- Following templates are not nice. It is because MS help compiler is unable
     to process correct HTML files. We must generate following weird
     stuff instead. -->

<xsl:template name="hhc">
  <xsl:call-template name="write.text.chunk">
    <xsl:with-param name="filename" select="'toc.hhc'"/>
    <xsl:with-param name="method" select="'text'"/>
    <xsl:with-param name="content">
      <xsl:call-template name="hhc-main"/>
    </xsl:with-param>
    <xsl:with-param name="encoding" select="$htmlhelp.encoding"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="hhc-main">
    <xsl:text>&lt;HTML&gt;
&lt;HEAD&gt;
&lt;/HEAD&gt;
&lt;BODY&gt;
&lt;OBJECT type="text/site properties"&gt;
	&lt;param name="ImageType" value="Folder"&gt;
&lt;/OBJECT&gt;
&lt;UL&gt;
</xsl:text>
      <xsl:apply-templates select="." mode="hhc"/>
<xsl:text>&lt;/UL&gt;
&lt;/BODY&gt;
&lt;/HTML&gt;</xsl:text>
</xsl:template>

<xsl:template match="set" mode="hhc">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:text>&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
    &lt;param name="Name" value="</xsl:text>
	<xsl:value-of select="$title"/>
    <xsl:text>"&gt;
    &lt;param name="Local" value="</xsl:text>
	<xsl:call-template name="href.target.with.base.dir"/>
    <xsl:text>"&gt;
  &lt;/OBJECT&gt;</xsl:text>
  <xsl:if test="book">
    <xsl:text>&lt;UL&gt;</xsl:text>
      <xsl:apply-templates select="book" mode="hhc"/>
    <xsl:text>&lt;/UL&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="book" mode="hhc">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:text>&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
    &lt;param name="Name" value="</xsl:text>
	<xsl:value-of select="$title"/>
    <xsl:text>"&gt;
    &lt;param name="Local" value="</xsl:text>
	<xsl:call-template name="href.target.with.base.dir"/>
    <xsl:text>"&gt;
  &lt;/OBJECT&gt;</xsl:text>
  <xsl:if test="part|reference|preface|chapter|appendix|article|colophon">
    <xsl:text>&lt;UL&gt;</xsl:text>
      <xsl:apply-templates select="part|reference|preface|chapter|appendix|article|colophon"
			   mode="hhc"/>
    <xsl:text>&lt;/UL&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="part|reference|preface|chapter|appendix|article"
              mode="hhc">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:text>&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
    &lt;param name="Name" value="</xsl:text>
	<xsl:value-of select="$title"/>
    <xsl:text>"&gt;
    &lt;param name="Local" value="</xsl:text>
	<xsl:call-template name="href.target.with.base.dir"/>
    <xsl:text>"&gt;
  &lt;/OBJECT&gt;</xsl:text>
  <xsl:if test="reference|preface|chapter|appendix|refentry|section|sect1">
    <xsl:text>&lt;UL&gt;</xsl:text>
      <xsl:apply-templates
	select="reference|preface|chapter|appendix|refentry|section|sect1"
	mode="hhc"/>
    <xsl:text>&lt;/UL&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="section" mode="hhc">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:text>&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
    &lt;param name="Name" value="</xsl:text>
	<xsl:value-of select="$title"/>
    <xsl:text>"&gt;
    &lt;param name="Local" value="</xsl:text>
	<xsl:call-template name="href.target.with.base.dir"/>
    <xsl:text>"&gt;
  &lt;/OBJECT&gt;</xsl:text>
  <xsl:if test="section">
    <xsl:text>&lt;UL&gt;</xsl:text>
      <xsl:apply-templates select="section" mode="hhc"/>
    <xsl:text>&lt;/UL&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="sect1" mode="hhc">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:text>&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
    &lt;param name="Name" value="</xsl:text>
	<xsl:value-of select="$title"/>
    <xsl:text>"&gt;
    &lt;param name="Local" value="</xsl:text>
	<xsl:call-template name="href.target.with.base.dir"/>
    <xsl:text>"&gt;
  &lt;/OBJECT&gt;</xsl:text>
  <xsl:if test="sect2">
    <xsl:text>&lt;UL&gt;</xsl:text>
      <xsl:apply-templates select="sect2"
			   mode="hhc"/>
    <xsl:text>&lt;/UL&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="sect2" mode="hhc">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:text>&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
    &lt;param name="Name" value="</xsl:text>
	<xsl:value-of select="$title"/>
    <xsl:text>"&gt;
    &lt;param name="Local" value="</xsl:text>
	<xsl:call-template name="href.target.with.base.dir"/>
    <xsl:text>"&gt;
  &lt;/OBJECT&gt;</xsl:text>
  <xsl:if test="sect3">
    <xsl:text>&lt;UL&gt;</xsl:text>
      <xsl:apply-templates select="sect3"
			   mode="hhc"/>
    <xsl:text>&lt;/UL&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="sect3" mode="hhc">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:text>&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
    &lt;param name="Name" value="</xsl:text>
	<xsl:value-of select="$title"/>
    <xsl:text>"&gt;
    &lt;param name="Local" value="</xsl:text>
	<xsl:call-template name="href.target.with.base.dir"/>
    <xsl:text>"&gt;
  &lt;/OBJECT&gt;</xsl:text>
  <xsl:if test="sect4">
    <xsl:text>&lt;UL&gt;</xsl:text>
      <xsl:apply-templates select="sect4"
			   mode="hhc"/>
    <xsl:text>&lt;/UL&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="sect4" mode="hhc">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:text>&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
    &lt;param name="Name" value="</xsl:text>
	<xsl:value-of select="$title"/>
    <xsl:text>"&gt;
    &lt;param name="Local" value="</xsl:text>
	<xsl:call-template name="href.target.with.base.dir"/>
    <xsl:text>"&gt;
  &lt;/OBJECT&gt;</xsl:text>
  <xsl:if test="sect5">
    <xsl:text>&lt;UL&gt;</xsl:text>
      <xsl:apply-templates select="sect5"
			   mode="hhc"/>
    <xsl:text>&lt;/UL&gt;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="sect5|refentry|colophon" mode="hhc">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:text>&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
    &lt;param name="Name" value="</xsl:text>
	<xsl:value-of select="$title"/>
    <xsl:text>"&gt;
    &lt;param name="Local" value="</xsl:text>
	<xsl:call-template name="href.target.with.base.dir"/>
    <xsl:text>"&gt;
  &lt;/OBJECT&gt;</xsl:text>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="indexterm">

  <xsl:variable name="text">
    <xsl:value-of select="primary"/>
    <xsl:if test="secondary">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="secondary"/>
    </xsl:if>
    <xsl:if test="tertiary">
      <xsl:text>, </xsl:text>
      <xsl:value-of select="tertiary"/>
    </xsl:if>
  </xsl:variable>

  <OBJECT type="application/x-oleobject"
          classid="clsid:1e2a7bd0-dab9-11d0-b93a-00c04fc99f9e">
    <param name="Keyword" value="{$text}"/>
  </OBJECT>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="href.target.with.base.dir">
  <xsl:value-of select="$base.dir"/>
  <xsl:call-template name="href.target"/>
</xsl:template>


</xsl:stylesheet>
