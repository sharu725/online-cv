<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
      <xsl:apply-templates select="ROOT"/>
</xsl:template>
<xsl:template match="ROOT">
      <xsl:for-each select="GROUP[position() != 1]/MEMBER[2]">
            <xsl:copy-of select="."/>
      </xsl:for-each>
</xsl:template>
</xsl:stylesheet>
