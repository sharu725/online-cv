<xsl:stylesheet version="1.0"
	      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	      xmlns="http://www.w3.org/TR/xhtml1/strict">

<xsl:strip-space elements="doc chapter section"/>
<xsl:output
 method="xml"
 indent="yes"
 encoding="iso-8859-1"
/>

<xsl:template match="doc">
<html>
 <head>
   <title>
     <xsl:value-of select="title"/>
   </title>
 </head>
 <body>
   <xsl:apply-templates/>
 </body>
</html>
</xsl:template>

<xsl:template match="doc/title">
<h1>
  <xsl:apply-templates/>
</h1>
</xsl:template>

<xsl:template match="chapter/title">
<h2>
  <xsl:apply-templates/>
</h2>
</xsl:template>

<xsl:template match="section/title">
<h3>
  <xsl:apply-templates/>
</h3>
</xsl:template>

<xsl:template match="para">
<p>
  <xsl:apply-templates/>
</p>
</xsl:template>

<xsl:template match="note">
<p class="note">
  <b>NOTE: </b>
  <xsl:apply-templates/>
</p>
</xsl:template>

<xsl:template match="emph">
<em>
  <xsl:apply-templates/>
</em>
</xsl:template>

</xsl:stylesheet>
