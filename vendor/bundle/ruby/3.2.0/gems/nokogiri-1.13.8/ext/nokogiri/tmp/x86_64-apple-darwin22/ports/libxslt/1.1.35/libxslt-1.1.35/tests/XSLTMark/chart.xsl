<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="utf-8"/>

  <xsl:template match="salesdata">
    <xsl:variable name="max" select="50"/>

    <html>
      <body bgcolor="#ffffff">
      <table border="0">
        <tr>
          <td colspan="{count(year)}" align="center">Sales By Region</td>
        </tr>
        <tr>
          <xsl:for-each select="year">
            <td valign="top">
              <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                  <xsl:for-each select="region">
                    <xsl:variable name="color">
                      <xsl:choose>
                        <xsl:when test="name='west'">#0000ff</xsl:when>
                        <xsl:when test="name='central'">#ff00ff</xsl:when>
                        <xsl:when test="name='east'">#00ff00</xsl:when>
                      </xsl:choose>
                    </xsl:variable>
                    <td valign="top">
                      <table border="0" cellpadding="0" cellspacing="0">
                        <tr height="{5 * ($max - sales)}">
                          <td bgcolor="#ffffff" width="10" height="{5 * ($max - sales)}">
                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                          </td>
                        </tr>
                        <tr height="{5 * sales}">
                          <td bgcolor="{$color}" width="10" height="{5 * sales}">
                            <xsl:text disable-output-escaping="yes">&amp;#160;</xsl:text>
                          </td>
                        </tr>
                        
                      </table>
                    </td>
                  </xsl:for-each>
                </tr>
                <tr>
                  <td colspan="{count(region)}" align="center">
                    <xsl:value-of select="year"/>
                  </td>
                </tr>
              </table>
            </td>
          </xsl:for-each>
        </tr>
      </table>
    </body>
    </html>

  </xsl:template>

</xsl:stylesheet>
