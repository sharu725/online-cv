<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	    encoding="iso-8859-1"
	    indent="yes"/>

<xsl:template match="/">
  <xsl:message terminate="no">A simple message</xsl:message>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="root|node">
  <xsl:message terminate="yes">A fatal message</xsl:message>
</xsl:template>

</xsl:stylesheet>
