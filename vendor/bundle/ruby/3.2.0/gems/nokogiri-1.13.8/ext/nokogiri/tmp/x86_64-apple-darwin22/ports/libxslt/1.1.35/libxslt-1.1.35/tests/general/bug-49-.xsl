<?xml version="1.0" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 version="1.0">

<xsl:variable name="a">
   <xsl:variable name="b" select="'SUCCESS'"/>
   <xsl:value-of select="$b"/>
</xsl:variable>

<xsl:template match="/">
<xsl:value-of select="$a"/>
</xsl:template>

</xsl:stylesheet>
