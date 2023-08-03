<?xml version='1.0'?>
<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

<xsl:key name="mykey" match="div|obj" use="@id" />

<xsl:template match="link">
   <xsl:value-of select="@linkend"/>
   <xsl:text> </xsl:text>
   <xsl:value-of select="key('mykey', @linkend)/@href" />
</xsl:template>

</xsl:stylesheet>
