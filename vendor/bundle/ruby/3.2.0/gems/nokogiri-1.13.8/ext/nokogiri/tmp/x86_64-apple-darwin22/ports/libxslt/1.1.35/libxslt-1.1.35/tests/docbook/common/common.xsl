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

     This file contains general templates common to both the HTML and FO
     versions of the DocBook stylesheets.
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
<title>Common Template Reference</title>

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
<!-- Establish strip/preserve whitespace rules -->

<xsl:preserve-space elements="*"/>

<xsl:strip-space elements="
abstract affiliation anchor answer appendix area areaset areaspec
artheader article audiodata audioobject author authorblurb authorgroup
beginpage bibliodiv biblioentry bibliography biblioset blockquote book
bookbiblio bookinfo callout calloutlist caption caution chapter
citerefentry cmdsynopsis co collab colophon colspec confgroup
copyright dedication docinfo editor entry entrytbl epigraph equation
example figure footnote footnoteref formalpara funcprototype
funcsynopsis glossary glossdef glossdiv glossentry glosslist graphicco
group highlights imagedata imageobject imageobjectco important index
indexdiv indexentry indexterm informalequation informalexample
informalfigure informaltable inlineequation inlinemediaobject
itemizedlist itermset keycombo keywordset legalnotice listitem lot
mediaobject mediaobjectco menuchoice msg msgentry msgexplan msginfo
msgmain msgrel msgset msgsub msgtext note objectinfo
orderedlist othercredit part partintro preface printhistory procedure
programlistingco publisher qandadiv qandaentry qandaset question
refentry reference refmeta refnamediv refsect1 refsect1info refsect2
refsect2info refsect3 refsect3info refsynopsisdiv refsynopsisdivinfo
revhistory revision row sbr screenco screenshot sect1 sect1info sect2
sect2info sect3 sect3info sect4 sect4info sect5 sect5info section
sectioninfo seglistitem segmentedlist seriesinfo set setindex setinfo
shortcut sidebar simplelist simplesect spanspec step subject
subjectset substeps synopfragment table tbody textobject tfoot tgroup
thead tip toc tocchap toclevel1 toclevel2 toclevel3 toclevel4
toclevel5 tocpart varargs variablelist varlistentry videodata
videoobject void warning subjectset

classsynopsis
constructorsynopsis
destructorsynopsis
fieldsynopsis
methodparam
methodsynopsis
ooclass
ooexception
oointerface
simplemsgentry
"/>

<!-- ====================================================================== -->

<doc:template name="is.component" xmlns="">
<refpurpose>Tests if a given node is a component-level element</refpurpose>

<refdescription>
<para>This template returns '1' if the specified node is a component
(Chapter, Appendix, etc.), and '0' otherwise.</para>
</refdescription>

<refparameter>
<variablelist>
<varlistentry><term>node</term>
<listitem>
<para>The node which is to be tested.</para>
</listitem>
</varlistentry>
</variablelist>
</refparameter>

<refreturn>
<para>This template returns '1' if the specified node is a component
(Chapter, Appendix, etc.), and '0' otherwise.</para>
</refreturn>
</doc:template>

<xsl:template name="is.component">
  <xsl:param name="node" select="."/>
  <xsl:choose>
    <xsl:when test="local-name($node) = 'appendix'
                    or local-name($node) = 'article'
                    or local-name($node) = 'chapter'
                    or local-name($node) = 'preface'
                    or local-name($node) = 'bibliography'
                    or local-name($node) = 'glossary'
                    or local-name($node) = 'index'">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ====================================================================== -->

<doc:template name="is.section" xmlns="">
<refpurpose>Tests if a given node is a section-level element</refpurpose>

<refdescription>
<para>This template returns '1' if the specified node is a section
(Section, Sect1, Sect2, etc.), and '0' otherwise.</para>
</refdescription>

<refparameter>
<variablelist>
<varlistentry><term>node</term>
<listitem>
<para>The node which is to be tested.</para>
</listitem>
</varlistentry>
</variablelist>
</refparameter>

<refreturn>
<para>This template returns '1' if the specified node is a section
(Section, Sect1, Sect2, etc.), and '0' otherwise.</para>
</refreturn>
</doc:template>

