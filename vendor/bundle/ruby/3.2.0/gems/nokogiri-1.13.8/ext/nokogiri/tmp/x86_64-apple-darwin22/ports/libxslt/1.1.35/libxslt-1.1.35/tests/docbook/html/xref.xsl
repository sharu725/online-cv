<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<!-- ==================================================================== -->

<xsl:template match="anchor">
  <a>
    <xsl:attribute name="name">
      <xsl:call-template name="object.id"/>
    </xsl:attribute>
  </a>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="xref">
  <xsl:variable name="targets" select="id(@linkend)"/>
  <xsl:variable name="target" select="$targets[1]"/>
  <xsl:variable name="refelem" select="local-name($target)"/>

  <xsl:call-template name="check.id.unique">
    <xsl:with-param name="linkend" select="@linkend"/>
  </xsl:call-template>

  <xsl:if test="@id">
    <a name="{@id}"/>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="count($target) = 0">
      <xsl:message>
	<xsl:text>XRef to nonexistent id: </xsl:text>
	<xsl:value-of select="@linkend"/>
      </xsl:message>
      <xsl:text>???</xsl:text>
    </xsl:when>

    <xsl:when test="$target/@xreflabel">
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$target"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:call-template name="xref.xreflabel">
          <xsl:with-param name="target" select="$target"/>
        </xsl:call-template>
      </a>
    </xsl:when>

    <xsl:otherwise>
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$target"/>
          </xsl:call-template>
        </xsl:attribute>

        <xsl:choose>
	  <xsl:when test="@endterm">
	    <xsl:variable name="etargets" select="id(@endterm)"/>
	    <xsl:variable name="etarget" select="$etargets[1]"/>
	    <xsl:choose>
	      <xsl:when test="count($etarget) = 0">
		<xsl:message>
		  <xsl:value-of select="count($etargets)"/>
		  <xsl:text>Endterm points to nonexistent ID: </xsl:text>
		  <xsl:value-of select="@endterm"/>
		</xsl:message>
		<xsl:text>???</xsl:text>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:apply-templates select="$etarget" mode="xref.text"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:when>

          <xsl:otherwise>
            <xsl:attribute name="title">
              <xsl:apply-templates select="$target" mode="xref-title"/>
            </xsl:attribute>

            <xsl:apply-templates select="$target" mode="xref-to"/>
          </xsl:otherwise>
        </xsl:choose>
      </a>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="xref-to">
  <xsl:param name="target" select="."/>
  <xsl:param name="refelem" select="local-name($target)"/>

  <xsl:message>
    <xsl:text>Don't know what gentext to create for xref to: "</xsl:text>
    <xsl:value-of select="$refelem"/>
    <xsl:text>"</xsl:text>
  </xsl:message>
  <xsl:text>???</xsl:text>
</xsl:template>

<xsl:template match="author" mode="xref-to">
  <xsl:call-template name="person.name"/>
</xsl:template>

<xsl:template match="figure" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="example" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="table" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="equation" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="cmdsynopsis" mode="xref-to">
  <xsl:apply-templates select="(.//command)[1]" mode="xref"/>
</xsl:template>

<xsl:template match="funcsynopsis" mode="xref-to">
  <xsl:apply-templates select="(.//function)[1]" mode="xref"/>
</xsl:template>

