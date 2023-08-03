<?xml version="1.0"?>

<xsl:transform
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl">

  <xsl:template match="@*|node()" mode="copy">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="copy"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/">
    <xsl:variable name="v">
      <xsl:apply-templates mode="copy"/>
    </xsl:variable>
    <xsl:apply-templates select="exsl:node-set($v)" mode="copy"/>
<!-- replacing the above line with the following one increases speed -->
<!-- <xsl:apply-templates select="." mode="copy"/> -->
  </xsl:template>

<!-- removing the following line increases the speed -->
  <xsl:key name="tree-by-subject_id" match="tree" use="@subject_id"/>

</xsl:transform>



