<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:output method='text'/>

<xsl:template match="/">
  <xsl:variable name="id1" select="generate-id(/root/elem)"/>
  <xsl:variable name="id2" select="generate-id(id('id0'))"/>
  <xsl:if test="$id1 = $id2">
    <xsl:text>SUCCESS
</xsl:text>
  </xsl:if>
  <xsl:if test="$id1 != $id2">
    <xsl:text>ERROR
</xsl:text>
  </xsl:if>
</xsl:template>
</xsl:stylesheet>

