<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="utf-8"/>
<xsl:template match="/">
  <summary>
    <total>
      <xsl:value-of select="count(//node())"/> nodes,
      <xsl:value-of select="count(//*)"/> elements,
      <xsl:value-of select="count(//text())"/> text nodes,
      <xsl:value-of select="count(//*/@*)"/> attributes.
    </total>

    <xsl:apply-templates/>

  </summary>

</xsl:template>


<xsl:template match="/xsl:stylesheet|/xsl:transform">
  <analysis>
    <description>Recognized as xslt stylesheet:</description>
    <stats>
      <xsl:value-of select="count(xsl:template)"/> templates,
      <xsl:value-of select="count(descendant::xsl:variable)"/> variables,
      <xsl:value-of select="count(descendant::xsl:value-of)"/> value-of's,
    </stats>
  </analysis>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>