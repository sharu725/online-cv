<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
                exclude-result-prefixes="l"
                version="1.0">

<xsl:output method="xml"/>

<xsl:template match="form">
<xsl:for-each select="field">
<xsl:element name="input">
<xsl:attribute name="type">text</xsl:attribute>
<xsl:attribute name="name"><xsl:value-of
select="@name" /></xsl:attribute>
<xsl:value-of select="initialvalue" />
</xsl:element><td><input type="text" name="description"/></td>

</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
