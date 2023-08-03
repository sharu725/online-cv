<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
<xsl:output encoding="iso-8859-1" method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="DTD/xhtml1-strict.dtd"/>
<xsl:template match="page">
<html xml:lang="en" lang="en">
<head>
<title>
	<xsl:value-of select="@title"/>
</title>
<link rel="stylesheet" href="bredfort.css" type="text/css" title="bredfort"/>
</head>
<body>
<xsl:apply-templates select="document('menu.xml')"/>
<h1>
	<xsl:value-of select="@title"/>
</h1>
<xsl:apply-templates/>
</body>
</html>
</xsl:template>

<xsl:template match="h2">
<h2>
	<xsl:apply-templates/>
</h2>
</xsl:template>

<xsl:template match="menu">
<table class="menu">
<tr>
<xsl:apply-templates/>
</tr>
</table>
</xsl:template>

<xsl:template match="menuitem">
<td class="menu">
	<a><xsl:attribute name="href">
		<xsl:value-of select="@href"/>
	</xsl:attribute>
	<xsl:apply-templates/>
	</a>
</td>
</xsl:template>

<xsl:template match="week">
<hr class="thin"/>
<h2>Week <xsl:value-of select="@num"/></h2>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="what">
<xsl:apply-templates/>
<p class="who">
	<xsl:value-of select="@who"/>
</p>
</xsl:template>


<xsl:template match="p">
<p> <xsl:apply-templates/> </p>
</xsl:template>

<xsl:template match="a">
<a><xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
	<xsl:apply-templates/> </a>
</xsl:template>


<xsl:template match="st">
<td class="progress"><xsl:apply-templates/>%</td>
</xsl:template>


<xsl:template match="progresstable">
<table border="2" class="progress">
<tr>
	<th class="progress">Week</th>
	<th class="progress">Sys. des.</th>
	<th class="progress">Test des.</th>
	<th class="progress">Sales cli.</th>
	<th class="progress">Adm. cli.</th>
	<th class="progress">Proxy</th>
	<th class="progress">Sale serv.</th>
	<th class="progress">Fac. serv.</th>
	<th class="progress">Comp. test</th>
	<th class="progress">Func. test</th>
	<th class="progress">Syst. test</th>
</tr>
<xsl:apply-templates select="progress"/>
</table>
</xsl:template>



<xsl:template match="progress">
<tr> 
<td class="progress"><xsl:value-of select="@week"/></td>
<xsl:apply-templates/> 
</tr>
</xsl:template>


</xsl:stylesheet>