<xsl:template name="is.section">
  <xsl:param name="node" select="."/>
  <xsl:choose>
    <xsl:when test="local-name($node) = 'section'
                    or local-name($node) = 'sect1'
                    or local-name($node) = 'sect2'
                    or local-name($node) = 'sect3'
                    or local-name($node) = 'sect4'
                    or local-name($node) = 'sect5'
                    or local-name($node) = 'refsect1'
                    or local-name($node) = 'refsect2'
                    or local-name($node) = 'refsect3'
                    or local-name($node) = 'simplesect'">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ====================================================================== -->

<doc:template name="section.level" xmlns="">
<refpurpose>Returns the hierarchical level of a section.</refpurpose>

<refdescription>
<para>This template calculates the hierarchical level of a section.
Hierarchically, components are <quote>top level</quote>, so a
<sgmltag>sect1</sgmltag> is at level 2, <sgmltag>sect3</sgmltag> is
at level 3, etc.</para>

<para>Recursive sections are calculated down to the sixth level.</para>
</refdescription>

<refparameter>
<variablelist>
<varlistentry><term>node</term>
<listitem>
<para>The section node for which the level should be calculated.
Defaults to the context node.</para>
</listitem>
</varlistentry>
</variablelist>
</refparameter>

<refreturn>
<para>The section level, <quote>2</quote>, <quote>3</quote>, etc.
</para>
</refreturn>
</doc:template>

<xsl:template name="section.level">
  <xsl:param name="node" select="."/>
  <xsl:choose>
    <xsl:when test="name($node)='sect1'">2</xsl:when>
    <xsl:when test="name($node)='sect2'">3</xsl:when>
    <xsl:when test="name($node)='sect3'">4</xsl:when>
    <xsl:when test="name($node)='sect4'">5</xsl:when>
    <xsl:when test="name($node)='sect5'">6</xsl:when>
    <xsl:when test="name($node)='section'">
      <xsl:choose>
        <xsl:when test="$node/../../../../../section">6</xsl:when>
        <xsl:when test="$node/../../../../section">5</xsl:when>
        <xsl:when test="$node/../../../section">4</xsl:when>
        <xsl:when test="$node/../../section">3</xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="name($node)='refsect1'">2</xsl:when>
    <xsl:when test="name($node)='refsect2'">3</xsl:when>
    <xsl:when test="name($node)='refsect3'">4</xsl:when>
    <xsl:when test="name($node)='simplesect'">
      <xsl:choose>
        <xsl:when test="$node/../../sect1">3</xsl:when>
        <xsl:when test="$node/../../sect2">4</xsl:when>
        <xsl:when test="$node/../../sect3">5</xsl:when>
        <xsl:when test="$node/../../sect4">6</xsl:when>
        <xsl:when test="$node/../../sect5">6</xsl:when>
        <xsl:when test="$node/../../section">
          <xsl:choose>
            <xsl:when test="$node/../../../../../section">6</xsl:when>
            <xsl:when test="$node/../../../../section">5</xsl:when>
            <xsl:when test="$node/../../../section">4</xsl:when>
            <xsl:otherwise>3</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>2</xsl:otherwise>
  </xsl:choose>
</xsl:template><!-- section.level -->

<doc:template name="qanda.section.level" xmlns="">
<refpurpose>Returns the hierarchical level of a QandASet.</refpurpose>

<refdescription>
<para>This template calculates the hierarchical level of a QandASet.
</para>
</refdescription>

<refreturn>
<para>The level, <quote>1</quote>, <quote>2</quote>, etc.
</para>
</refreturn>
</doc:template>

<xsl:template name="qanda.section.level">
  <xsl:variable name="section"
                select="(ancestor::section
                         |ancestor::simplesect
                         |ancestor::sect5
                         |ancestor::sect4
                         |ancestor::sect3
                         |ancestor::sect2
                         |ancestor::sect1
                         |ancestor::refsect3
                         |ancestor::refsect2
                         |ancestor::refsect1)[last()]"/>
  <xsl:choose>
    <xsl:when test="count($section) = '0'">1</xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="section.level">
        <xsl:with-param name="node" select="$section"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="qandadiv.section.level">
  <xsl:variable name="section.level">
    <xsl:call-template name="qanda.section.level"/>
  </xsl:variable>
  <xsl:variable name="anc.divs" select="ancestor::qandadiv"/>

  <xsl:value-of select="count($anc.divs) + number($section.level)"/>
