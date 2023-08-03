<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:libxslt="http://xmlsoft.org/xslt/testplugin"
  xmlns:test="http://xmlsoft.org/xslt/testplugin"
  extension-element-prefixes="libxslt test"
  version='1.0'>
<!-- the prefix is registered twice to check single initialization -->
<xsl:template match="/">
<libxslt:testplugin/>
<xsl:value-of select="libxslt:testplugin('SUCCESS')"/>
</xsl:template>
</xsl:stylesheet>
