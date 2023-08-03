<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="html" encoding="utf-8"/>

  <xsl:template match="row[id='0432']">
    <html>
      <head bgcolor="#ffffff">
      </head>
      <body>
        <table border="0">
          <tr>
            <td colspan="2" bgcolor="#000000">
              <font color="#ffffff">
                <xsl:value-of select="concat('personel record #', id)"/>
              </font>
            </td>
          </tr>
          <tr>
            <td bgcolor="#888888">
              First Name:
            </td>
            <td bgcolor="#dddddd">
              <xsl:value-of select="firstname"/>
            </td>
          </tr>
          <tr>
            <td bgcolor="#888888">
              Last Name:
            </td>
            <td bgcolor="#dddddd">
              <xsl:value-of select="lastname"/>
            </td>
          </tr>
          <tr>
            <td bgcolor="#888888">
              Street:
            </td>
            <td bgcolor="#dddddd">
              <xsl:value-of select="street"/>
            </td>
          </tr>
          <tr>
            <td bgcolor="#888888">
              City:
            </td>
            <td bgcolor="#dddddd">
              <xsl:value-of select="city"/>
            </td>
          </tr>
          <tr>
            <td bgcolor="#888888">
              State:
            </td>
            <td bgcolor="#dddddd">
              <xsl:value-of select="state"/>
            </td>
          </tr>
          <tr>
            <td bgcolor="#888888">
              Zip
            </td>
            <td bgcolor="#dddddd">
              <xsl:value-of select="zip"/>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>
