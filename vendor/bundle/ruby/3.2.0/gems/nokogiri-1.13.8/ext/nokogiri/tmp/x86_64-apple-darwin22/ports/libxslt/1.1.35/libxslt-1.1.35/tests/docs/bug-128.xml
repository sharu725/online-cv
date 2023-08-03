<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:test="http://www.example.org/test">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:key name="k" match="test:a" use="@a"/>
  <xsl:key name="k" match="test:b" use="@b"/>
  <xsl:key name="k" match="test.a" use="@a"/>

  <xsl:template match="/">
    <test:data>
      <xsl:for-each select="key('k','1')">
        <xsl:copy-of select="."/>
      </xsl:for-each>
    </test:data>
  </xsl:template>

  <xsl:template match="text()|@*"/>

  <test:data>
    <test:a a="1"/>
    <test:b b="1"/>
  </test:data>
</xsl:stylesheet>

