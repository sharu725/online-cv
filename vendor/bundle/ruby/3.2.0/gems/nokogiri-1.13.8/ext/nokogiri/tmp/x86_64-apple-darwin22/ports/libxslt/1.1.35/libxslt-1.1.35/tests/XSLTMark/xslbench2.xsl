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
	<xsl:apply-templates select="FM|PERSONAE|ACT"/>
</body>
</html></xsl:template>

<xsl:template match="FM"><i><xsl:apply-templates/></i></xsl:template>

<xsl:template match="PERSONAE"><h2>Parts - <xsl:value-of select="TITLE"/></h2>
<xsl:apply-templates select=".//PERSONA" />
</xsl:template>

<xsl:template match="PERSONA"><p><b><i><xsl:value-of select="."/></i></b></p></xsl:template>

<xsl:template match="ACT"><h3><xsl:value-of select="TITLE"/></h3>
<xsl:apply-templates select="SCENE"/>
</xsl:template>

<xsl:template match="SCENE"><h3><xsl:value-of select="TITLE"/></h3>
<xsl:apply-templates select="SPEECH"/></xsl:template>

<xsl:template match="SPEAKER"><p><b><xsl:value-of select="."/></b></p></xsl:template>

<xsl:template match="LINE"><xsl:value-of select="."/><br/></xsl:template>

</xsl:stylesheet>
