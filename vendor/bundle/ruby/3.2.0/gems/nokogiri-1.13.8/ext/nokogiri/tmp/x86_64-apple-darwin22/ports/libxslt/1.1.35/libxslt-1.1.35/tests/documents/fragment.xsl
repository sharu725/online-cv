<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<xsl:template match="/">
  <doc>
    <xsl:copy-of select="document('fragment2.xml#xpointer(//p[1])')"/>
  </doc>
</xsl:template>

</xsl:stylesheet>

