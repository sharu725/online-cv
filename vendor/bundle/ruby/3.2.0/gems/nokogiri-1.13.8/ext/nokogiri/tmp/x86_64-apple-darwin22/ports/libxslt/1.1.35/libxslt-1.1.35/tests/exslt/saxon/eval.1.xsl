<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://icl.com/saxon"
    exclude-result-prefixes="saxon">

<xsl:output indent="yes"/>

<xsl:template match="expressions">
    <results>
        <xsl:apply-templates select="*"/>
    </results>
</xsl:template>

<xsl:template match="expression">
    <result>
        <xsl:value-of select="saxon:eval(saxon:expression(.))"/>
    </result>
</xsl:template>

</xsl:stylesheet>

