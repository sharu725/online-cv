<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
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
<title>Formatting Object Parameter Reference</title>

<partintro>
<section><title>Introduction</title>

<para>This is technical reference documentation for the DocBook XSL
Stylesheets; it documents (some of) the parameters, templates, and
other elements of the stylesheets.</para>

<para>This reference describes each of the Formatting Object
Stylesheet parameters.  These are the <quote>easily
customizable</quote> parts of the stylesheet.  If you want to specify
an alternate value for one or more of these parameters, you can do so
in a <quote>driver</quote> stylesheet.</para>

<para>For example, if you want to turn on automatic section numbering,
you might create a driver stylesheet like this:</para>

<programlisting><![CDATA[<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

  <xsl:import href="/path/to/fo/docbook.xsl"/>

  <xsl:param name="section.autolabel" select="1"/>

</xsl:stylesheet>]]></programlisting>

<para>Naturally, you have to change the
<sgmltag class='attribute'>href</sgmltag> attribute on
<literal>&lt;xsl:import&gt;</literal>
to point to <filename>docbook.xsl</filename>
on your system.</para>

<para>This is not intended to be <quote>user</quote> documentation.
It is provided for developers writing customization layers for the
stylesheets, and for anyone who's interested in <quote>how it
works</quote>.</para>

<para>Although I am trying to be thorough, this documentation is known
to be incomplete. Don't forget to read the source, too :-)</para>
</section>
</partintro>
</doc:reference>

<xsl:param name="author.othername.in.middle" select="1"/>
<xsl:param name="html.stylesheet">docbook.css</xsl:param>
<xsl:param name="html.stylesheet.type">text/css</xsl:param>
<xsl:param name="refentry.xref.manvolnum" select="1"/>
<xsl:param name="show.comments" select="1"/>
<xsl:param name="funcsynopsis.style">kr</xsl:param>
<xsl:param name="funcsynopsis.decoration" select="1"/>
<xsl:param name="refentry.generate.name" select="1"/>

<xsl:param name="admon.graphics" select="0"/>
<xsl:param name="admon.graphics.path">../images/</xsl:param>

<!-- ==================================================================== -->
<xsl:param name="admon.graphics.extension" select="'.png'" doc:type='string'/>

<doc:param name="admon.graphics.extension" xmlns="">
<refpurpose>Extension for admonition graphics</refpurpose>
<refdescription>
<para>Sets the extension to use on admonition graphics.</para>
</refdescription>
</doc:param>

<xsl:param name="section.autolabel" select="0"/>
<xsl:param name="section.label.includes.component.label" select="0"/>
<xsl:param name="chapter.autolabel" select="1"/>
<xsl:param name="appendix.autolabel" select="1"/>
<xsl:param name="part.autolabel" select="1"/>
<xsl:param name="preface.autolabel" select="0"/>

<xsl:param name="biblioentry.item.separator">. </xsl:param>

<!-- ==================================================================== -->
<xsl:param name="qandadiv.autolabel" select="1"/>

<doc:variable name="qandadiv.autolabel" xmlns="">
<refpurpose>Are divisions in QAndASets enumerated?</refpurpose>
<refdescription>
<para>If true (non-zero), unlabeled qandadivs will be enumerated.
</para>
</refdescription>
</doc:variable>

<!-- ==================================================================== -->
<xsl:param name="qanda.inherit.numeration" select="0"/>

<doc:variable name="qanda.inherit.numeration" xmlns="">
<refpurpose>Does enumeration of QandASet components inherit the numeration of parent elements?</refpurpose>
<refdescription>
<para>If true (non-zero), numbered QandADiv elements and Questions and Answers inherit
the numeration of the ancestors of the QandASet.
</para>
</refdescription>
</doc:variable>

<!-- ==================================================================== -->

<xsl:param name="graphic.default.extension"></xsl:param>

<doc:variable name="graphic.default.extension" xmlns="">
<refpurpose>Default extension for graphic filenames</refpurpose>
<refdescription>
<para>If a <sgmltag>graphic</sgmltag> or <sgmltag>mediaobject</sgmltag>
includes a reference to a filename that does not include an extension,
and the <sgmltag class="attribute">format</sgmltag> attribute is
<emphasis>unspecified</emphasis>, the default extension will be used.
</para>
</refdescription>
</doc:variable>

