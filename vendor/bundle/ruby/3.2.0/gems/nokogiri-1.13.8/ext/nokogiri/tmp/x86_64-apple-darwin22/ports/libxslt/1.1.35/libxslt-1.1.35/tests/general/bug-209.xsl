<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:func="http://exslt.org/functions"
    extension-element-prefixes="func">

    <xsl:template match="/">
        <xsl:variable name="v" select="func:a()" />
        <xsl:copy-of select="$v"/>
    </xsl:template>

    <func:function name="func:a">
        <func:result select="func:b()" />
    </func:function>

    <func:function name="func:b">
        <func:result>
            <result/>
        </func:result>
    </func:function>
</xsl:stylesheet>
