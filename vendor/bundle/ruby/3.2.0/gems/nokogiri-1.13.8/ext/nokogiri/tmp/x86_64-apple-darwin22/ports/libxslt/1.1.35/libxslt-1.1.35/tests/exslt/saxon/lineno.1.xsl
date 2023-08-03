<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://icl.com/saxon"
    exclude-result-prefixes="saxon">

<xsl:output indent="yes"/>

<xsl:template match="/">
    <results>
        <lineno>
            <xsl:value-of select="saxon:line-number(/doc)"/>
        </lineno>
        <lineno>
            <xsl:value-of select="saxon:line-number(/doc/elem)"/>
        </lineno>
        <lineno>
            <xsl:value-of select="saxon:line-number(/doc/elem/namespace::*)"/>
        </lineno>
    </results>
</xsl:template>

</xsl:stylesheet>

