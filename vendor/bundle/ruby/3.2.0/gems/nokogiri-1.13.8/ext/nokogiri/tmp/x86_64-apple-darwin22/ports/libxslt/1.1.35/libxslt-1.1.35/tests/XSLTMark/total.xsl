<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8"/>

  <xsl:template match="/">
    <html>
      <table border="1">
        <tr>
          <td colspan="2">Total Sales</td>
        </tr>
        <xsl:for-each select="salesdata/year">
          <tr>
            <td>
              <xsl:value-of select="year"/>
            </td>
            <td align="right">
              <xsl:value-of select="sum(region/sales)"/>
            </td>
          </tr>
        </xsl:for-each>
        <tr>
          <td>Grand Total</td>
          <td align="right">
            <xsl:value-of select="sum(salesdata/year/region/sales)"/>
          </td>
        </tr>
      </table>
    </html>
  </xsl:template>
</xsl:stylesheet>