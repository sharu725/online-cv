<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
                version="1.0"> 
<xsl:output method = "text" />
<xsl:template match = "/" >
    <xsl:apply-templates select = "//AAA" />
</xsl:template>

<xsl:template match = "*" >
    <xsl:number level = "multiple"/>
    <xsl:text > AAA
    </xsl:text>
</xsl:template>
</xsl:stylesheet>
