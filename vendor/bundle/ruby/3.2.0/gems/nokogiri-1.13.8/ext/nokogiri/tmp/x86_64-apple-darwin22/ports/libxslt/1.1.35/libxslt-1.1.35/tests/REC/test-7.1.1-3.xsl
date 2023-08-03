<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:doc="http://example.org/doc">

<doc:doc>Some ignored documentation the prefix should not show
         up on the doc element</doc:doc>
<xsl:template match="/">
<out xsl:exclude-result-prefixes="doc">SUCCESS</out>
</xsl:template>

</xsl:stylesheet>
