<?xml version = "1.0" encoding = "UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:variable name="ACTIONgrid" select="//GROUP[@type='REC' and not(@name=preceding::GROUP[@type='REC']/@name)]/@name"/>
<xsl:template match='/'>
		<html>
			<head>
				<title>Churn by Product</title>
				<style type="text/css">	.PROD {background-color:cyan}
	.PROD * {background-color:cyan}
	.ACT {background-color:green;font-weight:bold}
	.ACT * {background-color:green;font-weight:bold}
	.NR {background-color:yellow;color:blue}
	.NR * {background-color:yellow;color:blue}
	.RC {background-color:yellow;color:red}
	.RC * {background-color:yellow;color:red}

				</style>
			</head>
			<body>
				<h1><center>Churn by Product</center></h1>
				<table width="100%">
					<tr>
						<td width="50%" align="left" valign="top">
							Run Date: <xsl:value-of select="XMLDATA/RUNDATE"/><br/>
							Parameters:
						</td>
						<td align="right" valign="top">
							<table><tr><th>Legend</th></tr><tr class="PROD"><td>Product</td></tr>
<tr class="ACT"><td>Action</td></tr>
<tr class="NR"><td>Non-Recurring</td></tr>
<tr class="RC"><td>Recurring</td></tr>

							</table>
						</td>
					</tr>
				</table>
				<table align="center"><xsl:apply-templates select="/XMLDATA/GROUP"/></table>
			</body>
		</html>
	</xsl:template><xsl:template match="GROUP[@type='PRODUCT']">
		<tr>
<xsl:attribute name="class">
PROD
</xsl:attribute>

			<td><xsl:value-of select='.//ROW[1]/PRODUCT'/></td>
			<td>Proj. Rev: <xsl:value-of select='sum(.//ROW/PREV)'/></td>
			<td>Actual Rev: <xsl:value-of select='sum(.//ROW/AREV)'/></td>
		</tr>
		<xsl:apply-templates select='GROUP'/>
		<tr>
<xsl:attribute name="class">
PROD
</xsl:attribute>

		</tr>
</xsl:template>

<xsl:template match="GROUP[@type='ACTION']">
	<xsl:variable name='grp' select='.'/>
		<tr>
<xsl:attribute name="class">
ACT
</xsl:attribute>

			<td><xsl:value-of select='.//ROW[1]/ACTION'/></td>
			<td>Proj. Rev: <xsl:value-of select='sum(.//ROW/PREV)'/></td>
			<td>Act. Rev: <xsl:value-of select='sum(.//ROW/AREV)'/></td>
		</tr>
		<tr>
				<xsl:for-each select='$ACTIONgrid'>
				<xsl:sort select='.'/>
				<td valign='top'>
					<xsl:apply-templates select='$grp/GROUP[@name=current()]'/>
				</td>
				</xsl:for-each>
		</tr>
		<tr>
<xsl:attribute name="class">
ACT
</xsl:attribute>

		</tr>
</xsl:template>

<xsl:template match="GROUP[@type='REC']">
	<table>
		<tr>
<xsl:attribute name="class">

						<xsl:choose>
							<xsl:when test="@name='Recurring'">RC</xsl:when>
							<xsl:otherwise>NR</xsl:otherwise>
						</xsl:choose>
					
</xsl:attribute>

			<td><xsl:value-of select='.//ROW[1]/REC'/></td>
			<td>Number: <xsl:value-of select='sum(.//ROW/NUM)'/></td>
			<td>Proj. Rev: <xsl:value-of select='sum(.//ROW/PREV)'/></td>
			<td>Act. Rev: <xsl:value-of select='sum(.//ROW/AREV)'/></td>
		</tr>
		<tr>
			<td>Segment</td>
			<td>Number</td>
			<td>Proj. Rev</td>
			<td>Act. Rev</td>
		</tr>
		<xsl:apply-templates select='ROW'/>
		<tr>
<xsl:attribute name="class">

						<xsl:choose>
							<xsl:when test="@name='Recurring'">RC</xsl:when>
							<xsl:otherwise>NR</xsl:otherwise>
						</xsl:choose>
					
</xsl:attribute>

		</tr>
	</table>
</xsl:template>


<xsl:template match='ROW'>
	<tr>

		<xsl:apply-templates select='SEGMENT'/>
		<xsl:apply-templates select='NUM'/>
		<xsl:apply-templates select='PREV'/>
		<xsl:apply-templates select='AREV'/>
	</tr>
</xsl:template>

<xsl:template match='SEGMENT'>
	<td>
		<xsl:value-of select='.'/>
	</td>
</xsl:template>

<xsl:template match='NUM'>
	<td>
		<xsl:value-of select='.'/>
	</td>
</xsl:template>

<xsl:template match='PREV'>
	<td>
		<xsl:value-of select='.'/>
	</td>
</xsl:template>

<xsl:template match='AREV'>
	<td>
		<xsl:value-of select='.'/>
	</td>
</xsl:template>
</xsl:stylesheet>
