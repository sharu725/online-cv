<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:variable name="test">no value</xsl:variable>
<xsl:param name="test2">no value</xsl:param>
<xsl:template match="/">
<root>
  test: <xsl:value-of select="$test"/>
  test2: <xsl:value-of select="$test2"/>
</root>
</xsl:template>
</xsl:stylesheet>
