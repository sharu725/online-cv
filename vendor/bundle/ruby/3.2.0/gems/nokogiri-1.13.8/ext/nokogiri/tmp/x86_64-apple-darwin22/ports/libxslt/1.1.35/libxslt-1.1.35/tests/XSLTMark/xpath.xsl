<?xml version="1.0"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 
<xsl:output encoding="utf-8"/>

<xsl:template match="top">
    <TOP>
        <xsl:apply-templates/>
    </TOP>
</xsl:template>

<xsl:template match="bar[baz or following-sibling::*[1][self::nar]]">
    <BAR><xsl:value-of select="."/></BAR>
</xsl:template>

<xsl:template match="foo[following-sibling::*[position()&lt;=2][self::barg] and
                         following-sibling::*[position()&lt;=2][self::nar]]">
    <FOO><xsl:value-of select="."/></FOO>
</xsl:template>
</xsl:stylesheet>


















