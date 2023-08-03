<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="bug-156.imp1.imp"/>

<xsl:template name="message">
  <xsl:message>From main</xsl:message>
  <xsl:apply-imports/>
</xsl:template>

</xsl:stylesheet>

