<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://icl.com/saxon"
    exclude-result-prefixes="saxon">

<xsl:output indent="yes"/>

<xsl:template match="/">
    <results>
        <xsl:value-of select="true() and saxon:eval(saxon:expression('ns:foo'))"/>
    </results>
</xsl:template>

</xsl:stylesheet>

