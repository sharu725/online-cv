<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes" encoding="ISO-8859-1"/>
  <xsl:variable name="two">abcde</xsl:variable>
  <xsl:template match="*">
    <xsl:value-of select="translate('hello','ABCDE',$one)"/>
  </xsl:template>
</xsl:stylesheet>
