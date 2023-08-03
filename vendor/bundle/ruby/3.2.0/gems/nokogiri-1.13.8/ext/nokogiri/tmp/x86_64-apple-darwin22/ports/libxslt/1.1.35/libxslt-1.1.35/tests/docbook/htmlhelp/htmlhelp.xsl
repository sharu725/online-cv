<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
		version="1.0"
                exclude-result-prefixes="doc">

<xsl:import href="../html/chunk.xsl"/>
<xsl:include href="htmlhelp-common.xsl"/>

<xsl:template name="write.text.chunk">
  <xsl:param name="filename" select="''"/>
  <xsl:param name="method" select="'text'"/>
  <xsl:param name="content" select="''"/>
  <xsl:param name="encoding" select="'iso-8859-1'"/>
  <xsl:call-template name="write.chunk">
    <xsl:with-param name="filename" select="$filename"/>
    <xsl:with-param name="method" select="$method"/>
    <xsl:with-param name="content" select="$content"/>
    <xsl:with-param name="encoding" select="$encoding"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
