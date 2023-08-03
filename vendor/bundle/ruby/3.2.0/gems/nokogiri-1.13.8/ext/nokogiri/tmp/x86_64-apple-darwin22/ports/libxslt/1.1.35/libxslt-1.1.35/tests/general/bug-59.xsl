<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     version="1.0">

<xsl:template match="*">
        <xsl:value-of select="@attribute"/>
</xsl:template>

</xsl:stylesheet>
