<?xml version='1.0'?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:a="http://a">

<xsl:template match="*">
 <xsl:element name="{name()}"/>
</xsl:template>

</xsl:stylesheet>
