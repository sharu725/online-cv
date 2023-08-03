<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xt="http://www.jclark.com/xt"
    xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
    version="1.0"
    exclude-result-prefixes="doc xt"
    extension-element-prefixes="xt">

  <!--**********************************************
      *
      * dict.xsl: convert dict. of thieving slang into HTML
      *
      * Liam Quin, 2001
      *
      * $Id$
      *
      *-->

  <!--* Generate HTML 4 *-->
  <xsl:output method="html" version="4.0" encoding="UTF-8" />

 <!--* strip white space from containers that don't have PCDATA in
     * them; this list may not be complete.
     * XSLT should have a way of doing this based on the DTD.
     *-->
 <xsl:strip-space elements="dict titlepage letter entry" />

 <!--**********************************************
     *
     * split the input into separate files at
     * titlepage
     * letter
     *-->

  <!--* first, a template to make an HTML head, given a title *-->
  <xsl:template name="htmlhead">
    <xsl:param name='title'/>
      <head>
	<title><xsl:value-of select="$title"/></title>
      </head>
  </xsl:template>

  <xsl:template match="dict">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="titlepage">
    <xt:document method="html" href="out/titlepage.html">
      <html>
	<xsl:call-template name="htmlhead">
	  <xsl:with-param name="title"><xsl:value-of select="./title"/></xsl:with-param>
	</xsl:call-template>
	<body bgcolor="#FFFAFA" text="#330000">
	  <xsl:apply-templates/>
	</body>
      </html>
    </xt:document>
  </xsl:template>

  <xsl:template match="titlepage/note">
  <blockquote>
    <xsl:apply-templates />
  </blockquote>
  </xsl:template>

  <!--* a letter has all the entries starting with that letter *-->
  <xsl:template match="letter">
    <xt:document method="html" href="out/letter{@name}.html">
      <html>
	<xsl:call-template name="htmlhead">
	  <xsl:with-param name="title"><xsl:value-of select="./title"/></xsl:with-param>
	</xsl:call-template>
	<body bgcolor="#FFFAFA" text="#330000">
	  <xsl:apply-templates/>
	</body>
      </html>
    </xt:document>
  </xsl:template>

  <!--* unwanted elements *-->
  <xsl:template match="target"></xsl:template>


  <!--* block elements *-->
  <xsl:template match="p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="letter/title">
    <h1>The Letter <xsl:apply-templates/></h1>
  </xsl:template>

  <xsl:template match="title">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>

  <xsl:template match="blockquote">
    <blockquote><xsl:apply-templates/></blockquote>
  </xsl:template>

  <xsl:template match="entry">
  <div class="entry">
    <xsl:apply-templates/>
  </div>
  </xsl:template>


  <!--* inline elements *-->
  <xsl:template match="i|b|sub|sup">
    <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
    <xsl:value-of select="name()" />
    <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
      <xsl:apply-templates/>
    <xsl:text disable-output-escaping="yes">&lt;/</xsl:text>
    <xsl:value-of select="name()" />
    <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
  </xsl:template>

  <xsl:template match="eg">
    <i class="eg"><xsl:apply-templates/></i>
  </xsl:template>

  <!--* turn italic off *-->
  <xsl:template match="interj">
    <xsl:text disable-output-escaping="yes">&lt;/i&gt;</xsl:text>
      <xsl:apply-templates/>
    <xsl:text disable-output-escaping="yes">&lt;i&gt;</xsl:text>
  </xsl:template>

  <xsl:template match="meaning">
    <span class="meaning"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="xref">
    <span style="color: #33CC33;"><u><xsl:apply-templates/></u></span>
  </xsl:template>


</xsl:stylesheet>
