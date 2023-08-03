<?xml version= "1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match = "/" > 
        <xsl:apply-templates select="//processing-instruction()"/> 
        <xsl:apply-templates select="//comment()"/> 
        <!-- xsl:apply-templates/--> 
</xsl:template> 

<xsl:template match = "processing-instruction()" > 
        <xsl:value-of select = "concat(name(),' : ',.)" /> 
</xsl:template> 

<xsl:template match = "comment()" > 
        <xsl:text>#########################
        </xsl:text> 
                <xsl:value-of select = "." /> 
        <xsl:text>
#########################</xsl:text> 
</xsl:template> 

</xsl:stylesheet>
