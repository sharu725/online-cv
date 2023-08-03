<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.1"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:foo="http://borland.com/bogus">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
    <xsl:for-each select="/sample/foo">
        <xsl:element name="foo:whatever">
          <xsl:value-of select="@name"/>
        </xsl:element>
    </xsl:for-each>
    </html>
  </xsl:template>
</xsl:stylesheet>
