<xsl:stylesheet version="1.0"
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              xmlns:func="http://exslt.org/functions"
              xmlns:a="a"
              extension-element-prefixes="func">
<xsl:output method="text" encoding="UTF-8"/>

<func:function name="a:a">
  <func:result>
    <xsl:apply-templates mode="a"/>
  </func:result>
</func:function>

<xsl:template mode="a" match="node()">
  <xsl:text>a</xsl:text>
</xsl:template>

<xsl:template match="/">
  <xsl:variable name="a" select="a:a()"/>
  <xsl:value-of select="$a"/>
  <xsl:text>,</xsl:text>
  <xsl:value-of select="$a"/>
  <xsl:text>&#x0a;</xsl:text>
</xsl:template>
</xsl:stylesheet>
