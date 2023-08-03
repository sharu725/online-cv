<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://icl.com/saxon"
		xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
		xmlns:xt="http://www.jclark.com/xt"
		xmlns:libxslt="http://xmlsoft.org/XSLT/namespace"
                version='1.0'>

<xsl:template match="/">
<xsl:text> === 24 Standard elements:
</xsl:text>
<xsl:if test="element-available('xsl:apply-templates')">xsl:apply-templates available
</xsl:if>
<xsl:if test="element-available('xsl:apply-imports')">xsl:apply-imports available
</xsl:if>
<xsl:if test="element-available('xsl:call-template')">xsl:call-template available
</xsl:if>
<xsl:if test="element-available('xsl:element')">xsl:element available
</xsl:if>
<xsl:if test="element-available('xsl:attribute')">xsl:attribute available
</xsl:if>
<xsl:if test="element-available('xsl:text')">xsl:text available
</xsl:if>
<xsl:if test="element-available('xsl:processing-instruction')">xsl:processing-instruction available
</xsl:if>
<xsl:if test="element-available('xsl:comment')">xsl:comment available
</xsl:if>
<xsl:if test="element-available('xsl:copy')">xsl:copy available
</xsl:if>
<xsl:if test="element-available('xsl:value-of')">xsl:value-of available
</xsl:if>
<xsl:if test="element-available('xsl:number')">xsl:number available
</xsl:if>
<xsl:if test="element-available('xsl:for-each')">xsl:for-each available
</xsl:if>
<xsl:if test="element-available('xsl:if')">xsl:if available
</xsl:if>
<xsl:if test="element-available('xsl:choose')">xsl:choose available
</xsl:if>
<xsl:if test="element-available('xsl:sort')">xsl:sort available
</xsl:if>
<xsl:if test="element-available('xsl:copy-of')">xsl:copy-of available
</xsl:if>
<xsl:if test="element-available('xsl:message')">xsl:message available
</xsl:if>
<xsl:if test="element-available('xsl:variable')">xsl:variable available
</xsl:if>
<xsl:if test="element-available('xsl:param')">xsl:param available
</xsl:if>
<xsl:if test="element-available('xsl:with-param')">xsl:with-param available
</xsl:if>
<xsl:if test="element-available('xsl:decimal-format')">xsl:decimal-format available
</xsl:if>
<xsl:if test="element-available('xsl:when')">xsl:when available
</xsl:if>
<xsl:if test="element-available('xsl:otherwise')">xsl:otherwise available
</xsl:if>
<xsl:if test="element-available('xsl:fallback')">xsl:fallback available
</xsl:if>
<xsl:text> === 5 Extension elements:
</xsl:text>
<xsl:if test="element-available('xsl:element')">xsl:element available
</xsl:if>
<xsl:if test="element-available('saxon:output')">saxon:output available
</xsl:if>
<xsl:if test="element-available('xalanredirect:write')">xalanredirect:write available
</xsl:if>
<xsl:if test="element-available('xt:document')">xt:document available
</xsl:if>
<xsl:if test="element-available('libxslt:debug')">libxslt:debug available
</xsl:if>
<xsl:text> === 6 Extension functions:
</xsl:text>
<xsl:if test="function-available('libxslt:node-set')">libxslt:node-set() available
</xsl:if>
<xsl:if test="function-available('saxon:node-set')">saxon:node-set() available
</xsl:if>
<xsl:if test="function-available('xt:node-set')">xt:node-set() available
</xsl:if>
<xsl:if test="function-available('saxon:evaluate')">saxon:evaluate() available
</xsl:if>
<xsl:if test="function-available('saxon:expression')">saxon:expression() available
</xsl:if>
<xsl:if test="function-available('saxon:eval')">saxon:eval() available
</xsl:if>
</xsl:template>

</xsl:stylesheet>
