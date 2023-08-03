<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:func="http://exslt.org/functions"
    xmlns:my="my-namespace"
    extension-element-prefixes="exsl func">

<xsl:template match="/">
    <xsl:variable name="var">
        <var>value</var>
    </xsl:variable>
    <xsl:copy-of select="my:func($var)"/>
</xsl:template>

<func:function name="my:func">
    <xsl:param name="var"/>
    <func:result select="$var"/>
</func:function>

</xsl:stylesheet>
