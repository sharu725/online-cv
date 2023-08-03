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

<xsl:template match="anchor">
  <!-- FIXME: should this output an empty element with an ID? -->
  <!-- what element!? -->
  <!-- suppress -->
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="xref">
  <xsl:variable name="targets" select="id(@linkend)"/>
  <xsl:variable name="target" select="$targets[1]"/>
  <xsl:variable name="refelem" select="name($target)"/>

  <xsl:call-template name="check.id.unique">
    <xsl:with-param name="linkend" select="@linkend"/>
  </xsl:call-template>

  <xsl:choose>
    <xsl:when test="$refelem=''">
      <xsl:message>
	<xsl:text>XRef to nonexistent id: </xsl:text>
	<xsl:value-of select="@linkend"/>
      </xsl:message>
      <xsl:text>???</xsl:text>
    </xsl:when>

    <xsl:when test="$target/@xreflabel">
      <fo:basic-link internal-destination="{@linkend}"
                     xsl:use-attribute-sets="xref.properties">
	<xsl:call-template name="xref.xreflabel">
	  <xsl:with-param name="target" select="$target"/>
	</xsl:call-template>
      </fo:basic-link>
    </xsl:when>

    <xsl:otherwise>
      <fo:basic-link internal-destination="{@linkend}"
                     xsl:use-attribute-sets="xref.properties">
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
            <xsl:apply-templates select="$target" mode="xref-to"/>
          </xsl:otherwise>
        </xsl:choose>
      </fo:basic-link>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--- ==================================================================== -->

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

<xsl:template match="link">
  <xsl:variable name="targets" select="id(@linkend)"/>
  <xsl:variable name="target" select="$targets[1]"/>

  <xsl:call-template name="check.id.unique">
    <xsl:with-param name="linkend" select="@linkend"/>
  </xsl:call-template>

  <fo:basic-link internal-destination="{@linkend}"
                 xsl:use-attribute-sets="xref.properties">
    <xsl:apply-templates/>
  </fo:basic-link>
</xsl:template>

<xsl:template match="ulink">
  <fo:basic-link external-destination="{@url}"
                 xsl:use-attribute-sets="xref.properties">
    <xsl:choose>
      <xsl:when test="count(child::node())=0">
	<xsl:value-of select="@url"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </fo:basic-link>
  <xsl:if test="count(child::node()) != 0">
    <fo:inline hyphenate="false">
      <xsl:text> [</xsl:text>
      <xsl:value-of select="@url"/>
      <xsl:text>]</xsl:text>
    </fo:inline>
  </xsl:if>
</xsl:template>

<xsl:template match="olink">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="title.xref">
  <xsl:param name="target" select="."/>
  <xsl:choose>
    <xsl:when test="local-name($target) = 'figure'
                    or local-name($target) = 'example'
                    or local-name($target) = 'equation'
                    or local-name($target) = 'table'
                    or local-name($target) = 'dedication'
                    or local-name($target) = 'preface'
                    or local-name($target) = 'bibliography'
                    or local-name($target) = 'glossary'
                    or local-name($target) = 'index'
                    or local-name($target) = 'setindex'
                    or local-name($target) = 'colophon'">
      <xsl:call-template name="gentext.startquote"/>
      <xsl:apply-templates select="$target" mode="title.markup"/>
      <xsl:call-template name="gentext.endquote"/>
    </xsl:when>
    <xsl:otherwise>
      <fo:inline font-style="italic">
        <xsl:apply-templates select="$target" mode="title.markup"/>
      </fo:inline>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="number.xref">
  <xsl:param name="target" select="."/>
  <xsl:apply-templates select="$target" mode="label.markup"/>
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

<xsl:template name="insert.page.citation">
  <xsl:param name="id" select="'???'"/>
  <xsl:if test="$insert.xref.page.number">
    <xsl:text> </xsl:text>
    <fo:inline keep-together.within-line="always">
      <xsl:text>[</xsl:text>
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'page.citation'"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <fo:page-number-citation ref-id="{$id}"/>
      <xsl:text>]</xsl:text>
    </fo:inline>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
