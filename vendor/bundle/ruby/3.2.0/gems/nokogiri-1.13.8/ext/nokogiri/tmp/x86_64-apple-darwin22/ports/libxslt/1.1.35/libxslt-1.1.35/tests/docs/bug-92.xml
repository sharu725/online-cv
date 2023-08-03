<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.0">

  <xsl:output method="xml" indent="yes" version="1.0"/>

  <xsl:template match="node()">
    <xsl:element name="toto">
      <xsl:attribute name="n">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>


  <xsl:template match="text()"/>
  <xsl:template match="comment()"/>
  <xsl:template match="processing-instruction()"/>
</xsl:stylesheet>
