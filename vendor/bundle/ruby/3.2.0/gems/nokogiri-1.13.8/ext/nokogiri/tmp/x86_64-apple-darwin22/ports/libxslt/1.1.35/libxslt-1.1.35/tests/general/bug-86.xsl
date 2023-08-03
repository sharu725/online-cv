<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:vdv="http://eric.van-der-vlist.com/tmpns" version="1.0">
 <xsl:template match="/">
  <xsl:copy-of select="document('')/xsl:transform"/>
 </xsl:template>
</xsl:transform>