<!-- ==================================================================== -->
<xsl:attribute-set name="formal.title.properties"
                   use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
</xsl:attribute-set>

<doc:attribute-set name="formal.title.properties" xmlns="">
<refpurpose>Properties of formal object titles</refpurpose>
<refdescription>
<para>This attribute set is used to specify the properties of formal
object titles.
</para>
</refdescription>
</doc:attribute-set>

<!-- ==================================================================== -->
<xsl:attribute-set name="component.title.properties">
  <xsl:attribute name="space-before.optimum">2em</xsl:attribute>
  <xsl:attribute name="space-before.minimum">1.8em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">2.2em</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="font-size">18pt</xsl:attribute>
  <xsl:attribute name="space-after.optimum">1.5em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">1.3em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">1.8em</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
</xsl:attribute-set>

<doc:attribute-set name="component.title.properties" xmlns="">
<refpurpose>Properties of component titles</refpurpose>
<refdescription>
<para>This attribute set is used to specify the properties of component
titles.
</para>
</refdescription>
</doc:attribute-set>

<!-- ==================================================================== -->
<xsl:attribute-set name="admonition.title.properties">
  <xsl:attribute name="font-size">14pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
</xsl:attribute-set>

<doc:attribute-set name="admonition.title.properties" xmlns="">
<refpurpose>Properties of admonition titles</refpurpose>
<refdescription>
<para>This attribute set is used to specify the properties of admonition
titles.
</para>
</refdescription>
</doc:attribute-set>

<!-- ==================================================================== -->
<xsl:attribute-set name="toc.margin.properties">
  <xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">2em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.5em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">2em</xsl:attribute>
</xsl:attribute-set>

<!-- ==================================================================== -->
<xsl:attribute-set name="verbatim.properties">
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
</xsl:attribute-set>

<!-- ==================================================================== -->
<xsl:attribute-set name="monospace.verbatim.properties"
                   use-attribute-sets="verbatim.properties">
  <xsl:attribute name="font-family">
    <xsl:value-of select="$monospace.font.family"/>
  </xsl:attribute>
  <xsl:attribute name="font-size">
    <xsl:value-of select="$body.font.master * 0.9"/>
    <xsl:text>pt</xsl:text>
  </xsl:attribute>
</xsl:attribute-set>

<!-- ==================================================================== -->
<xsl:attribute-set name="xref.properties">
<!--
  <xsl:attribute name="background-color">#F0F0F0</xsl:attribute>
  <xsl:attribute name="padding-start">1pt</xsl:attribute>
  <xsl:attribute name="padding-end">1pt</xsl:attribute>
-->
</xsl:attribute-set>

<doc:attribute-set name="xref.properties" xmlns="">
<refpurpose>Visual properties of hotlinks</refpurpose>
<refdescription>
<para>This attribute set is used to specify properties of xrefs
</para>
</refdescription>
</doc:attribute-set>

<!-- ==================================================================== -->
<xsl:param name="insert.xref.page.number" select="0" doc:type='boolean'/>
<doc:param name="insert.xref.page.number" xmlns="">
<refpurpose>Turns page numbers in xrefs on and off</refpurpose>
<refdescription>
<para>When equal to 1, this parameter triggers generation of page
number citations after xrefs.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:attribute-set name="normal.para.spacing">
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
</xsl:attribute-set>

<doc:attribute-set name="normal.para.spacing" xmlns="">
<refpurpose>Spacing properties of normal paragraphs</refpurpose>
<refdescription>
<para>This attribute set is used to specify the spacing properties
of normal paragraphs.
</para>
</refdescription>
</doc:attribute-set>

<!-- ==================================================================== -->

<xsl:attribute-set name="list.block.spacing">
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
</xsl:attribute-set>

<doc:attribute-set name="list.block.spacing" xmlns="">
<refpurpose>Spacing properties of list blocks</refpurpose>
<refdescription>
<para>This attribute set is used to specify the spacing properties
of list blocks.
</para>
</refdescription>
</doc:attribute-set>

<!-- ==================================================================== -->

<xsl:attribute-set name="list.item.spacing">
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
</xsl:attribute-set>

<doc:attribute-set name="list.item.spacing" xmlns="">
<refpurpose>Spacing properties of list items</refpurpose>
<refdescription>
<para>This attribute set is used to specify the spacing properties
of list items.
</para>
</refdescription>
</doc:attribute-set>

