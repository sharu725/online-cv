<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:func = "http://exslt.org/functions" extension-element-prefixes="func"
  xmlns:my="my://own.uri">

<func:function name="my:count-elements">
<xsl:for-each select="(//*)[1]">
   <func:result select="count(//*)"/>
   </xsl:for-each>
</func:function>

  <xsl:template match="/">
    <out>
      <xsl:value-of select="my:count-elements()"/>
    </out>
  </xsl:template>

</xsl:stylesheet>
