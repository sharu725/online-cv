<?xml version='1.0' encoding='utf-8'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ns1="http://www.example.com/ns1"
		exclude-result-prefixes="ns1"
                version="1.0">
<foo xmlns="http://www.example.com/ns1"/>

<xsl:template match="/">
  <xsl:element name="foo"/>
</xsl:template>

</xsl:stylesheet>
