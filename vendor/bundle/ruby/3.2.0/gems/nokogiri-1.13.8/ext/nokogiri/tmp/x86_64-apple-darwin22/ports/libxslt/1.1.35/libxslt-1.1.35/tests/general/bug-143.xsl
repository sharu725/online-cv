<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="foo">foo</xsl:variable>
<xsl:variable name="bar">
  <foo bar="0{$foo}1">foo1</foo>
</xsl:variable>
<xsl:template match="/">
  <xsl:copy-of select="$bar"/>
</xsl:template>
</xsl:stylesheet>
