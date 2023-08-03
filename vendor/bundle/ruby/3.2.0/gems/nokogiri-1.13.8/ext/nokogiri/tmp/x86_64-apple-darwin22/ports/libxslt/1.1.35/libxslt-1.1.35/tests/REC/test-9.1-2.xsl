<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format"
      exclude-result-prefixes="fo">

<xsl:strip-space elements="itemlist"/>

<xsl:template match="/">
<html>
<body>
<xsl:apply-templates/>
</body>
</html>
</xsl:template>

<xsl:template match="itemlist">
<table>
<tbody>
<xsl:apply-templates/>
</tbody>
</table>
</xsl:template>

<xsl:template match="item">
  <tr>
    <xsl:if test="position() mod 2 = 0">
       <xsl:attribute name="bgcolor">yellow</xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </tr>
</xsl:template>
</xsl:stylesheet>
