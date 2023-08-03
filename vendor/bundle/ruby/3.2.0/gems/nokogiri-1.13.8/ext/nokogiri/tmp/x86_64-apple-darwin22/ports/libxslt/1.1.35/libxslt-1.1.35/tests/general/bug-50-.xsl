<xsl:stylesheet version="1.0"
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              xmlns="http://www.w3.org/TR/xhtml1/strict"
              xmlns:tst="http://example.org/">

<xsl:template match="tst:doc|doc">
success
<xsl:text>name=</xsl:text>
<xsl:value-of select="name(.)"/>
<xsl:text>
local-name=</xsl:text>
<xsl:value-of select="local-name(.)"/>
</xsl:template>
</xsl:stylesheet>
