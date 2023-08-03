<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="no" version="1.0" encoding="iso-8859-1"/>
  <xsl:key name="monthlist" match="/list/month" use="./alias"/>
  <xsl:template match="month">
    <month>
      <xsl:variable name="value" select="."/>
      <xsl:for-each select="document('month.xml')">
        <xsl:value-of select="key('monthlist', $value)/alias[1]"/>
      </xsl:for-each>
    </month>
  </xsl:template>
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
