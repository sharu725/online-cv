<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:func = "http://exslt.org/functions"
	version="1.0" extension-element-prefixes="func">

<func:function name="func:uaf">
	<xsl:text/>
	<func:result/>
</func:function>

<xsl:template match="/">
        <result>
	        <xsl:value-of select="func:uaf()"/>
        </result>
</xsl:template>

</xsl:stylesheet>

