<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="doc">
<doc>
<xsl:attribute name="xmlns:xsl" namespace="whatever">http://www.w3.org/1999/XSL/Transform</xsl:attribute>
<xsl:attribute name="attr">value</xsl:attribute>
<!--
<xsl:attribute name="a">x
y</xsl:attribute>
-->
</doc>
</xsl:template>

</xsl:stylesheet>