<!-- ==================================================================== -->
<xsl:param name="rootid" select="''"/>

<doc:param name="rootid" xmlns="">
<refpurpose>Specify the root element to format</refpurpose>
<refdescription>
<para>If <parameter>rootid</parameter> is specified, it must be the
value of an ID that occurs in the document being formatted. The entire
document will be loaded and parsed, but formatting will begin at the
element identified, rather than at the root. For example, this allows
you to process only chapter 4 of a book.</para>
<para>Because the entire document is available to the processor, automatic
numbering, cross references, and other dependencies are correctly
resolved.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.graphics" select="'0'"/>

<doc:param name="callout.graphics" xmlns="">
<refpurpose>Use graphics for callouts?</refpurpose>
<refdescription>
<para>If non-zero, callouts are presented with graphics (e.g., reverse-video
circled numbers instead of "(1)", "(2)", etc.).
Default graphics are provided in the distribution.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.unicode" select="1"/>

<doc:param name="callout.unicode" xmlns="">
<refpurpose>First character to use for Unicode callouts</refpurpose>
<refdescription>
<para>If non-zero, callouts are presented with Unicode characters
starting with the character specified. Zero indicates that Unicode
callouts should not be used.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.dingbats" select="'0'"/>

<doc:param name="callout.dingbats" xmlns="">
<refpurpose>Use Zapf Dingbats for callouts?</refpurpose>
<refdescription>
<para>If non-zero, callouts are presented with Zapf Dingbats.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.unicode.start.character" select="10102"
           doc:type='integer'/>

<doc:param name="callout.unicode.start.character" xmlns="">
<refpurpose>Number of the largest callout graphic</refpurpose>
<refdescription>
<para>If <parameter>callout.graphics</parameter>
is non-zero, graphics are used to represent
callout numbers. The value of
<parameter>callout.graphics.number.limit</parameter>
is
the largest number for which a graphic exists. If the callout number
exceeds this limit, the default presentation "(nnn)" will always
be used.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.unicode.number.limit" select="'10'"
           doc:type='integer'/>

<doc:param name="callout.unicode.number.limit" xmlns="">
<refpurpose>Number of the largest callout graphic</refpurpose>
<refdescription>
<para>If <parameter>callout.graphics</parameter>
is non-zero, graphics are used to represent
callout numbers. The value of
<parameter>callout.graphics.number.limit</parameter>
is
the largest number for which a graphic exists. If the callout number
exceeds this limit, the default presentation "(nnn)" will always
be used.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.graphics.extension" select="'.png'"/>

<doc:param name="callout.graphics.extension" xmlns="">
<refpurpose>Extension for callout graphics</refpurpose>
<refdescription>
<para>Sets the extension to use on callout graphics.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.graphics.path" select="'../images/callouts/'"/>

<doc:param name="callout.graphics.path" xmlns="">
<refpurpose>Path to callout graphics</refpurpose>
<refdescription>
<para>Sets the path, probably relative to the directory where the HTML
files are created, to the callout graphics.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.graphics.number.limit" select="'10'"/>

<doc:param name="callout.graphics.number.limit" xmlns="">
<refpurpose>Number of the largest callout graphic</refpurpose>
<refdescription>
<para>If <parameter>callout.graphics</parameter>
is non-zero, graphics are used to represent
callout numbers. The value of
<parameter>callout.graphics.number.limit</parameter>
is
the largest number for which a graphic exists. If the callout number
exceeds this limit, the default presentation "(nnn)" will always
be used.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="use.extensions" select="'0'"/>

<doc:param name="use.extensions" xmlns="">
<refpurpose>Enable extensions</refpurpose>
<refdescription>
<para>If non-zero, extensions may be used. Each extension is
further controlled by its own parameter. But if
<parameter>use.extensions</parameter> is zero, no extensions will
be used.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="textinsert.extension" select="'1'"/>

<doc:param name="textinsert.extension" xmlns="">
<refpurpose>Enable the textinsert extension element</refpurpose>
<refdescription>
<para>The textinsert extension element inserts the contents of a
a file into the result tree (as text).
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="linenumbering.extension" select="'1'"/>

<doc:param name="linenumbering.extension" xmlns="">
<refpurpose>Enable the line numbering extension</refpurpose>
<refdescription>
<para>If true, verbatim environments (elements that have the
format='linespecific' notation attribute: address, literallayout,
programlisting, screen, synopsis) that specify line numbering will
have, surprise, line numbers.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="linenumbering.everyNth" select="'5'"/>

