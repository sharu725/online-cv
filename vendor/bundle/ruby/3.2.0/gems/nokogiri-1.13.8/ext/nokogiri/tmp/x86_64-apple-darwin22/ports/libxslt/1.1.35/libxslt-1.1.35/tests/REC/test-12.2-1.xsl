<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:key name="idkey" match="div" use="@id"/>

<xsl:template match="doc">
<xsl:value-of select="key('idkey','lookup')"/>
</xsl:template>

</xsl:stylesheet>
