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
<title>HTML Parameter Reference</title>

<partintro>
<section><title>Introduction</title>

<para>This is technical reference documentation for the DocBook XSL
Stylesheets; it documents (some of) the parameters, templates, and
other elements of the stylesheets.</para>

<para>This reference describes each of the HTML Stylesheet parameters.
These are the <quote>easily customizable</quote> parts of the stylesheet.
If you want to specify an alternate value for one or more of these
parameters, you can do so in a <quote>driver</quote> stylesheet.</para>

<para>For example, if you want to change the <literal>html.stylesheet</literal>
to <filename>reference.css</filename>, you might create a driver
stylesheet like this:</para>

<programlisting><![CDATA[<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

  <xsl:import href="/path/to/html/docbook.xsl"/>

  <xsl:param name="html.stylesheet">reference.css</xsl:param>

</xsl:stylesheet>]]></programlisting>

<para>Naturally, you have to change the
<sgmltag class='attribute'>href</sgmltag> attribute on
<literal>&lt;xsl:import&gt;</literal>
to point to <filename>docbook.xsl</filename>
on your system. (Or <filename>chunk.xsl</filename>, if you're using
chunking.)</para>

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
<xsl:param name="author.othername.in.middle" select="1" doc:type='boolean'/>

<doc:param name="author.othername.in.middle" xmlns="">
<refpurpose>Is <sgmltag>othername</sgmltag> in <sgmltag>author</sgmltag> a
middle name?</refpurpose>
<refdescription>
<para>If true (non-zero), the <sgmltag>othername</sgmltag> of an <sgmltag>author</sgmltag>
appears between the <sgmltag>firstname</sgmltag> and
<sgmltag>surname</sgmltag>.  Otherwise, <sgmltag>othername</sgmltag>
is suppressed.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="html.stylesheet" select="''" doc:type='string'/>

<doc:param name="html.stylesheet" xmlns="">
<refpurpose>Name of the stylesheet to use in the generated HTML</refpurpose>
<refdescription>
<para>The name of the stylesheet to place in the HTML <sgmltag>LINK</sgmltag>
tag, or the empty string to suppress the stylesheet <sgmltag>LINK</sgmltag>.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="html.stylesheet.type" doc:type='string'>text/css</xsl:param>

<doc:param name="html.stylesheet.type" xmlns="">
<refpurpose>The type of the stylesheet used in the generated HTML</refpurpose>
<refdescription>
<para>The type of the stylesheet to place in the HTML <sgmltag>link</sgmltag> tag.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="html.base" doc:type='uri'></xsl:param>

<doc:param name="html.base" xmlns="">
<refpurpose>An HTML base URI</refpurpose>
<refdescription>
<para>If html.base is set, it is used for the <sgmltag>BASE</sgmltag>
element in the <sgmltag>HEAD</sgmltag> of the HTML documents.
This is useful for dynamically served HTML where the base URI needs
to be shifted.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="ulink.target" select="'_top'" doc:type='string'/>

<doc:param name="ulink.target" xmlns="">
<refpurpose>The HTML anchor target for ULinks</refpurpose>
<refdescription>
<para>If <parameter>ulink.target</parameter> is set, its value will
be used for the <sgmltag class='attribute'>target</sgmltag> attribute
on anchors generated for <sgmltag>ulink</sgmltag>s.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="refentry.xref.manvolnum" select="1" doc:type='boolean'/>

<doc:param name="refentry.xref.manvolnum" xmlns="">
<refpurpose>Output <sgmltag>manvolnum</sgmltag> as part of 
<sgmltag>refentry</sgmltag> cross-reference?</refpurpose>
<refdescription>
<para>if true (non-zero), the <sgmltag>manvolnum</sgmltag> is used when cross-referencing
<sgmltag>refentry</sgmltag>s, either with <sgmltag>xref</sgmltag>
or <sgmltag>citerefentry</sgmltag>.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="show.comments" doc:type='boolean'>1</xsl:param>

<doc:param name="show.comments" xmlns="">
<refpurpose>Display <sgmltag>comment</sgmltag> elements?</refpurpose>
<refdescription>
<para>If true (non-zero), comments will be displayed, otherwise they are suppressed.
Comments here refers to the <sgmltag>comment</sgmltag> element,
which will be renamed <sgmltag>remark</sgmltag> in DocBook V4.0,
not XML comments (&lt;-- like this --&gt;) which are unavailable.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="funcsynopsis.style"
           doc:type='list'
           doc:list='ansi kr'>kr</xsl:param>

