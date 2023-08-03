<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">

<xsl:output method="text"/>
<xsl:strip-space elements="*"/>

<xsl:template match="sum">
sum    : <xsl:apply-templates select="date"/>
result : <xsl:value-of select="date:sum(date/@dur)"/>
</xsl:template>

<xsl:template match="date">
  <xsl:if test="position() != 1"> + </xsl:if>
  <xsl:value-of select="@dur"/>
</xsl:template>

</xsl:stylesheet>
