<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml"/>
  <xsl:template match="message">
    <xsl:variable name="foo">foo</xsl:variable>
    <ROOT>
      <ELEMENT1>
        <xsl:variable name="test-var">
          <xsl:call-template name="test1"/>
	  <xsl:value-of select="$foo"/>
        </xsl:variable>
        <xsl:value-of select="$test-var"/>
	<hello/>
      </ELEMENT1>
      <ELEMENT2>
        <xsl:variable name="test-var">
          <xsl:call-template name="test2"/>
	  <xsl:value-of select="$foo"/>
        </xsl:variable>
        <xsl:value-of select="$test-var"/>
	<hello/>
      </ELEMENT2>
    </ROOT>
  </xsl:template>
  <xsl:template name="test1">
Some result
</xsl:template>
  <xsl:template name="test2">
other one
</xsl:template>
</xsl:stylesheet>
