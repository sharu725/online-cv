<xsl:stylesheet version="1.0"
  xmlns:date="http://exslt.org/dates-and-times"
  exclude-result-prefixes="date"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes"/>
  <xsl:template match="/">
    <dates-and-times>
      <d><xsl:value-of select="date:add( '2001-01', 'P3D' )" /></d>
      <d><xsl:value-of select="date:add( '2001-02', 'P3D' )" /></d>
      <d><xsl:value-of select="date:add( '2001-12', 'P3D' )" /></d>
      <d><xsl:value-of select="date:add( '2001-12', 'P30D' )" /></d>
      <d><xsl:value-of select="date:add( '2001-12', 'P31D' )" /></d>
      <d><xsl:value-of select="date:add( '2001-12', 'P32D' )" /></d>
    </dates-and-times>
  </xsl:template>
</xsl:stylesheet>