</xsl:template>

<xsl:template name="question.answer.label">
  <xsl:variable name="deflabel">
    <xsl:choose>
      <xsl:when test="ancestor-or-self::*[@defaultlabel]">
        <xsl:value-of select="(ancestor-or-self::*[@defaultlabel])[last()]
                              /@defaultlabel"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="qanda.defaultlabel"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="label" select="@label"/>

<!--
	 (hnr      (hierarchical-number-recursive (normalize "qandadiv")
						  node))

	 (parsect  (ancestor-member node (section-element-list)))

	 (defnum   (if (and %qanda-inherit-numeration% 
			    %section-autolabel%)
		       (if (node-list-empty? parsect)
			   (section-autolabel-prefix node)
			   (section-autolabel parsect))
		       ""))

	 (hnumber  (let loop ((numlist hnr) (number defnum) 
			      (sep (if (equal? defnum "") "" ".")))
		     (if (null? numlist)
			 number
			 (loop (cdr numlist) 
			       (string-append number
					      sep
					      (number->string (car numlist)))
			       "."))))
	 (cnumber  (child-number (parent node)))
	 (number   (string-append hnumber 
				  (if (equal? hnumber "")
				      ""
				      ".")
				  (number->string cnumber))))
-->

  <xsl:choose>
    <xsl:when test="$deflabel = 'qanda'">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key">
          <xsl:choose>
            <xsl:when test="local-name(.) = 'question'">Question</xsl:when>
            <xsl:when test="local-name(.) = 'question'">Answer</xsl:when>
            <xsl:when test="local-name(.) = 'qandadiv'">QandADiv</xsl:when>
            <xsl:otherwise>QandASet</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$deflabel = 'label'">
      <xsl:value-of select="$label"/>
    </xsl:when>
    <xsl:when test="$deflabel = 'number'
                    and local-name(.) = 'question'">
      <xsl:apply-templates select="ancestor::qandaset[1]"
                           mode="number"/>
      <xsl:choose>
        <xsl:when test="ancestor::qandadiv">
          <xsl:apply-templates select="ancestor::qandadiv[1]"
                               mode="number"/>
          <xsl:apply-templates select="ancestor::qandaentry"
                               mode="number"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="ancestor::qandaentry"
                               mode="number"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <!-- nothing -->
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="qandaset" mode="number">
  <!-- FIXME: -->
</xsl:template>

<xsl:template match="qandadiv" mode="number">
  <xsl:number level="multiple" from="qandaset" format="1."/>
</xsl:template>

<xsl:template match="qandaentry" mode="number">
  <xsl:choose>
    <xsl:when test="ancestor::qandadiv">
      <xsl:number level="single" from="qandadiv" format="1."/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:number level="single" from="qandaset" format="1."/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ====================================================================== -->

