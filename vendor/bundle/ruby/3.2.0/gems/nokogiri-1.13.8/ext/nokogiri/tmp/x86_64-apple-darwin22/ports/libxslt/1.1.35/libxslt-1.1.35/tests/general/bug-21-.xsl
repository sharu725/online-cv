<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
<xsl:template match="/doc">
  <xsl:value-of select="unparsed-entity-uri(string(@attr))"/>
</xsl:template>
</xsl:stylesheet>
