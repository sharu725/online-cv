<?xml version="1.0"?>
<xsl:stylesheet 
  version="1.1"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 >

<xsl:output encoding="us-ascii"/>

<xsl:template match="stuff">
    <xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