<xsl:template name="object.id">
  <xsl:param name="object" select="."/>
  <xsl:choose>
    <xsl:when test="$object/@id">
      <xsl:value-of select="$object/@id"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="generate-id($object)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="person.name">
  <!-- Return a formatted string representation of the contents of
       the specified node (by default, the current element).
       Handles Honorific, FirstName, SurName, and Lineage.
       If %author-othername-in-middle% is #t, also OtherName
       Handles *only* the first of each.
       Format is "Honorific. FirstName [OtherName] SurName, Lineage"
  -->
  <xsl:param name="node" select="."/>

  <xsl:choose>
    <!-- handle corpauthor as a special case...-->
    <xsl:when test="name($node)='corpauthor'">
      <xsl:apply-templates select="$node"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="h_nl" select="$node//honorific[1]"/>
      <xsl:variable name="f_nl" select="$node//firstname[1]"/>
      <xsl:variable name="o_nl" select="$node//othername[1]"/>
      <xsl:variable name="s_nl" select="$node//surname[1]"/>
      <xsl:variable name="l_nl" select="$node//lineage[1]"/>

      <xsl:variable name="has_h" select="$h_nl"/>
      <xsl:variable name="has_f" select="$f_nl"/>
      <xsl:variable name="has_o"
                    select="$o_nl and ($author.othername.in.middle != 0)"/>
      <xsl:variable name="has_s" select="$s_nl"/>
      <xsl:variable name="has_l" select="$l_nl"/>

      <xsl:if test="$has_h">
        <xsl:value-of select="$h_nl"/>.
      </xsl:if>

      <xsl:if test="$has_f">
        <xsl:if test="$has_h"><xsl:text> </xsl:text></xsl:if>
        <xsl:value-of select="$f_nl"/>
      </xsl:if>

      <xsl:if test="$has_o">
        <xsl:if test="$has_h or $has_f"><xsl:text> </xsl:text></xsl:if>
        <xsl:value-of select="$o_nl"/>
      </xsl:if>

      <xsl:if test="$has_s">
        <xsl:if test="$has_h or $has_f or $has_o">
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="$s_nl"/>
      </xsl:if>

      <xsl:if test="$has_l">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="$l_nl"/>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template> <!-- person.name -->

<xsl:template name="person.name.list">
  <!-- Return a formatted string representation of the contents of
       the current element. The current element must contain one or
       more AUTHORs, CORPAUTHORs, OTHERCREDITs, and/or EDITORs.

       John Doe
     or
       John Doe and Jane Doe
     or
       John Doe, Jane Doe, and A. Nonymous
  -->
  <xsl:param name="person.list"
             select="./author|./corpauthor|./othercredit|./editor"/>
  <xsl:param name="person.count" select="count($person.list)"/>
  <xsl:param name="count" select="1"/>

  <xsl:choose>
    <xsl:when test="$count &gt; $person.count"></xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="person.name">
        <xsl:with-param name="node" select="$person.list[position()=$count]"/>
      </xsl:call-template>

      <xsl:choose>
        <xsl:when test="$person.count = 2 and $count = 1">
          <xsl:call-template name="gentext.template">
            <xsl:with-param name="context" select="'authorgroup'"/>
            <xsl:with-param name="name" select="'sep2'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$person.count &gt; 2 and $count+1 = $person.count">
          <xsl:call-template name="gentext.template">
            <xsl:with-param name="context" select="'authorgroup'"/>
            <xsl:with-param name="name" select="'seplast'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$count &lt; $person.count">
          <xsl:call-template name="gentext.template">
            <xsl:with-param name="context" select="'authorgroup'"/>
            <xsl:with-param name="name" select="'sep'"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>

      <xsl:call-template name="person.name.list">
        <xsl:with-param name="person.list" select="$person.list"/>
        <xsl:with-param name="person.count" select="$person.count"/>
        <xsl:with-param name="count" select="$count+1"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template><!-- person.name.list -->

<!-- === synopsis ======================================================= -->
<!-- The following definitions match those given in the reference
     documentation for DocBook V3.0
-->

<xsl:variable name="arg.choice.opt.open.str">[</xsl:variable>
<xsl:variable name="arg.choice.opt.close.str">]</xsl:variable>
<xsl:variable name="arg.choice.req.open.str">{</xsl:variable>
<xsl:variable name="arg.choice.req.close.str">}</xsl:variable>
<xsl:variable name="arg.choice.plain.open.str"><xsl:text> </xsl:text></xsl:variable>
<xsl:variable name="arg.choice.plain.close.str"><xsl:text> </xsl:text></xsl:variable>
<xsl:variable name="arg.choice.def.open.str">[</xsl:variable>
<xsl:variable name="arg.choice.def.close.str">]</xsl:variable>
<xsl:variable name="arg.rep.repeat.str">...</xsl:variable>
<xsl:variable name="arg.rep.norepeat.str"></xsl:variable>
<xsl:variable name="arg.rep.def.str"></xsl:variable>
<xsl:variable name="arg.or.sep"> | </xsl:variable>
<xsl:variable name="cmdsynopsis.hanging.indent">4pi</xsl:variable>