<doc:param name="linenumbering.everyNth" xmlns="">
<refpurpose>Indicate which lines should be numbered</refpurpose>
<refdescription>
<para>If line numbering is enabled, everyNth line will be numbered.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="linenumbering.width" select="'3'"/>

<doc:param name="linenumbering.width" xmlns="">
<refpurpose>Indicates the width of line numbers</refpurpose>
<refdescription>
<para>If line numbering is enabled, line numbers will appear right
justified in a field "width" characters wide.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="linenumbering.separator" select="' '"/>

<doc:param name="linenumbering.separator" xmlns="">
<refpurpose>Specify a separator between line numbers and lines</refpurpose>
<refdescription>
<para>The separator is inserted between line numbers and lines in
the verbatim environment.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callouts.extension" select="'1'"/>

<doc:param name="callouts.extension" xmlns="">
<refpurpose>Enable the callout extension</refpurpose>
<refdescription>
<para>The callouts extension processes <sgmltag>areaset</sgmltag>
elements in <sgmltag>ProgramListingCO</sgmltag> and other text-based
callout elements.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.defaultcolumn" select="'60'"/>

<doc:param name="callout.defaultcolumn" xmlns="">
<refpurpose>Indicates what column callouts appear in by default</refpurpose>
<refdescription>
<para>If a callout does not identify a column (for example, if it uses
the <literal>linerange</literal> <sgmltag class="attribute">unit</sgmltag>),
it will appear in the default column.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="tablecolumns.extension" select="'1'" doc:type='boolean'/>

<doc:param name="tablecolumns.extension" xmlns="">
<refpurpose>Enable the table columns extension function</refpurpose>
<refdescription>
<para>The table columns extension function adjusts the widths of table
columns in the HTML result to more accurately reflect the specifications
in the CALS table.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="nominal.table.width" select="'6in'" doc:type='length'/>

<doc:param name="nominal.table.width" xmlns="">
<refpurpose>The (absolute) nominal width of tables</refpurpose>
<refdescription>
<para>In order to convert CALS column widths into FO column widths, it
is sometimes necessary to have an absolute table width to use for conversion
of mixed absolute and relative widths. This value must be an absolute
length (not a percentage).</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="default.table.width" select="''" doc:type='length'/>

<doc:param name="default.table.width" xmlns="">
<refpurpose>The default width of tables</refpurpose>
<refdescription>
<para>If specified, this value will be used for the WIDTH attribute on
tables that do not specify an alternate width (with the dbhtml processing
instruction).</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="paper.type" select="'USletter'"/>
<doc:param name="paper.type" xmlns="">
<refpurpose>Select the paper type</refpurpose>
<refdescription>
<para>The paper type is a convenient way to specify the paper size.
The list of known paper sizes includes USletter and most of the A,
B, and C sizes. See <literal>page.width.portrait</literal>, for example.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="page.orientation" select="'portrait'"/>
<doc:param name="page.orientation" xmlns="">
<refpurpose>Select the page orientation</refpurpose>
<refdescription>
<para>In portrait orientation, the short edge is horizontal; in
landscape orientation, it is vertical.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="page.width.portrait">
  <xsl:choose>
    <xsl:when test="$paper.type = 'USletter'">8.5in</xsl:when>
    <xsl:when test="$paper.type = '4A0'">1682mm</xsl:when>
    <xsl:when test="$paper.type = '2A0'">1189mm</xsl:when>
    <xsl:when test="$paper.type = 'A0'">841mm</xsl:when>
    <xsl:when test="$paper.type = 'A1'">594mm</xsl:when>
    <xsl:when test="$paper.type = 'A2'">420mm</xsl:when>
    <xsl:when test="$paper.type = 'A3'">297mm</xsl:when>
    <xsl:when test="$paper.type = 'A4'">210mm</xsl:when>
    <xsl:when test="$paper.type = 'A5'">148mm</xsl:when>
    <xsl:when test="$paper.type = 'A6'">105mm</xsl:when>
    <xsl:when test="$paper.type = 'A7'">74mm</xsl:when>
    <xsl:when test="$paper.type = 'A8'">52mm</xsl:when>
    <xsl:when test="$paper.type = 'A9'">37mm</xsl:when>
    <xsl:when test="$paper.type = 'A10'">26mm</xsl:when>
    <xsl:when test="$paper.type = 'B0'">1000mm</xsl:when>
    <xsl:when test="$paper.type = 'B1'">707mm</xsl:when>
    <xsl:when test="$paper.type = 'B2'">500mm</xsl:when>
    <xsl:when test="$paper.type = 'B3'">353mm</xsl:when>
    <xsl:when test="$paper.type = 'B4'">250mm</xsl:when>
    <xsl:when test="$paper.type = 'B5'">176mm</xsl:when>
    <xsl:when test="$paper.type = 'B6'">125mm</xsl:when>
    <xsl:when test="$paper.type = 'B7'">88mm</xsl:when>
    <xsl:when test="$paper.type = 'B8'">62mm</xsl:when>
    <xsl:when test="$paper.type = 'B9'">44mm</xsl:when>
    <xsl:when test="$paper.type = 'B10'">31mm</xsl:when>
    <xsl:when test="$paper.type = 'C0'">917mm</xsl:when>
    <xsl:when test="$paper.type = 'C1'">648mm</xsl:when>
    <xsl:when test="$paper.type = 'C2'">458mm</xsl:when>
    <xsl:when test="$paper.type = 'C3'">324mm</xsl:when>
    <xsl:when test="$paper.type = 'C4'">229mm</xsl:when>
    <xsl:when test="$paper.type = 'C5'">162mm</xsl:when>
    <xsl:when test="$paper.type = 'C6'">114mm</xsl:when>
    <xsl:when test="$paper.type = 'C7'">81mm</xsl:when>
    <xsl:when test="$paper.type = 'C8'">57mm</xsl:when>
    <xsl:when test="$paper.type = 'C9'">40mm</xsl:when>
    <xsl:when test="$paper.type = 'C10'">28mm</xsl:when>
    <xsl:otherwise>8.5in</xsl:otherwise>
  </xsl:choose>
