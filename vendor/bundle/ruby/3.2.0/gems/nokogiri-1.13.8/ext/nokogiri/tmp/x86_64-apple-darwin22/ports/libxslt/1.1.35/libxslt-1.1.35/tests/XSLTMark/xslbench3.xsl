<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="utf-8"/>

<xsl:template match="PLAY">
<html>
	<head>
		<title>
			<xsl:value-of select="/PLAY/TITLE"/>
		</title>
	</head>
<body>
	<h1><xsl:value-of select="/PLAY/TITLE"/></h1>

	<table>
	<xsl:for-each select="//ACT">
		<xsl:variable name="act" select="TITLE"/>
		<xsl:for-each select="SCENE">
			<xsl:value-of select="concat($act,' - ',TITLE,'   ')"/>
			Has <xsl:value-of select="count(.//SPEECH)"/> speeches
			with an average of <xsl:value-of select="round(count(.//LINE) div count(.//SPEECH))"/>
			line(s) each.
			<br/>
		</xsl:for-each>
	</xsl:for-each>
	</table>
	
</body>
</html>
</xsl:template>

</xsl:stylesheet>
