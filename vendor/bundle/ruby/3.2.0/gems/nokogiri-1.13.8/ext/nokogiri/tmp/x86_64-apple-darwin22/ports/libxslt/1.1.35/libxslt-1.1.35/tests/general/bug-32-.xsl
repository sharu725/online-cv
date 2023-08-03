<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:b="http://b">

<xsl:template match="@b:*"/>

<xsl:template match="*">
 <xsl:copy>
   <xsl:apply-templates select="*|@*"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="@*">
 <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
