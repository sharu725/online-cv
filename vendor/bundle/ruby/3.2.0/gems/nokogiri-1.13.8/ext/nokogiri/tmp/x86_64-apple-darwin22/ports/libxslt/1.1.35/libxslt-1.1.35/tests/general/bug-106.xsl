<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" encoding="utf-8"/>

<xsl:template match="doc">
 <doc>
  <xsl:copy-of select="node()"/>
 </doc>
</xsl:template>

</xsl:stylesheet>
