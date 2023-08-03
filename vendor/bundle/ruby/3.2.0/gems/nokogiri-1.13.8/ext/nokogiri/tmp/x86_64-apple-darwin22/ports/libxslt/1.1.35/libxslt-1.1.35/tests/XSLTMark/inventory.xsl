<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output encoding="utf-8"/>

<xsl:template match="tr">
  <xsl:choose>
    <xsl:when test='td[@colspan="2"]'/>
    <xsl:otherwise>
      <item>
        <name><xsl:value-of select="td[1]"/></name>
        <quantity><xsl:value-of select="td[2]"/></quantity>
      </item>
      <xsl:apply-templates select="following-sibling::tr[1]"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<xsl:template match="table">
  <xsl:for-each select='tr[td[1][@colspan="2"]]'>
    <factory>
      <name><xsl:value-of select="td[1]"/></name>
      <inventory>
        <xsl:apply-templates select="following-sibling::tr[1]"/>
      </inventory>
    </factory>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>



