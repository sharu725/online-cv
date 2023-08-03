<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<xsl:template match="/">
  <root>
    <xsl:apply-templates />
  </root>
</xsl:template>

<xsl:template match="x">
  <xsl:text>Matched x template</xsl:text>
  <xsl:apply-templates />
</xsl:template>

<!-- Case 1: y=0.0 /*=0.0, even though /* should be 0.5 -->
<!-- works if split up to: 
<xsl:template match="/*"> or of course you reverse the order
so the y pattern is screwed instead
-->
<xsl:template match="y|/*">
  <xsl:text>Matched /* or y template</xsl:text>
  <xsl:apply-templates />
</xsl:template>

<!--
Case 2: Here, both should have 5.0 priority but /* seems to have 0.0!
<xsl:template match="y|/*" priority="5.0">
  <xsl:text>Matched /* or y template</xsl:text>
  <xsl:apply-templates />
</xsl:template>
-->

</xsl:stylesheet>
