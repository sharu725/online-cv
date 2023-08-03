<?xml version="1.0"?> 

<!-- the slow way... -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output encoding="utf-8"/>

<xsl:template name="getsku">
  <xsl:if test="position() != 1">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <xsl:value-of select="sku"/>
</xsl:template>

<xsl:template match="categories/category">
  <tr>
    <td><xsl:value-of select="name"/></td>
    <td>
      <xsl:for-each select="//products/product[category=current()/id]">
        <xsl:call-template name="getsku"/>
      </xsl:for-each>
    </td>
  </tr>
</xsl:template>

<xsl:template match="/">
  <html>
    <table border="1">
      <xsl:apply-templates select="//categories/category"/>
    </table>
  </html>
</xsl:template>

</xsl:stylesheet>