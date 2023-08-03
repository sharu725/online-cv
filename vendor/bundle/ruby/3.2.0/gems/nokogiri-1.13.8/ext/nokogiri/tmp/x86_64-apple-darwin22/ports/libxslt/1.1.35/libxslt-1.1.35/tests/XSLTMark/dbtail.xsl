<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output encoding="utf-8"/>

<xsl:template match="table">
  <document>
    <xsl:apply-templates select="row[1]"/>
  </document>
</xsl:template>

<xsl:template match="row">
  <row>
    <first>
      <xsl:value-of select="firstname"/>
    </first>
    <last>
      <xsl:value-of select="lastname"/>
    </last>
  </row>
  <xsl:apply-templates select="following-sibling::row[1]"/>
</xsl:template>

</xsl:stylesheet>
