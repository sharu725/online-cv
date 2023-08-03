<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns="my::namespace">

<xsl:variable name="var">baz</xsl:variable>

<xsl:output indent="yes"/>

<xsl:template match="/">
    <root> <!-- This is in the correct namespace "my::namespace" -->
        <foo>...</foo> <!-- OK. -->
        <xsl:element name="bar">...</xsl:element> <!-- Still okay. -->

        <!-- Wrong! These are without namespace. -->
        <xsl:element name="{concat('foo', 'bar')}">...</xsl:element>
        <xsl:element name="{$var}">...</xsl:element>
        <xsl:element name="{local-name(*)}">...</xsl:element>

        <!-- Explicitly setting the namespace fixes this. -->
        <xsl:element name="{$var}" namespace="my::namespace">...</xsl:element>
    </root>
</xsl:template>

</xsl:stylesheet>

