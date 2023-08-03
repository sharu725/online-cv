<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	      version="1.0">

<xsl:template match="AAA[Title='foo']//BBB">
  <xsl:text>success</xsl:text>
</xsl:template>
<xsl:template match="Title">
</xsl:template>

</xsl:stylesheet>