</xsl:param>

<doc:param name="page.width.portrait" xmlns="">
<refpurpose>Specify the physical size of the short edge of the page</refpurpose>
<refdescription>
<para>The portrait page width is the length of the short
edge of the physical page.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="page.height.portrait">
  <xsl:choose>
    <xsl:when test="$paper.type = 'A4landscape'">210mm</xsl:when>
    <xsl:when test="$paper.type = 'USletter'">11in</xsl:when>
    <xsl:when test="$paper.type = 'USlandscape'">8.5in</xsl:when>
    <xsl:when test="$paper.type = '4A0'">2378mm</xsl:when>
    <xsl:when test="$paper.type = '2A0'">1682mm</xsl:when>
    <xsl:when test="$paper.type = 'A0'">1189mm</xsl:when>
    <xsl:when test="$paper.type = 'A1'">841mm</xsl:when>
    <xsl:when test="$paper.type = 'A2'">594mm</xsl:when>
    <xsl:when test="$paper.type = 'A3'">420mm</xsl:when>
    <xsl:when test="$paper.type = 'A4'">297mm</xsl:when>
    <xsl:when test="$paper.type = 'A5'">210mm</xsl:when>
    <xsl:when test="$paper.type = 'A6'">148mm</xsl:when>
    <xsl:when test="$paper.type = 'A7'">105mm</xsl:when>
    <xsl:when test="$paper.type = 'A8'">74mm</xsl:when>
    <xsl:when test="$paper.type = 'A9'">52mm</xsl:when>
    <xsl:when test="$paper.type = 'A10'">37mm</xsl:when>
    <xsl:when test="$paper.type = 'B0'">1414mm</xsl:when>
    <xsl:when test="$paper.type = 'B1'">1000mm</xsl:when>
    <xsl:when test="$paper.type = 'B2'">707mm</xsl:when>
    <xsl:when test="$paper.type = 'B3'">500mm</xsl:when>
    <xsl:when test="$paper.type = 'B4'">353mm</xsl:when>
    <xsl:when test="$paper.type = 'B5'">250mm</xsl:when>
    <xsl:when test="$paper.type = 'B6'">176mm</xsl:when>
    <xsl:when test="$paper.type = 'B7'">125mm</xsl:when>
    <xsl:when test="$paper.type = 'B8'">88mm</xsl:when>
    <xsl:when test="$paper.type = 'B9'">62mm</xsl:when>
    <xsl:when test="$paper.type = 'B10'">44mm</xsl:when>
    <xsl:when test="$paper.type = 'C0'">1297mm</xsl:when>
    <xsl:when test="$paper.type = 'C1'">917mm</xsl:when>
    <xsl:when test="$paper.type = 'C2'">648mm</xsl:when>
    <xsl:when test="$paper.type = 'C3'">458mm</xsl:when>
    <xsl:when test="$paper.type = 'C4'">324mm</xsl:when>
    <xsl:when test="$paper.type = 'C5'">229mm</xsl:when>
    <xsl:when test="$paper.type = 'C6'">162mm</xsl:when>
    <xsl:when test="$paper.type = 'C7'">114mm</xsl:when>
    <xsl:when test="$paper.type = 'C8'">81mm</xsl:when>
    <xsl:when test="$paper.type = 'C9'">57mm</xsl:when>
    <xsl:when test="$paper.type = 'C10'">40mm</xsl:when>
    <xsl:otherwise>11in</xsl:otherwise>
  </xsl:choose>
