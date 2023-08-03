<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:key name="aaa" match="/bbb" use="./ccc"/>
  <xsl:template match="*">
    <xsl:for-each select="namespace::*[position()=2]">
      <xsl:number from="key('e','f')"/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
