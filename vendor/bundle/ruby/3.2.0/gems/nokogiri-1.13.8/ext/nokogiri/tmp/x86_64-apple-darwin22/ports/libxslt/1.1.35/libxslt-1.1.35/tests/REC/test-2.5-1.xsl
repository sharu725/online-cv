<xsl:stylesheet version="1.8"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="system-property('xsl:version') >= 1.8">
	<xsl:exciting-new-1.8-feature/>
      </xsl:when>
      <xsl:otherwise>
	<html>
	<head>
	  <title>XSLT 1.8 required</title>
	</head>
	<body>
	  <p>Sorry, this stylesheet requires XSLT 1.8.</p>
	</body>
	</html>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
