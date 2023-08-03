<?xml version="1.0"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output encoding="utf-8"/>

<xsl:template match='*[starts-with(.,"a")]'>
    <A><xsl:value-of select="."/></A><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match='*[starts-with(substring(.,string-length(.)),"b")]'>
    <B><xsl:value-of select="."/></B><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="top">
    <TOP><xsl:text>
</xsl:text>
       <xsl:apply-templates select='*[starts-with(.,"a")]|*[starts-with(substring(.,string-length(.)),"b")]'/>
    </TOP>
</xsl:template>



</xsl:stylesheet>

