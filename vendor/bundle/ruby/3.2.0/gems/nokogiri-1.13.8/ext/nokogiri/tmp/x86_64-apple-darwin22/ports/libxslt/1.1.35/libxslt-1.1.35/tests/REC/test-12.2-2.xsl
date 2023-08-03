<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:key name="idkey" match="div" use="@id"/>

<xsl:template match="key('idkey','lookup')">
Success
</xsl:template>

</xsl:stylesheet>
