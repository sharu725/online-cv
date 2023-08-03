<?xml version="1.0"?>

<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:func="http://exslt.org/functions"
    xmlns:test="test"
    extension-element-prefixes="func"
>
    <func:function name="test:fragment">
        <func:result>
            <a>
                <b/>
            </a>
        </func:result>
    </func:function>

    <func:function name="test:func1">
        <xsl:variable name="var" select="test:fragment()"/>
        <func:result select="$var"/>
    </func:function>

    <func:function name="test:func2">
        <xsl:variable name="var" select="test:func1()"/>
        <func:result select="$var"/>
    </func:function>

    <xsl:template match="/">
        <xsl:copy-of select="test:func2()"/>
    </xsl:template>
</xsl:stylesheet>