</xsl:param>

<doc:param name="page.height.portrait" xmlns="">
<refpurpose>Specify the physical size of the long edge of the page</refpurpose>
<refdescription>
<para>The portrait page height is the length of the long
edge of the physical page.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="page.width">
  <xsl:choose>
    <xsl:when test="$page.orientation = 'portrait'">
      <xsl:value-of select="$page.width.portrait"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$page.height.portrait"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:param>

<doc:param name="page.width" xmlns="">
<refpurpose>The width of the physical page</refpurpose>
<refdescription>
<para>The page width is generally calculated from the
<literal>paper.type</literal> and
<literal>page.orientation</literal>.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="page.height">
  <xsl:choose>
    <xsl:when test="$page.orientation = 'portrait'">
      <xsl:value-of select="$page.height.portrait"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$page.width.portrait"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:param>

<doc:param name="page.height" xmlns="">
<refpurpose>The height of the physical page</refpurpose>
<refdescription>
<para>The page height is generally calculated from the
<literal>paper.type</literal> and
<literal>page.orientation</literal>.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="double.sided" select="'0'"/>

<doc:param name="double.sided" xmlns="">
<refpurpose>Is the document to be printed double sided?</refpurpose>
<refdescription>
<para>Double-sided documents are printed with a slightly wider margin
on the binding edge of the page.
</para>
<para>FIXME: The current set of parameters does not take writing direction
into account.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="column.count" select="'1'"/>

<doc:param name="column.count" xmlns="">
<refpurpose>Specifies the number of columns of text on the page</refpurpose>
<refdescription>
<para>The specified number of columns of text will appear on each page.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="region.after.extent" select="'12pt'"/>

<doc:param name="region.after.extent" xmlns="">
<refpurpose>Specifies the height of the footer.</refpurpose>
<refdescription>
<para>The region after extent is the height of the area where footers
are printed.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="region.before.extent" select="'12pt'"/>

<doc:param name="region.before.extent" xmlns="">
<refpurpose>Specifies the height of the header</refpurpose>
<refdescription>
<para>The region before extent is the height of the area where headers
are printed.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="page.margin.top">1in</xsl:param>

<doc:param name="page.margin.top" xmlns="">
<refpurpose>The top margin of the page</refpurpose>
<refdescription>
<para>The top page margin is the distance from the physical top of the
page to the first line of text (body or header).
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="page.margin.bottom">1in</xsl:param>

<doc:param name="page.margin.bottom" xmlns="">
<refpurpose>The bottom margin of the page</refpurpose>
<refdescription>
<para>The bottom page margin is the distance from the physical bottom of
the page to the last line of text (body or footer).
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="page.margin.inner">
  <xsl:choose>
    <xsl:when test="$double.sided != 0">1.25in</xsl:when>
    <xsl:otherwise>1in</xsl:otherwise>
  </xsl:choose>
</xsl:param>

<doc:param name="page.margin.inner" xmlns="">
<refpurpose>The inner page margin</refpurpose>
<refdescription>
<para>The inner page margin is the distance from binding edge of the
page to the first column of text. In the left-to-right, top-to-bottom writing
direction, this is the left margin of recto pages.</para>
<para>The inner and outer margins are usually the same unless the output
is double-sided.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="page.margin.outer">
  <xsl:choose>
    <xsl:when test="$double.sided != 0">0.75in</xsl:when>
    <xsl:otherwise>10pc</xsl:otherwise>
  </xsl:choose>
