<?xml version="1.0"?>

<!-- Version: $Id$ -->

<!-- Stylesheet for @diff markup in XMLspec -->
<!-- Author: Norman Walsh (Norman.Walsh@East.Sun.COM) -->
<!-- Date Created: 2000.07.21 -->

<!-- This stylesheet is copyright (c) 2000 by its authors.  Free
     distribution and modification is permitted, including adding to
     the list of authors and copyright holders, as long as this
     copyright notice is maintained. -->

<!-- This stylesheet attempts to implement the XML Specification V2.1
     DTD.  Documents conforming to earlier DTDs may not be correctly
     transformed.

     This stylesheet supports the use of change-markup with the @diff
     attribute. If you use @diff, you should always use this stylesheet.
     If you want to turn off the highlighting of differences, use this
     stylesheet, but set show.diff.markup to 0.

     Using the original xmlspec stylesheet with @diff markup will cause
     @diff=del text to be presented.
-->

<!-- ChangeLog:
     25 Sep 2000: (Norman.Walsh@East.Sun.COM)
       - Use inline diff markup (as opposed to block) for name and
         affiliation
       - Handle @diff='del' correctly in bibl and other list-contexts.
     14 Aug 2000: (Norman.Walsh@East.Sun.COM)
       - Support additional.title param
     27 Jul 2000: (Norman.Walsh@East.Sun.COM)
       - Fix HTML markup problem with diff'd authors in authlist
     26 Jul 2000: (Norman.Walsh@East.Sun.COM)
       - Update pointer to latest xmlspec-stylesheet.
     21 Jul 2000: (Norman.Walsh@East.Sun.COM)
       - Initial version
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<xsl:import href="xmlspec.xsl"/>

<xsl:param name="show.diff.markup">0</xsl:param>

<xsl:param name="additional.css">
<xsl:if test="$show.diff.markup = '1'">
<xsl:text>
div.diff-add  { background-color: yellow }
div.diff-del  { text-decoration: line-through }
div.diff-chg  { background-color: lime }
div.diff-off  {  }

span.diff-add { background-color: yellow }
span.diff-del { text-decoration: line-through }
span.diff-chg { background-color: lime }
span.diff-off {  }

td.diff-add   { background-color: yellow }
td.diff-del   { text-decoration: line-through }
td.diff-chg   { background-color: lime }
td.diff-off   {  }
</xsl:text>
</xsl:if>
</xsl:param>

<xsl:param name="additional.title">
  <xsl:if test="$show.diff.markup != '0'">
    <xsl:text>Review Version</xsl:text>
  </xsl:if>
</xsl:param>

<xsl:param name="called.by.diffspec">1</xsl:param>

<!-- ==================================================================== -->

