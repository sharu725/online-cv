<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:libxslt="http://xmlsoft.org/XSLT/namespace" exclude-result-prefixes="libxslt"  version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="one">
    <xsl:copy-of select="."/>
  </xsl:variable>
  <xsl:variable name="two" select="document('bug-65.ent')"/>
  <xsl:template match="/">
    <xsl:apply-templates select="$two" mode="two"/>
  </xsl:template>
  <xsl:template match="*" mode="two">
    <xsl:for-each select="//content">
      <xsl:apply-templates select="libxslt:node-set($one)" mode="one"/>
      <xsl:text>
-----------------
</xsl:text>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="*" mode="one">
    <xsl:for-each select="//content">
<!-- here is the problem (.//content works well, but I need the key 
			      function)-->
      <xsl:copy-of select="."/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
