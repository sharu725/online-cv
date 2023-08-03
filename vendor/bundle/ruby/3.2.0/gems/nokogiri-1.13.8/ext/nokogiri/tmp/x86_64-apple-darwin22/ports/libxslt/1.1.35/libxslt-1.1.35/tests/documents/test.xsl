<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
         xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
         version="1.0">
<xsl:output method="text" encoding="iso-8859-1"/>

<xsl:template match="/files/file">
    <xsl:variable name="file" select="document(@name)"/>
        <xsl:if test="not($file)">
        <xsl:text>Can't Open File: </xsl:text>
        <xsl:value-of select="@name"/>
    </xsl:if>
    <xsl:value-of select="$file/tag1"/>
</xsl:template>

</xsl:stylesheet>