<xsl:template match="dedication" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="preface" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="chapter" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="appendix" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="bibliography" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="biblioentry|bibliomixed" mode="xref-to">
  <!-- handles both biblioentry and bibliomixed -->
  <xsl:text>[</xsl:text>
  <xsl:choose>
    <xsl:when test="local-name(*[1]) = 'abbrev'">
      <xsl:apply-templates select="*[1]"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="@id"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="glossary" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="index" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="section|simplesect
                     |sect1|sect2|sect3|sect4|sect5
                     |refsect1|refsect2|refsect3" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
  <!-- What about "in Chapter X"? -->
</xsl:template>

<xsl:template match="question" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="answer" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="part" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="reference" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<xsl:template match="co" mode="xref-to">
  <xsl:apply-templates select="." mode="callout-bug"/>
</xsl:template>

<xsl:template match="book" mode="xref-to">
  <xsl:apply-templates select="." mode="object.xref.markup"/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="xref-title">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="object.title.markup"/>
  </xsl:variable>

  <xsl:value-of select="$title"/>
</xsl:template>

<xsl:template match="author" mode="xref-title">
  <xsl:variable name="title">
    <xsl:call-template name="person.name"/>
  </xsl:variable>

  <xsl:value-of select="$title"/>
</xsl:template>

<xsl:template match="cmdsynopsis" mode="xref-title">
  <xsl:variable name="title">
    <xsl:apply-templates select="(.//command)[1]" mode="xref"/>
  </xsl:variable>

  <xsl:value-of select="$title"/>
</xsl:template>

<xsl:template match="funcsynopsis" mode="xref-title">
  <xsl:variable name="title">
    <xsl:apply-templates select="(.//function)[1]" mode="xref"/>
  </xsl:variable>

  <xsl:value-of select="$title"/>
</xsl:template>

<xsl:template match="biblioentry|bibliomixed" mode="xref-title">
  <!-- handles both biblioentry and bibliomixed -->
  <xsl:variable name="title">
    <xsl:text>[</xsl:text>
    <xsl:choose>
      <xsl:when test="local-name(*[1]) = 'abbrev'">
        <xsl:apply-templates select="*[1]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@id"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>]</xsl:text>
  </xsl:variable>

  <xsl:value-of select="$title"/>
</xsl:template>

<xsl:template match="co" mode="xref-title">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="callout-bug"/>
  </xsl:variable>

  <xsl:value-of select="$title"/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="link">
  <xsl:variable name="targets" select="id(@linkend)"/>
  <xsl:variable name="target" select="$targets[1]"/>

  <xsl:call-template name="check.id.unique">
    <xsl:with-param name="linkend" select="@linkend"/>
  </xsl:call-template>

  <a>
    <xsl:if test="@id">
      <xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
    </xsl:if>

    <xsl:attribute name="href">
      <xsl:call-template name="href.target">
        <xsl:with-param name="object" select="$target"/>
      </xsl:call-template>
    </xsl:attribute>

    <!-- FIXME: is there a better way to tell what elements have a title? -->
    <xsl:if test="local-name($target) = 'book'
                  or local-name($target) = 'set'
                  or local-name($target) = 'chapter'
                  or local-name($target) = 'preface'
                  or local-name($target) = 'appendix'
                  or local-name($target) = 'bibliography'
                  or local-name($target) = 'glossary'
                  or local-name($target) = 'index'
                  or local-name($target) = 'part'
                  or local-name($target) = 'refentry'
                  or local-name($target) = 'reference'
                  or local-name($target) = 'example'
                  or local-name($target) = 'equation'
                  or local-name($target) = 'table'
                  or local-name($target) = 'figure'
                  or local-name($target) = 'simplesect'
                  or starts-with(local-name($target),'sect')
                  or starts-with(local-name($target),'refsect')">
      <xsl:attribute name="title">
        <xsl:apply-templates select="$target"
                             mode="object.title.markup.textonly"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates/>
  </a>
</xsl:template>

<xsl:template match="ulink">
  <a>
    <xsl:if test="@id">
      <xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
    </xsl:if>
    <xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
    <xsl:if test="$ulink.target != ''">
      <xsl:attribute name="target">
        <xsl:value-of select="$ulink.target"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="count(child::node())=0">
	<xsl:value-of select="@url"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </a>
</xsl:template>

<xsl:template match="olink">
  <xsl:if test="@id">
    <a name="{@id}"/>
  </xsl:if>
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="xref.xreflabel">
  <!-- called to process an xreflabel...you might use this to make  -->
  <!-- xreflabels come out in the right font for different targets, -->
  <!-- for example. -->
  <xsl:param name="target" select="."/>
  <xsl:value-of select="$target/@xreflabel"/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="title" mode="xref">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="command" mode="xref">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="function" mode="xref">
  <xsl:call-template name="inline.monoseq"/>
</xsl:template>

</xsl:stylesheet>