<doc:param name="funcsynopsis.style" xmlns="">
<refpurpose>What style of 'FuncSynopsis' should be generated?</refpurpose>
<refdescription>
<para>If <varname>funcsynopsis.style</varname> is <literal>ansi</literal>,
ANSI-style function synopses are generated for a
<sgmltag>funcsynopsis</sgmltag>, otherwise K&amp;R-style
function synopses are generated.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="funcsynopsis.decoration" select="1" doc:type='boolean'/>

<doc:param name="funcsynopsis.decoration" xmlns="">
<refpurpose>Decorate elements of a FuncSynopsis?</refpurpose>
<refdescription>
<para>If true (non-zero), elements of the FuncSynopsis will be decorated (e.g. bold or
italic).  The decoration is controlled by functions that can be redefined
in a customization layer.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="function.parens" doc:type='boolean'>0</xsl:param>

<doc:param name="function.parens" xmlns="">
<refpurpose>Generate parens after a function?</refpurpose>
<refdescription>
<para>If not 0, the formatting of
a <sgmltag class="starttag">function</sgmltag> element will include
generated parenthesis.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="refentry.generate.name" select="1" doc:type='boolean'/>

<doc:param name="refentry.generate.name" xmlns="">
<refpurpose>Output NAME header before 'RefName'(s)?</refpurpose>
<refdescription>
<para>If true (non-zero), a "NAME" section title is output before the list
of 'RefName's.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="admon.graphics" select="0" doc:type='boolean'/>

<doc:param name="admon.graphics" xmlns="">
<refpurpose>Use graphics in admonitions?</refpurpose>
<refdescription>
<para>If true (non-zero), admonitions are presented in an alternate style that uses
a graphic.  Default graphics are provided in the distribution.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="admon.graphics.path" doc:type='string'>../images/</xsl:param>

<doc:param name="admon.graphics.path" xmlns="">
<refpurpose>Path to admonition graphics</refpurpose>
<refdescription>
<para>Sets the path, probably relative to the directory where the HTML
files are created, to the admonition graphics.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="admon.graphics.extension" select="'.png'" doc:type='string'/>

<doc:param name="admon.graphics.extension" xmlns="">
<refpurpose>Extension for admonition graphics</refpurpose>
<refdescription>
<para>Sets the extension to use on admonition graphics.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="admon.style" doc:type='string'>
  <xsl:text>margin-left: 0.5in; margin-right: 0.5in;</xsl:text>
</xsl:param>

<doc:param name="admon.style" xmlns="">
<refpurpose>CSS style attributes for admonitions</refpurpose>
<refdescription>
<para>Specifies the value of the <sgmltag class="attribute">STYLE</sgmltag>
attribute that should be added to admonitions.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="section.autolabel" select="0" doc:type='boolean'/>

<doc:param name="section.autolabel" xmlns="">
<refpurpose>Are sections enumerated?</refpurpose>
<refdescription>
<para>If true (non-zero), unlabeled sections will be enumerated.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="section.label.includes.component.label" select="0"
           doc:type='boolean'/>

<doc:param name="section.label.includes.component.label" xmlns="">
<refpurpose>Do section labels include the component label?</refpurpose>
<refdescription>
<para>If true (non-zero), section labels are prefixed with the label of the
component that contains them.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="chapter.autolabel" select="1" doc:type='boolean'/>
<xsl:param name="appendix.autolabel" select="1" doc:type='boolean'/>

<doc:param name="chapter.autolabel" xmlns="">
<refpurpose>Are chapters and appendixes enumerated?</refpurpose>
<refdescription>
<para>If true (non-zero), unlabeled chapters and appendixes will be enumerated.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="preface.autolabel" select="0" doc:type='boolean'/>

<doc:param name="preface.autolabel" xmlns="">
<refpurpose>Are prefaces enumerated?</refpurpose>
<refdescription>
<para>If true (non-zero), unlabeled prefaces will be enumerated.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="part.autolabel" select="1" doc:type='boolean'/>

