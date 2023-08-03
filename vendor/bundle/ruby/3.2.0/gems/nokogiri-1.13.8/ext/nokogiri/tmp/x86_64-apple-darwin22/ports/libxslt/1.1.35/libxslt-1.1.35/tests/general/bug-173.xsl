<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output indent="no" omit-xml-declaration="yes"/>

<xsl:template match="/">
  <!-- Output should not include extraneous newlines when indent is off -->
  <xsl:comment>Comment</xsl:comment>
  <root/>
</xsl:template>

</xsl:stylesheet>