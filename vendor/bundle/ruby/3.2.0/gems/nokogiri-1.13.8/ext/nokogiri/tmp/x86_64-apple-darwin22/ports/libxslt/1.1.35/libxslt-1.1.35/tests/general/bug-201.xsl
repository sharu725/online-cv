<xsl:stylesheet
    version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:func="http://exslt.org/functions"
    xmlns:test="test"
    extension-element-prefixes="func">

<func:function name="test:func">
    <xsl:param name="var" select="test:func()"/>
    <func:result select="$var"/>
</func:function>

<xsl:template match="/">
    <xsl:copy-of select="test:func()"/>
</xsl:template>

</xsl:stylesheet>
