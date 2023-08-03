<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
version="1.0"> 
 
        <xsl:template match="/"> 
                <xsl:apply-templates select="document('x1.xml')/foo"/> 
        </xsl:template> 
 
        <xsl:template match="*|@*|text()"> 
                <xsl:copy><xsl:apply-templates select="*|@*| 
text()" /></xsl:copy> 
        </xsl:template> 
 
</xsl:stylesheet> 