<doc:param name="part.autolabel" xmlns="">
<refpurpose>Are parts and references enumerated?</refpurpose>
<refdescription>
<para>If true (non-zero), unlabeled parts and references will be enumerated.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="qandadiv.autolabel" select="1" doc:type='boolean'/>

<doc:param name="qandadiv.autolabel" xmlns="">
<refpurpose>Are divisions in QAndASets enumerated?</refpurpose>
<refdescription>
<para>If true (non-zero), unlabeled qandadivs will be enumerated.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="qanda.inherit.numeration" select="1" doc:type='boolean'/>

<doc:param name="qanda.inherit.numeration" xmlns="">
<refpurpose>Does enumeration of QandASet components inherit the numeration of parent elements?</refpurpose>
<refdescription>
<para>If true (non-zero), numbered QandADiv elements and Questions and Answers inherit
the numeration of the ancestors of the QandASet.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="qanda.defaultlabel"
           doc:type='boolean'
           doc:list='qanda number none'>number</xsl:param>

<doc:param name="qanda.defaultlabel" xmlns="">
<refpurpose>Sets the default for defaultlabel on QandASet.</refpurpose>
<refdescription>
<para>If no defaultlabel attribute is specified on a QandASet, this
value is used. It must be one of the legal values for the defaultlabel
attribute.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.qandaset.toc" doc:type='boolean'>1</xsl:param>

<doc:param name="generate.qandaset.toc" xmlns="">
<refpurpose>Is a Table of Contents created for QandASets?</refpurpose>
<refdescription>
<para>If true (non-zero), a ToC is constructed for QandASets.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.qandadiv.toc" doc:type='boolean'>0</xsl:param>

<doc:param name="generate.qandadiv.toc" xmlns="">
<refpurpose>Is a Table of Contents created for QandADivs?</refpurpose>
<refdescription>
<para>If true (non-zero), a ToC is constructed for QandADivs.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="biblioentry.item.separator" doc:type='string'>. </xsl:param>

<doc:param name="biblioentry.item.separator" xmlns="">
<refpurpose>Text to separate bibliography entries</refpurpose>
<refdescription>
<para>Text to separate bibliography entries
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="toc.section.depth"
           doc:type='integer'
           doc:min='1'
           doc:max='10'>2</xsl:param>

<doc:param name="toc.section.depth" xmlns="">
<refpurpose>How deep should recursive <sgmltag>section</sgmltag>s appear
in the TOC?</refpurpose>
<refdescription>
<para>Specifies the depth to which recursive sections should appear in the
TOC.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="using.chunker" select="0" doc:type='boolean'/>

<doc:param name="using.chunker" xmlns="">
<refpurpose>Will the output be chunked?</refpurpose>
<refdescription>
<para>In addition to providing chunking, the chunker can cleanup a
number of XML to HTML issues. If the chunker is not being used, the
stylesheets try to avoid producing results that will not appear properly
in browsers.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.component.toc" select="1" doc:type='boolean'/>

<doc:param name="generate.component.toc" xmlns="">
<refpurpose>Should TOCs be genereated in components (Chapters, Appendixes, etc.)?</refpurpose>
<refdescription>
<para>If true (non-zero), they are.
</para>
</refdescription>
</doc:param>
<!-- ==================================================================== -->
<xsl:param name="generate.division.toc" select="1" doc:type='boolean'/>

<doc:param name="generate.division.toc" xmlns="">
<refpurpose>Should TOCs be genereated in divisions (Books, Parts, etc.)?</refpurpose>
<refdescription>
<para>If true (non-zero), they are.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="link.mailto.url" doc:type='string'></xsl:param>

<doc:param name="link.mailto.url" xmlns="">
<refpurpose>Mailto URL for the LINK REL=made HTML HEAD element</refpurpose>
<refdescription>
<para>If not the empty string, this address will be used for the
REL=made <sgmltag>LINK</sgmltag> element in the HTML <sgmltag>HEAD</sgmltag>.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="graphic.default.extension" doc:type='string'></xsl:param>

<doc:param name="graphic.default.extension" xmlns="">
<refpurpose>Default extension for graphic filenames</refpurpose>
<refdescription>
<para>If a <sgmltag>graphic</sgmltag> or <sgmltag>mediaobject</sgmltag>
includes a reference to a filename that does not include an extension,
and the <sgmltag class="attribute">format</sgmltag> attribute is
<emphasis>unspecified</emphasis>, the default extension will be used.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="toc.list.type"
           doc:type='list'
           doc:list='dl ul ol'>dl</xsl:param>

