<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
<xsl:output method="xml" indent="yes"/>
<xsl:template match="/">
<indexdoc>
<xsl:apply-templates select="//indexterm"> 
<xsl:sort data-type="text" select="primary"/>
<xsl:sort data-type="text" select="secondary"/>
</xsl:apply-templates>
</indexdoc>
</xsl:template>


<xsl:template match="indexterm">
<primaryterm><xsl:value-of select="primary"/></primaryterm>
<secondaryterm><xsl:value-of select="secondary"/></secondaryterm>
<tertiaryterm><xsl:value-of select="tertiary"/> </tertiaryterm>
</xsl:template>


</xsl:stylesheet>