<!-- ====================================================================== -->

<!--
<xsl:template name="xref.g.subst">
  <xsl:param name="string"></xsl:param>
  <xsl:param name="target" select="."/>
  <xsl:variable name="subst">%g</xsl:variable>

  <xsl:choose>
    <xsl:when test="contains($string, $subst)">
      <xsl:value-of select="substring-before($string, $subst)"/>
      <xsl:call-template name="gentext.element.name">
        <xsl:with-param name="element.name" select="name($target)"/>
      </xsl:call-template>
      <xsl:call-template name="xref.g.subst">
        <xsl:with-param name="string"
                        select="substring-after($string, $subst)"/>
        <xsl:with-param name="target" select="$target"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$string"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="xref.t.subst">
  <xsl:param name="string"></xsl:param>
  <xsl:param name="target" select="."/>
  <xsl:variable name="subst">%t</xsl:variable>

  <xsl:choose>
    <xsl:when test="contains($string, $subst)">
      <xsl:call-template name="xref.g.subst">
        <xsl:with-param name="string"
                        select="substring-before($string, $subst)"/>
        <xsl:with-param name="target" select="$target"/>
      </xsl:call-template>
      <xsl:call-template name="title.xref">
        <xsl:with-param name="target" select="$target"/>
      </xsl:call-template>
      <xsl:call-template name="xref.t.subst">
        <xsl:with-param name="string"
                        select="substring-after($string, $subst)"/>
        <xsl:with-param name="target" select="$target"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="xref.g.subst">
        <xsl:with-param name="string" select="$string"/>
        <xsl:with-param name="target" select="$target"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="xref.n.subst">
  <xsl:param name="string"></xsl:param>
  <xsl:param name="target" select="."/>
  <xsl:variable name="subst">%n</xsl:variable>

  <xsl:choose>
    <xsl:when test="contains($string, $subst)">
      <xsl:call-template name="xref.t.subst">
        <xsl:with-param name="string"
                        select="substring-before($string, $subst)"/>
        <xsl:with-param name="target" select="$target"/>
      </xsl:call-template>
      <xsl:call-template name="number.xref">
        <xsl:with-param name="target" select="$target"/>
      </xsl:call-template>
      <xsl:call-template name="xref.t.subst">
        <xsl:with-param name="string"
                        select="substring-after($string, $subst)"/>
        <xsl:with-param name="target" select="$target"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="xref.t.subst">
        <xsl:with-param name="string" select="$string"/>
        <xsl:with-param name="target" select="$target"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="subst.xref.text">
  <xsl:param name="xref.text"></xsl:param>
  <xsl:param name="target" select="."/>

  <xsl:call-template name="xref.n.subst">
    <xsl:with-param name="string" select="$xref.text"/>
    <xsl:with-param name="target" select="$target"/>
  </xsl:call-template>
</xsl:template>
-->

<!-- ====================================================================== -->

<xsl:template name="filename-basename">
  <!-- We assume all filenames are really URIs and use "/" -->
  <xsl:param name="filename"></xsl:param>
  <xsl:param name="recurse" select="false()"/>

  <xsl:choose>
    <xsl:when test="substring-after($filename, '/') != ''">
      <xsl:call-template name="filename-basename">
        <xsl:with-param name="filename"
                        select="substring-after($filename, '/')"/>
        <xsl:with-param name="recurse" select="true()"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$filename"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="filename-extension">
  <xsl:param name="filename"></xsl:param>
  <xsl:param name="recurse" select="false()"/>

  <!-- Make sure we only look at the base name... -->
  <xsl:variable name="basefn">
    <xsl:choose>
      <xsl:when test="$recurse">
        <xsl:value-of select="$filename"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="filename-basename">
          <xsl:with-param name="filename" select="$filename"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="substring-after($basefn, '.') != ''">
      <xsl:call-template name="filename-extension">
        <xsl:with-param name="filename"
                        select="substring-after($basefn, '.')"/>
        <xsl:with-param name="recurse" select="true()"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$recurse">
      <xsl:value-of select="$basefn"/>
    </xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ====================================================================== -->