<doc:param name="toc.list.type" xmlns="">
<refpurpose>Type of HTML list element to use for Tables of Contents</refpurpose>
<refdescription>
<para>When an automatically generated Table of Contents (or List of Titles)
is produced, this HTML element will be used to make the list.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="check.idref" doc:type='boolean'>1</xsl:param>

<doc:param name="check.idref" xmlns="">
<refpurpose>Test the target of IDREF attributes?</refpurpose>
<refdescription>
<para>If 1, the target of IDREF attributes are tested for presence
(and uniqueness). This can be very expensive in large documents.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="use.id.function" doc:type='boolean' select="'1'"/>

<doc:param name="use.id.function" xmlns="">
<refpurpose>Use the XPath id() function to find link targets?</refpurpose>
<refdescription>
<para>If 1, the stylesheets use the <function>id()</function> function
to find the targets of cross reference elements. This is more
efficient, but only works if your XSLT processor implements the
<function>id()</function> function, naturally.</para>
<para>THIS PARAMETER IS NOT SUPPORTED. IT IS ALWAYS ASSUMED TO BE 1.
SEE xref.xsl IF YOU NEED TO TURN IT OFF.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="spacing.paras" doc:type='boolean' select="'0'"/>

<doc:param name="spacing.paras" xmlns="">
<refpurpose>Insert additional &lt;p&gt; elements for spacing?</refpurpose>
<refdescription>
<para>When non-zero, additional, empty paragraphs are inserted in
several contexts (for example, around informal figures), to create a
more pleasing visual appearance in many browsers.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:attribute-set name="body.attrs">
  <xsl:attribute name="bgcolor">white</xsl:attribute>
  <xsl:attribute name="text">black</xsl:attribute>
  <xsl:attribute name="link">#0000FF</xsl:attribute>
  <xsl:attribute name="vlink">#840084</xsl:attribute>
  <xsl:attribute name="alink">#0000FF</xsl:attribute>
</xsl:attribute-set>

<doc:attribute-set name="body.attrs" xmlns="">
<refpurpose>Additional attributes for the HTML body tag</refpurpose>
<refdescription>
<para>The attributes defined by this attribute set are added to the
HTML &lt;body&gt; tag.
</para>
</refdescription>
</doc:attribute-set>

<!-- ==================================================================== -->
<xsl:param name="css.decoration" doc:type='boolean'>1</xsl:param>

<doc:param name="css.decoration" xmlns="">
<refpurpose>Enable CSS decoration of elements</refpurpose>
<refdescription>
<para>
If <literal>css.decoration</literal> is turned on, then HTML elements
produced by the
stylesheet may be decorated with STYLE attributes.  For example, the
LI tags produced for list items may include a fragment of CSS in the
STYLE attribute which sets the CSS property "list-style-type".
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="show.revisionflag" doc:type='boolean'>0</xsl:param>

<doc:param name="show.revisionflag" xmlns="">
<refpurpose>Enable decoration of elements that have a revisionflag</refpurpose>
<refdescription>
<para>
If <literal>show.revisionflag</literal> is turned on, then the stylesheets
may produce additional markup designed to allow a CSS stylesheet to
highlight elements that have specific revisionflag settings.</para>

<para>The markup inserted will be usually be either a &lt;span> or &lt;div>
with an appropriate <literal>class</literal> attribute. (The value of
the class attribute will be the same as the value of the revisionflag
attribute). In some contexts, for example tables, where extra markup
would be structurally illegal, the class attribute will be added to the
appropriate container element.</para>

<para>In general, the stylesheets only test for revisionflag in contexts
where an importing stylesheet would have to redefine whole templates.
Most of the revisionflag processing is expected to be done by another
stylesheet, for example <filename>changebars.xsl</filename>.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="suppress.navigation" doc:type='boolean'>0</xsl:param>

<doc:param name="suppress.navigation" xmlns="">
<refpurpose>Disable header and footer navigation</refpurpose>
<refdescription>
<para>
If <literal>suppress.navigation</literal> is turned on, header and
footer navigation will be suppressed.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="rootid" select="''" doc:type='string'/>

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
<xsl:param name="callout.list.table" select="'1'" doc:type='boolean'/>

