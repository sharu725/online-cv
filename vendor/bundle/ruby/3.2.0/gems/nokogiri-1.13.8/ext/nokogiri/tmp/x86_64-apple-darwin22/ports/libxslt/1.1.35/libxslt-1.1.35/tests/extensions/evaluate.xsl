<?xml version='1.0'?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://icl.com/saxon"
  version='1.0'>

<xsl:variable name="expression" select="saxon:expression('doc/two')"/>
  
  <xsl:template match="/">
    <xsl:variable name="string">doc/one</xsl:variable>
    <xsl:value-of select="saxon:evaluate($string)"/>
    <xsl:value-of select="count(saxon:evaluate('/doc/one')/../*)"/>
    <xsl:value-of select="saxon:evaluate(/doc/three)"/>
    <xsl:value-of select="saxon:eval($expression)"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="four">
    <xsl:variable name="string">doc/one</xsl:variable>
    <xsl:value-of select="saxon:evaluate($string)"/>
    <xsl:value-of select="saxon:eval($expression)"/>
  </xsl:template>
  
  <xsl:template match="text()"/>

</xsl:stylesheet>