<doc:template name="select.mediaobject" xmlns="">
<refpurpose>Selects an appropriate media object from a list</refpurpose>

<refdescription>
<para>This template examines a list of media objects (usually the
children of a mediaobject or inlinemediaobject) and processes
the "right" object.</para>

<para>This template relies on a template named "is.acceptable.mediaobject"
to determine if a given object is an acceptable graphic. The semantics
of media objects is that the first acceptable graphic should be used.
</para>

<para>If no acceptable object is located, nothing happens.</para>
</refdescription>

<refparameter>
<variablelist>
<varlistentry><term>olist</term>
<listitem>
<para>The node list of potential objects to examine.</para>
</listitem>
</varlistentry>
</variablelist>
</refparameter>

<refreturn>
<para>Calls &lt;xsl:apply-templates&gt; on the selected object.</para>
</refreturn>
</doc:template>

<xsl:template name="select.mediaobject">
  <xsl:param name="olist"
             select="imageobject|imageobjectco
                     |videoobject|audioobject|textobject"/>
  <xsl:param name="count">1</xsl:param>

  <xsl:if test="$count &lt;= count($olist)">
    <xsl:variable name="object" select="$olist[position()=$count]"/>

    <xsl:variable name="useobject">
      <xsl:choose>
	<!-- The phrase is never used -->
        <xsl:when test="name($object)='textobject' and $object/phrase">
          <xsl:text>0</xsl:text>
        </xsl:when>
	<!-- The first textobject is a reasonable fallback -->
        <xsl:when test="name($object)='textobject'">
          <xsl:text>1</xsl:text>
        </xsl:when>
	<!-- If there's only one object, use it -->
	<xsl:when test="$count = 1 and count($olist) = 1">
	  <xsl:text>1</xsl:text>
	</xsl:when>
	<!-- Otherwise, see if this one is a useable graphic -->
        <xsl:otherwise>
          <xsl:choose>
            <!-- peek inside imageobjectco to simplify the test -->
            <xsl:when test="local-name($object) = 'imageobjectco'">
              <xsl:call-template name="is.acceptable.mediaobject">
                <xsl:with-param name="object" select="$object/imageobject"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="is.acceptable.mediaobject">
                <xsl:with-param name="object" select="$object"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$useobject='1'">
        <xsl:apply-templates select="$object"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="select.mediaobject">
          <xsl:with-param name="olist" select="$olist"/>
          <xsl:with-param name="count" select="$count + 1"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
</xsl:template>

<doc:template name="is.acceptable.mediaobject" xmlns="">
<refpurpose>Returns '1' if the specified media object is recognized.</refpurpose>

<refdescription>
<para>This template examines a media object and returns '1' if the
object is recognized as a graphic.</para>
</refdescription>

<refparameter>
<variablelist>
<varlistentry><term>object</term>
<listitem>
<para>The media object to consider.</para>
</listitem>
</varlistentry>
</variablelist>
</refparameter>

<refreturn>
<para>0 or 1</para>
</refreturn>
</doc:template>

