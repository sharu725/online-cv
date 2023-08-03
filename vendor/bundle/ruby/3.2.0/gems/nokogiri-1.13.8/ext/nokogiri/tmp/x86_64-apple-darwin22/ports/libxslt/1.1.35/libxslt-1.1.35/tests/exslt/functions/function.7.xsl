<?xml version="1.0"?> <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0" xmlns:my="my://own.uri">
<xsl:import href="function.1.xsl"/>

<xsl:template match="/">
  <out>
    <xsl:value-of select="my:count-elements()"/>
  </out>
</xsl:template>

</xsl:stylesheet>