<doc:param name="callout.list.table" xmlns="">
<refpurpose>Present callout lists using a table?</refpurpose>
<refdescription>
<para>The default presentation of <sgmltag>CalloutList</sgmltag>s uses
an HTML <sgmltag>DL</sgmltag>. Some browsers don't align DLs very well
if <parameter>callout.graphics</parameter> are used. With this option
turned on, <sgmltag>CalloutList</sgmltag>s are presented in an HTML
<sgmltag>TABLE</sgmltag>, which usually results in better alignment
of the callout number with the callout description.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.graphics" select="'1'" doc:type='boolean'/>

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
<xsl:param name="callout.graphics.extension" select="'.png'" doc:type='string'/>

<doc:param name="callout.graphics.extension" xmlns="">
<refpurpose>Extension for callout graphics</refpurpose>
<refdescription>
<para>Sets the extension to use on callout graphics.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.graphics.path" select="'../images/callouts/'" doc:type='string'/>

<doc:param name="callout.graphics.path" xmlns="">
<refpurpose>Path to callout graphics</refpurpose>
<refdescription>
<para>Sets the path, probably relative to the directory where the HTML
files are created, to the callout graphics.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.graphics.number.limit" select="'10'"
           doc:type='integer'/>

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
<xsl:param name="use.extensions" select="'0'" doc:type='boolean'/>

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
<xsl:param name="textinsert.extension" select="'1'" doc:type='boolean'/>

<doc:param name="textinsert.extension" xmlns="">
<refpurpose>Enable the textinsert extension element</refpurpose>
<refdescription>
<para>The textinsert extension element inserts the contents of a
a file into the result tree (as text).
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="saxon.linenumbering" select="'1'" doc:type='boolean'/>

<doc:param name="saxon.linenumbering" xmlns="">
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
<xsl:param name="linenumbering.extension" select="'1'" doc:type='boolean'/>

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
<xsl:param name="linenumbering.everyNth" select="'5'" doc:type='integer'/>

<doc:param name="linenumbering.everyNth" xmlns="">
<refpurpose>Indicate which lines should be numbered</refpurpose>
<refdescription>
<para>If line numbering is enabled, everyNth line will be numbered.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="linenumbering.width" select="'3'" doc:type='integer'/>

<doc:param name="linenumbering.width" xmlns="">
<refpurpose>Indicates the width of line numbers</refpurpose>
<refdescription>
<para>If line numbering is enabled, line numbers will appear right
justified in a field "width" characters wide.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="linenumbering.separator" select="' '" doc:type='string'/>

<doc:param name="linenumbering.separator" xmlns="">
<refpurpose>Specify a separator between line numbers and lines</refpurpose>
<refdescription>
<para>The separator is inserted between line numbers and lines in
the verbatim environment.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="saxon.callouts" select="'1'" doc:type='boolean'/>

<doc:param name="saxon.callouts" xmlns="">
<refpurpose>Enable the callout extension</refpurpose>
<refdescription>
<para>The callouts extension processes <sgmltag>areaset</sgmltag>
elements in <sgmltag>ProgramListingCO</sgmltag> and other text-based
callout elements.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callouts.extension" select="'1'" doc:type='boolean'/>

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
<xsl:param name="callout.defaultcolumn" select="'60'" doc:type='integer'/>

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
<xsl:param name="stylesheet.result.type" select="'html'"
           doc:type='list'
           doc:list='html fo'/>

<doc:param name="stylesheet.result.type" xmlns="">
<refpurpose>Identifies the output format of this stylesheet</refpurpose>
<refdescription>
<para>The Saxon extension functions need to know if the output format
is HTML ('html') or XSL Formatting Objects ('fo'). This variable answers
that question. Valid settings are 'html' or 'fo'.</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="nominal.table.width" select="'6in'" doc:type='length'/>

<doc:param name="nominal.table.width" xmlns="">
<refpurpose>The (absolute) nominal width of tables</refpurpose>
<refdescription>
<para>In order to convert CALS column widths into HTML column widths, it
is sometimes necessary to have an absolute table width to use for conversion
of mixed absolute and relative widths. This value must be an absolute
length (not a percentag).</para>
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
<xsl:param name="saxon.tablecolumns" select="'1'" doc:type='boolean'/>

