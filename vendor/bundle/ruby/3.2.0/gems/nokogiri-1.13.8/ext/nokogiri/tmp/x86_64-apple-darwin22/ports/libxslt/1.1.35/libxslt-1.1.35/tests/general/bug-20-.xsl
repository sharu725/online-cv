<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0" > 

<xsl:output method = "text" /> 

<xsl:template match = "/" > 
        <xsl:apply-templates select = "//BBB" /> 
</xsl:template> 

<xsl:template match = "BBB" > 
        <xsl:text>
         BBB[</xsl:text> 
                                                                                   
<xsl:value-of select = "position()" /> 
                                                                                   
<xsl:text >]: </xsl:text> 
                                                                                   
<xsl:value-of select = "." /> 
</xsl:template> 

</xsl:stylesheet> 

