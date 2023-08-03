<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
<xsl:template match="/">
  <xsl:apply-templates select="//page"/>
</xsl:template>

<xsl:template match="page">

current page : <xsl:value-of select="@name"/>
--------------------
  dump union : "<xsl:for-each
select="(preceding-sibling::page[1]|parent::group[1]|/document)">
    <xsl:value-of select="name()"/>,</xsl:for-each>"
  union-last : <xsl:value-of select="name(
(preceding-sibling::page[1]|parent::group[1]|/document)[last()] )"/>
  union-last (without /root) : <xsl:value-of select="name(
(preceding-sibling::page[1]|parent::group[1])[last()] )"/>
  preceeding-sibling <xsl:value-of select="name(preceding-sibling::page[1])"/>
  parent-group <xsl:value-of select="name(parent::group[1])"/>
  root <xsl:value-of select="name(/document)"/>
-----------------------
</xsl:template>

</xsl:stylesheet>
