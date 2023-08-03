<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format"
      exclude-result-prefixes="fo">
<xsl:template match="/">
  <html>
    <head>
      <title>Customers</title>
    </head>
    <body>
      <table>
	<tbody>
	  <xsl:for-each select="customers/customer">
	    <tr>
	      <th>
		<xsl:apply-templates select="name"/>
	      </th>
	      <xsl:for-each select="order">
		<td>
		  <xsl:apply-templates/>
		</td>
	      </xsl:for-each>
	    </tr>
	  </xsl:for-each>
	</tbody>
      </table>
    </body>
  </html>
</xsl:template>
</xsl:stylesheet>
