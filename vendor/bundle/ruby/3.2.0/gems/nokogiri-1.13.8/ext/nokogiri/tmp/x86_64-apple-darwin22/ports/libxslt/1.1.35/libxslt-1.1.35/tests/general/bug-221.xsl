<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:key name="actions" match="/model/resource/action" use="@name"/>

<xsl:template match="action">
    <xsl:if test="generate-id(key('actions', @name)[1]) = generate-id(.)">
        <r><xsl:value-of select="@name"/></r>
    </xsl:if>
</xsl:template>

<xsl:template match="/">
    <xsl:apply-templates select="model/resource/action"/>
</xsl:template>

</xsl:stylesheet>