</xsl:param>

<doc:param name="page.margin.outer" xmlns="">
<refpurpose>The outer page margin</refpurpose>
<refdescription>
<para>The outer page margin is the distance from non-binding edge of the
page to the last column of text. In the left-to-right, top-to-bottom writing
direction, this is the right margin of recto pages.</para>
<para>The inner and outer margins are usually the same unless the output
is double-sided.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="body.margin.bottom">24pt</xsl:param>

<doc:param name="body.margin.bottom" xmlns="">
<refpurpose>The bottom margin of the body text</refpurpose>
<refdescription>
<para>The body bottom margin is the distance from the last line of text
in the page body to the bottom page margin. Note that the page footer, if
any, appears in the space between the body bottom margin and the page
bottom margin.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="body.margin.top">24pt</xsl:param>

<doc:param name="body.margin.top" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>The body top margin is the distance from the page top margin to
the first line of text
in the page body. Note that the page header, if
any, appears in the space between the page top margin and the body
top margin.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="body.font.family">Times Roman</xsl:param>

<doc:param name="body.font.family" xmlns="">
<refpurpose>The default font family for body text</refpurpose>
<refdescription>
<para>The body font family is the default font used for text in the page body.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="title.font.family">Helvetica</xsl:param>

<doc:param name="title.font.family" xmlns="">
<refpurpose>The default font family for titles</refpurpose>
<refdescription>
<para>The title font family is used for titles (chapter, section, figure,
etc.)
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="monospace.font.family">Courier</xsl:param>

<doc:param name="monospace.font.family" xmlns="">
<refpurpose>The default font family for monospace environments</refpurpose>
<refdescription>
<para>The monospace font family is used for verbatim environments
(program listings, screens, etc.).
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="sans.font.family">Helvetica</xsl:param>

<doc:param name="sans.font.family" xmlns="">
<refpurpose>The default sans-serif font family</refpurpose>
<refdescription>
<para>The default sans-serif font family. At the present, this isn't
actually used by the stylesheets.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="body.font.master">10</xsl:param>

<doc:param name="body.font.master" xmlns="">
<refpurpose>Specifies the default point size for body text</refpurpose>
<refdescription>
<para>The body font size is specified in two parameters
(<varname>body.font.master</varname> and <varname>body.font.size</varname>)
so that math can be performed on the font size by XSLT.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="body.font.size">
 <xsl:value-of select="$body.font.master"/><xsl:text>pt</xsl:text>
</xsl:param>

<doc:param name="body.font.size" xmlns="">
<refpurpose>Specifies the default font size for body text</refpurpose>
<refdescription>
<para>The body font size is specified in two parameters
(<varname>body.font.master</varname> and <varname>body.font.size</varname>)
so that math can be performed on the font size by XSLT.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="footnote.font.size">
 <xsl:value-of select="$body.font.master * 0.8"/><xsl:text>pt</xsl:text>
</xsl:param>

<doc:param name="footnote.font.size" xmlns="">
<refpurpose>The font size for footnotes</refpurpose>
<refdescription>
<para>The footnote font size is used for...footnotes!
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<!-- general H&J setup -->
<xsl:param name="hyphenate">true</xsl:param>

<doc:param name="hyphenate" xmlns="">
<refpurpose>Specify hyphenation behavior</refpurpose>
<refdescription>
<para>If true, words may be hyphenated. Otherwise, they may not.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="alignment">justify</xsl:param>

<doc:param name="alignment" xmlns="">
<refpurpose>Specify the default text alignment</refpurpose>
<refdescription>
<para>The default text alignment is used for most body text.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="stylesheet.result.type" select="'fo'"/>

<doc:param name="stylesheet.result.type" xmlns="">
<refpurpose>Identifies the output format of this stylesheet</refpurpose>
<refdescription>
<para>The extension functions need to know if the output format
is HTML ('html') or XSL Formatting Objects ('fo'). This variable answers
that question. Valid settings are 'html' or 'fo'.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.component.toc" select="0" doc:type='boolean'/>

<doc:param name="generate.component.toc" xmlns="">
<refpurpose>Generate a table of contents for components?</refpurpose>
<refdescription>
<para>If non-zero, a table of contents is generated at the beginning
of each component (chapters, appendixes, etc.)
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.division.toc" select="1" doc:type='boolean'/>

