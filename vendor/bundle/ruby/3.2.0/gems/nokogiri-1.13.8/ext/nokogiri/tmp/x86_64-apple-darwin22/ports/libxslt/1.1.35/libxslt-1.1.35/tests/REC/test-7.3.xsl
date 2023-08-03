<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="doc">
<doc>
<xsl:processing-instruction name="xml-stylesheet">href="book.css" type="text/css"</xsl:processing-instruction>
</doc>
</xsl:template>

</xsl:stylesheet>