<doc:param name="saxon.tablecolumns" xmlns="">
<refpurpose>Enable the table columns extension function</refpurpose>
<refdescription>
<para>The table columns extension function adjusts the widths of table
columns in the HTML result to more accurately reflect the specifications
in the CALS table.
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
<xsl:param name="generate.set.toc" select='1' doc:type='boolean'/>

<doc:param name="generate.set.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.book.toc" select='1' doc:type='boolean'/>

<doc:param name="generate.book.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.part.toc" select='1' doc:type='boolean'/>

<doc:param name="generate.part.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.reference.toc" select='1' doc:type='boolean'/>

<doc:param name="generate.reference.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.preface.toc" select='1' doc:type='boolean'/>

<doc:param name="generate.preface.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.chapter.toc" select='1' doc:type='boolean'/>

<doc:param name="generate.chapter.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.appendix.toc" select='1' doc:type='boolean'/>

<doc:param name="generate.appendix.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.article.toc" select='1' doc:type='boolean'/>

<doc:param name="generate.article.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.section.toc" select='0' doc:type='boolean'/>

<doc:param name="generate.section.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="process.source.toc" select='0' doc:type='boolean'/>

<doc:param name="process.source.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="process.empty.source.toc" select='0' doc:type='boolean'/>

<doc:param name="process.empty.source.toc" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="bridgehead.in.toc" select='0' doc:type='boolean'/>

<doc:param name="bridgehead.in.toc" xmlns="">
<refpurpose>Should bridgehead elements appear in the TOC?</refpurpose>
<refdescription>
<para>If non-zero, bridgeheads appear in the TOC. Note that this option
is not fully supported and may be removed in a future version of the
stylesheets.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="generate.index" select='1' doc:type='boolean'/>

<doc:param name="generate.index" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="callout.unicode" select="0" doc:type='boolean'/>

<doc:param name="callout.unicode" xmlns="">
<refpurpose>FIXME:</refpurpose>
<refdescription>
<para>FIXME:
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
<xsl:param name="use.id.as.filename" select="'0'" doc:type='boolean'/>

<doc:param name="use.id.as.filename" xmlns="">
<refpurpose>Use ID value of chunk elements as the filename?</refpurpose>
<refdescription>
<para>If <parameter>use.id.as.filename</parameter>
is non-zero, the filename of chunk elements that have IDs will be
derived from the ID value.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="inherit.keywords" select="'1'" doc:type='boolean'/>

<doc:param name="inherit.keywords" xmlns="">
<refpurpose>Inherit keywords from ancestor elements?</refpurpose>
<refdescription>
<para>If <parameter>inherit.keywords</parameter>
is non-zero, the keyword <sgmltag>META</sgmltag> for each HTML
<sgmltag>HEAD</sgmltag> element will include all of the keywords from
ancestral elements. Otherwise, only the keywords from the current section
will be used.
</para>
</refdescription>
</doc:param>

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

<!-- ==================================================================== -->
<xsl:param name="citerefentry.link" select="'0'" doc:type='boolean'/>

<doc:param name="citerefentry.link" xmlns="">
<refpurpose>Generate URL links when cross-referencing RefEntrys?</refpurpose>
<refdescription>
<para>If true, a web link will be generated, presumably
to an online man->HTML gateway. The text of the link is
generated by the generate.citerefentry.link template.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="default.encoding" select="'ISO-8859-1'" doc:type='string'/>

<doc:param name="default.encoding" xmlns="">
<refpurpose>Encoding used in generated HTML pages</refpurpose>
<refdescription>
<para>This encoding is used in files generated by chunking stylesheet. Currently
only Saxon is able to change output encoding.
</para>
</refdescription>
</doc:param>

<!-- ==================================================================== -->
<xsl:param name="saxon.character.representation" select="'entity;decimal'" doc:type='string'/>

<doc:param name="saxon.character.representation" xmlns="">
<refpurpose>Saxon character representation used in generated HTML pages</refpurpose>
<refdescription>
<para>This character representation is used in files generated by chunking stylesheet. If
you want to suppress entity references for characters with direct representation 
in default.encoding, set this parameter to value <literal>native</literal>. 
</para>
</refdescription>
</doc:param>


</xsl:stylesheet>
