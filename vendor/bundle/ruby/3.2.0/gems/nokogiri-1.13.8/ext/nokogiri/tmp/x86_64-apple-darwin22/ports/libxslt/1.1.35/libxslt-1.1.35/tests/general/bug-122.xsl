<?xml version="1.0" encoding="utf-8"?> 
 
<xsl:stylesheet version="1.0" 
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform" > 
 
<xsl:template match="doc"> 
        <xsl:variable name="node" select="."/> 
        <xsl:element name="Document" namespace="{namespace-uri(.)}"> 
                <xsl:for-each select="namespace::*"> 
                        <xsl:if test="string(.) != namespace-uri($node)"> 
                                <xsl:copy/> 
                        </xsl:if> 
                </xsl:for-each> 
        </xsl:element> 
</xsl:template> 
 
</xsl:stylesheet> 
