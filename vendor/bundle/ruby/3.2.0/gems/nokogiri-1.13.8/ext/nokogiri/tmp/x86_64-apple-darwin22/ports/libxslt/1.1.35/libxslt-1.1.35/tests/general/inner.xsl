<?xml version= "1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:my="http://my/namespace"
  exclude-result-prefixes="my">

  <xsl:template match="my:document">
    Big <xsl:apply-templates select="my:item"/>
  </xsl:template>

</xsl:stylesheet>
