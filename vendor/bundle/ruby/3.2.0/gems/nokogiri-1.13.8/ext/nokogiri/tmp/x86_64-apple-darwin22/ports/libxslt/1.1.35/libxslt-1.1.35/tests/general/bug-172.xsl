<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="para">
   
  <xsl:choose>
    <xsl:when test="@bold='true'">
      <p><b><xsl:number count="para" format="1. "/> <xsl:apply-templates/></b></p>
    </xsl:when>
    <xsl:otherwise>
      <p><xsl:number count="para" format="1. "/> <xsl:apply-templates/></p>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>

<xsl:template match="/">
  <html><body>
    <xsl:apply-templates/>
  </body></html>
</xsl:template>

</xsl:stylesheet>