<?xml version="1.0"?> 

<!-- baseball game stats -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="utf-8"/>
<xsl:template match="game">
  <tr>
    <td>Inning</td>
    <xsl:for-each select="innings/inning">
      <td>
        <xsl:value-of select="num"/>
      </td>
    </xsl:for-each>
    <td>final</td>
  </tr>
  <tr>
    <td><b><xsl:value-of select="home"/></b></td>
    <xsl:for-each select="innings/inning">
      <td>
        <xsl:value-of select="home/runs"/>
      </td>
    </xsl:for-each>
    <td>
      <xsl:value-of select="sum(innings/inning/home/runs)"/>
    </td>
  </tr>
  <tr>
    <td><b><xsl:value-of select="visitors"/></b></td>
    <xsl:for-each select="innings/inning">
      <td>
        <xsl:value-of select="visitors/runs"/>
      </td>
    </xsl:for-each>
    <td>
      <xsl:value-of select="sum(innings/inning/visitors/runs)"/>
    </td>
  </tr>
</xsl:template>

<xsl:template match="/">
  <html>
    <table border="1">
      <xsl:apply-templates select="games/game"/>
    </table>
  </html>

</xsl:template>

</xsl:stylesheet>