<xsl:template name="is.acceptable.mediaobject">
  <xsl:param name="object"></xsl:param>

  <xsl:variable name="filename">
    <xsl:call-template name="mediaobject.filename">
      <xsl:with-param name="object" select="$object"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="ext">
    <xsl:call-template name="filename-extension">
      <xsl:with-param name="filename" select="$filename"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- there will only be one -->
  <xsl:variable name="data" select="$object/videodata
                                    |$object/imagedata
                                    |$object/audiodata"/>

  <xsl:variable name="format" select="$data/@format"/>

  <xsl:variable name="graphic.format">
    <xsl:if test="$format">
      <xsl:call-template name="is.graphic.format">
        <xsl:with-param name="format" select="$format"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="graphic.ext">
    <xsl:if test="$ext">
      <xsl:call-template name="is.graphic.extension">
        <xsl:with-param name="ext" select="$ext"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$graphic.format = '1'">1</xsl:when>
    <xsl:when test="$graphic.ext = '1'">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="mediaobject.filename">
  <xsl:param name="object"></xsl:param>

  <xsl:variable name="data" select="$object/videodata
                                    |$object/imagedata
                                    |$object/audiodata"/>

  <xsl:variable name="filename">
    <xsl:choose>
      <xsl:when test="$data[@fileref]">
        <xsl:value-of select="$data/@fileref"/>
      </xsl:when>
      <xsl:when test="$data[@entityref]">
        <xsl:value-of select="unparsed-entity-uri($data/@entityref)"/>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="has.ext" select="contains($filename, '.') != ''"/>

  <xsl:variable name="ext">
    <xsl:choose>
      <xsl:when test="contains($filename, '.')">
        <xsl:call-template name="filename-extension">
          <xsl:with-param name="filename" select="$filename"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$graphic.default.extension"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="graphic.ext">
    <xsl:call-template name="is.graphic.extension">
      <xsl:with-param name="ext" select="$ext"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="not($has.ext)">
      <xsl:choose>
        <xsl:when test="$ext != ''">
          <xsl:value-of select="$filename"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="$ext"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$filename"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="not($graphic.ext)">
      <xsl:choose>
        <xsl:when test="$graphic.default.extension != ''">
          <xsl:value-of select="$filename"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="$graphic.default.extension"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$filename"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$filename"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ====================================================================== -->

<doc:template name="check.id.unique" xmlns="">
<refpurpose>Warn users about references to non-unique IDs</refpurpose>
<refdescription>
<para>If passed an ID in <varname>linkend</varname>,
<function>check.id.unique</function> prints
a warning message to the user if either the ID does not exist or
the ID is not unique.</para>
</refdescription>
</doc:template>

<xsl:template name="check.id.unique">
  <xsl:param name="linkend"></xsl:param>
  <xsl:if test="$linkend != ''">
    <xsl:variable name="targets" select="id($linkend)"/>
    <xsl:variable name="target" select="$targets[1]"/>

    <xsl:if test="count($targets)=0">
      <xsl:message>
	<xsl:text>Error: no ID for constraint linkend: </xsl:text>
	<xsl:value-of select="$linkend"/>
	<xsl:text>.</xsl:text>
      </xsl:message>
      <!--
      <xsl:message>
	<xsl:text>If the ID exists in your document, did your </xsl:text>
        <xsl:text>XSLT Processor load the DTD?</xsl:text>
      </xsl:message>
      -->
    </xsl:if>

    <xsl:if test="count($targets)>1">
      <xsl:message>
	<xsl:text>Warning: multiple "IDs" for constraint linkend: </xsl:text>
	<xsl:value-of select="$linkend"/>
	<xsl:text>.</xsl:text>
      </xsl:message>
    </xsl:if>
  </xsl:if>
</xsl:template>

<doc:template name="check.idref.targets" xmlns="">
<refpurpose>Warn users about incorrectly typed references</refpurpose>
<refdescription>
<para>If passed an ID in <varname>linkend</varname>,
<function>check.idref.targets</function> makes sure that the element
pointed to by the link is one of the elements listed in
<varname>element-list</varname> and warns the user otherwise.</para>
</refdescription>
</doc:template>

<xsl:template name="check.idref.targets">
  <xsl:param name="linkend"></xsl:param>
  <xsl:param name="element-list"></xsl:param>
  <xsl:if test="$linkend != ''">
    <xsl:variable name="targets" select="id($linkend)"/>
    <xsl:variable name="target" select="$targets[1]"/>

    <xsl:if test="count($target) &gt; 0">
      <xsl:if test="not(contains(concat(' ', $element-list, ' '), name($target)))">
	<xsl:message>
	  <xsl:text>Error: linkend (</xsl:text>
	  <xsl:value-of select="$linkend"/>
	  <xsl:text>) points to "</xsl:text>
	  <xsl:value-of select="name($target)"/>
	  <xsl:text>" not (one of): </xsl:text>
	  <xsl:value-of select="$element-list"/>
	</xsl:message>
      </xsl:if>
    </xsl:if>
  </xsl:if>
</xsl:template>

<!-- ====================================================================== -->

</xsl:stylesheet>