<doc:param name="generate.division.toc" xmlns="">
<refpurpose>Generate a table of contents for divisions?</refpurpose>
<refdescription>
<para>If non-zero, a table of contents is generated at the beginning
of each division (sets, books, etc.)
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->

<xsl:param name="generate.book.toc" select="'1'" doc:type='boolean'/>
<xsl:param name="process.source.toc" select='0' doc:type='boolean'/>
<xsl:param name="process.empty.source.toc" select='0' doc:type='boolean'/>

<!-- ==================================================================== -->
<xsl:param name="generate.division.figure.lot" select="1" doc:type='boolean'/>

<doc:param name="generate.division.figure.lot" xmlns="">
<refpurpose>Generate a list of titles for Figures?</refpurpose>
<refdescription>
<para>If non-zero, a list of titles is generated for Figures.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.division.example.lot" select="1" doc:type='boolean'/>

<doc:param name="generate.division.example.lot" xmlns="">
<refpurpose>Generate a list of titles for Examples?</refpurpose>
<refdescription>
<para>If non-zero, a list of titles is generated for Examples.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.division.equation.lot" select="1" doc:type='boolean'/>

<doc:param name="generate.division.equation.lot" xmlns="">
<refpurpose>Generate a list of titles for Equations?</refpurpose>
<refdescription>
<para>If non-zero, a list of titles is generated for Equations.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.division.table.lot" select="1" doc:type='boolean'/>

<doc:param name="generate.division.table.lot" xmlns="">
<refpurpose>Generate a list of titles for Tables?</refpurpose>
<refdescription>
<para>If non-zero, a list of titles is generated for Tables.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.book.figure.lot" select="1" doc:type='boolean'/>
<xsl:param name="generate.book.example.lot" select="1" doc:type='boolean'/>
<xsl:param name="generate.book.equation.lot" select="1" doc:type='boolean'/>
<xsl:param name="generate.book.table.lot" select="1" doc:type='boolean'/>

<!-- ==================================================================== -->
<xsl:param name="passivetex.extensions" select="0" doc:type='boolean'/>

<doc:param name="passivetex.extensions" xmlns="">
<refpurpose>Enable PassiveTeX extensions?</refpurpose>
<refdescription>
<para>If non-zero,
<ulink url="http://users.ox.ac.uk/~rahtz/passivetex/">PassiveTeX</ulink>
extensions will be used. At present, this consists of PDF bookmarks
and sorted index terms.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="arbortext.extensions" select="0" doc:type='boolean'/>

<doc:param name="arbortext.extensions" xmlns="">
<refpurpose>Enable Arbortext extensions?</refpurpose>
<refdescription>
<para>If non-zero,
<ulink url="http://www.arbortext.com/">Arbortext</ulink>
extensions will be used.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="fop.extensions" select="0" doc:type='boolean'/>

<doc:param name="fop.extensions" xmlns="">
<refpurpose>Enable FOP extensions?</refpurpose>
<refdescription>
<para>If non-zero,
<ulink url="http://xml.apache.org/fop/">FOP</ulink>
extensions will be used. At present, this consists of PDF bookmarks.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="default.units" select="'pt'" doc:type='list'
           doc:list='cm mm in pt pc px em'/>

<doc:param name="default.units" xmlns="">
<refpurpose>Default units for an unqualified dimension</refpurpose>
<refdescription>
<para>If an unqualified dimension is encountered (for example, in a
graphic width), the <parameter>default-units</parameter> will be used for the
units. Unqualified dimensions are not allowed in XSL Formatting Objects.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->

<xsl:param name="generate.index" select="1" doc:type='boolean'/>

<!-- ==================================================================== -->
<xsl:param name="label.from.part" select="'0'" doc:type='boolean'/>

<doc:param name="label.from.part" xmlns="">
<refpurpose>Renumber chapters in each part?</refpurpose>
<refdescription>
<para>If <parameter>label.from.part</parameter> is non-zero, components
(<sgmltag>chapter</sgmltag>s, <sgmltag>appendixe</sgmltag>s, etc.)
will be numbered from 1 in each <sgmltag>part</sgmltag>. Otherwise,
they will be numbered monotonically throughout each
<sgmltag>book</sgmltag>.
</para>
</refdescription>
</doc:param>

</xsl:stylesheet>

