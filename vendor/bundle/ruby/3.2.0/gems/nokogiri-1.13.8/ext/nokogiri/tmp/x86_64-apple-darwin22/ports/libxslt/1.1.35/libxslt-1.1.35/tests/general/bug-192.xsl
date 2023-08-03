<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
  xmlns:func='http://exslt.org/functions'
  xmlns:foo='http://foo.com/'
  extension-element-prefixes='func'
 >
<xsl:output method="text" />

<!-- $func-value should have the value 'success!' but instead reports an 
empty string -->
<xsl:variable name="func-value" select="foo:get-value()" />
<xsl:variable name="dummy-value" select="$func-value" />
<xsl:variable name="template-value">
   <xsl:call-template name="get-dummy" />
</xsl:variable>

<func:function name="foo:get-value">
   <func:result>success!</func:result>
</func:function>

<xsl:template name="get-dummy">
   <xsl:value-of select="$dummy-value" />
</xsl:template>

<xsl:template match="/">
   <xsl:text>assert 'success!' == '</xsl:text>
   <xsl:value-of select="$func-value" />
   <xsl:text>'
</xsl:text>
</xsl:template>

</xsl:stylesheet>