<xsl:template name="diff-markup">
  <xsl:param name="diff">off</xsl:param>
  <xsl:choose>
    <xsl:when test="ancestor::scrap">
      <!-- forget it, we can't add stuff inside tables -->
      <!-- handled in base stylesheet -->
      <xsl:apply-imports/>
    </xsl:when>
    <xsl:when test="self::gitem or self::bibl">
      <!-- forget it, we can't add stuff inside dls; handled below -->
      <xsl:apply-imports/>
    </xsl:when>
    <xsl:when test="ancestor-or-self::phrase">
      <span class="diff-{$diff}">
	<xsl:apply-imports/>
      </span>
    </xsl:when>
    <xsl:when test="ancestor::p and not(self::p)">
      <span class="diff-{$diff}">
	<xsl:apply-imports/>
      </span>
    </xsl:when>
    <xsl:when test="ancestor-or-self::affiliation">
      <span class="diff-{$diff}">
	<xsl:apply-imports/>
      </span>
    </xsl:when>
    <xsl:when test="ancestor-or-self::name">
      <span class="diff-{$diff}">
	<xsl:apply-imports/>
      </span>
    </xsl:when>
    <xsl:otherwise>
      <div class="diff-{$diff}">
	<xsl:apply-imports/>
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="*[@diff='chg']">
  <xsl:choose>
    <xsl:when test="$show.diff.markup='1'">
      <xsl:call-template name="diff-markup">
	<xsl:with-param name="diff">chg</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="*[@diff='add']">
  <xsl:choose>
    <xsl:when test="$show.diff.markup='1'">
      <xsl:call-template name="diff-markup">
	<xsl:with-param name="diff">add</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="*[@diff='del']">
  <xsl:choose>
    <xsl:when test="$show.diff.markup='1'">
      <xsl:call-template name="diff-markup">
	<xsl:with-param name="diff">del</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <!-- suppress deleted markup -->
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="*[@diff='off']">
  <xsl:choose>
    <xsl:when test="$show.diff.markup='1'">
      <xsl:call-template name="diff-markup">
	<xsl:with-param name="diff">off</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ================================================================= -->

  <xsl:template match="bibl[@diff]" priority="1">
    <xsl:variable name="dt">
      <xsl:if test="@id">
	<a name="{@id}"/>
      </xsl:if>
      <xsl:choose>
	<xsl:when test="@key">
	  <xsl:value-of select="@key"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="@id"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="dd">
      <xsl:apply-templates/>
      <xsl:if test="@href">
        <xsl:text>  (See </xsl:text>
        <a href="{@href}">
          <xsl:value-of select="@href"/>
        </a>
        <xsl:text>.)</xsl:text>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="@diff and $show.diff.markup = '1'">
	<dt class="label">
	  <span class="diff-{@diff}">
	    <xsl:copy-of select="$dt"/>
	  </span>
	</dt>
	<dd>
	  <div class="diff-{@diff}">
	    <xsl:copy-of select="$dd"/>
	  </div>
	</dd>
      </xsl:when>
      <xsl:when test="@diff='del' and $show.diff.markup='0'">
	<!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
	<dt class="label">
	  <xsl:copy-of select="$dt"/>
	</dt>
	<dd>
	  <xsl:copy-of select="$dd"/>
	</dd>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="gitem/label">
    <xsl:variable name="diffval" select="ancestor-or-self::*/@diff"/>
    <xsl:choose>
      <xsl:when test="$diffval != '' and $show.diff.markup='1'">
	<dt class="label">
	  <span class="diff-{ancestor-or-self::*/@diff}">
	    <xsl:apply-templates/>
	  </span>
	</dt>
      </xsl:when>
      <xsl:when test="$diffval='del' and $show.diff.markup='0'">
	<!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
	<dt class="label">
	  <xsl:apply-templates/>
	</dt>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="gitem/def">
    <xsl:variable name="diffval" select="ancestor-or-self::*/@diff"/>
    <xsl:choose>
      <xsl:when test="$diffval != '' and $show.diff.markup='1'">
	<dd>
	  <div class="diff-{ancestor-or-self::*/@diff}">
	    <xsl:apply-templates/>
	  </div>
	</dd>
      </xsl:when>
      <xsl:when test="$diffval='del' and $show.diff.markup='0'">
	<!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
	<dd>
	  <xsl:apply-templates/>
	</dd>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- authlist: list of authors (editors, really) -->
  <!-- called in enforced order from header's template, in <dl>
       context -->
  <xsl:template match="authlist[@diff]">
    <xsl:choose>
      <xsl:when test="$show.diff.markup='1'">
	<dt>
	  <span class="diff-{ancestor-or-self::*/@diff}">
	    <xsl:text>Editor</xsl:text>
	    <xsl:if test="count(author) > 1">
	      <xsl:text>s</xsl:text>
	    </xsl:if>
	    <xsl:text>:</xsl:text>
	  </span>
	</dt>
      </xsl:when>
      <xsl:when test="@diff='del' and $show.diff.markup='0'">
	<!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
	<dt>
	  <xsl:text>Editor</xsl:text>
	  <xsl:if test="count(author) > 1">
	    <xsl:text>s</xsl:text>
	  </xsl:if>
	  <xsl:text>:</xsl:text>
	</dt>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- author: an editor of a spec -->
  <!-- only appears in authlist -->
  <!-- called in <dl> context -->
  <xsl:template match="author[@diff]" priority="1">
    <xsl:choose>
      <xsl:when test="@diff and $show.diff.markup='1'">
	<dd>
	  <span class="diff-{ancestor-or-self::*/@diff}">
	    <xsl:apply-templates/>
	    <xsl:if test="@role = '2e'">
	      <xsl:text> - Second Edition</xsl:text>
	    </xsl:if>
	  </span>
	</dd>
      </xsl:when>
      <xsl:when test="@diff='del' and $show.diff.markup='0'">
	<!-- suppressed -->
      </xsl:when>
      <xsl:otherwise>
	<dd>
	  <xsl:apply-templates/>
	  <xsl:if test="@role = '2e'">
	    <xsl:text> - Second Edition</xsl:text>
	  </xsl:if>
	</dd>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
