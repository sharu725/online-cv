<?xml version="1.0"?>
<!-- 
	win32/defgen.xsl
	This stylesheet is used to transform doc/lib[e]xslt-api.xml into a pseudo-source,
	which can then be preprocessed to get the .DEF file for the Microsoft's linker.
	
	Use any XSLT processor to produce a file called lib[e]xslt.def.src in the win32
	subdirectory, for example, run xsltproc from the win32 subdirectory:
	
	  xsltproc -o libxslt.def.src defgen.xsl ../doc/libxslt-api.xml
	  xsltproc -o libexslt.def.src defgen.xsl ../doc/libexslt-api.xml
	  
	Once that finishes, rest assured, the Makefile will know what to do with the
	generated file. 

	May 2003, Igor Zlatkovic <igor@zlatkovic.com>
-->
<!DOCTYPE xsl:stylesheet [ <!ENTITY nl '&#xd;&#xa;'> ]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:strip-space elements="*"/>
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:text>LIBRARY </xsl:text>
		<xsl:value-of select="/api/@name"/>
		<xsl:text>&nl;</xsl:text>
		<xsl:text>EXPORTS&nl;</xsl:text>
		<xsl:for-each select="/api/symbols/*[self::variable or self::function]">
			<xsl:if test="@name='xsltExtFunctionLookup' or 
					@name='xsltMatchPattern'">
				<xsl:text>/*</xsl:text>
			</xsl:if>
			<xsl:value-of select="@name"/>
			<xsl:if test="self::variable">
				<xsl:text> DATA</xsl:text>
			</xsl:if>
			<xsl:if test="@name='xsltExtFunctionLookup' or 
					@name='xsltMatchPattern'">
				<xsl:text>*/</xsl:text>
			</xsl:if>
			<xsl:text>&nl;</xsl:text>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>

