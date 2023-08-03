<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:template match="include">
  Including: <xsl:value-of select="@href"/>
  <xsl:apply-templates select="document(@href)"/>
</xsl:template>

<xsl:template match="person">
  Person: <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
