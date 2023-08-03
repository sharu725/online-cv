<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:func="http://exslt.org/functions" version="1.0" extension-element-prefixes="func">
  <func:function name="func:f">
    <xsl:for-each select="namespace::*">
      <xsl:sort/>
    </xsl:for-each>
    <func:result>10</func:result>
  </func:function>
  <xsl:template match="*">
    <xsl:value-of select="func:f()+count(abc)"/>
  </xsl:template>
</xsl:stylesheet>
