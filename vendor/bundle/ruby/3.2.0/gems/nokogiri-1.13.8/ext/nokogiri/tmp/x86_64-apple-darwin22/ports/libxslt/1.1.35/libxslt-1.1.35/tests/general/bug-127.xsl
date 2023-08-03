<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
>

<xsl:output method="html"/>

<xsl:variable name='var'>"'"</xsl:variable>

<xsl:template match="/">
<html>
<body>
<input type="text" value="{$var}"/>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
