<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<xsl:variable name="first" select="/doc/*[1]"/>
<xsl:variable name="last" select="/doc/*[last()]"/>
<xsl:text>Count1 :</xsl:text>
<xsl:value-of select="count($first/ancestor::* | $last/ancestor::*)"/>
<xsl:text>
</xsl:text>
<xsl:variable name="both" select="/doc/child2 | /doc/child1"/>
<xsl:text>Count2 :</xsl:text>
<xsl:value-of select="count($both/ancestor::*)"/>
<xsl:text>
</xsl:text>
</xsl:template>
</xsl:stylesheet>
