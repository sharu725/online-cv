<?xml version="1.0"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output encoding="utf-8"/>

<xsl:template match='top/*[1]'>
    <A><xsl:value-of select="."/></A>
</xsl:template>

<xsl:template match='top/*[6]/kid[2]'>
    <D><xsl:value-of select="."/></D>
</xsl:template>


<xsl:template match='top/*[position()=2]'>
    <B><xsl:value-of select="."/></B>
</xsl:template>

<xsl:template match='top/*[position()=3]'>
    <C><xsl:value-of select="."/></C>
</xsl:template>

<!-- bug in jclark's xt: "last()=position()" doesn't equal "position()=last()" -->

<xsl:template match='top/*[position()=last()]'>
    <LAST><xsl:value-of select="."/></LAST>
</xsl:template>

<xsl:template match='top' priority="1">
    <TOP>
       <xsl:apply-templates/>
    </TOP>
</xsl:template>
    
</xsl:stylesheet>

