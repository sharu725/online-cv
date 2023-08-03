<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exslt="http://exslt.org/common"
    exclude-result-prefixes="exslt">

<xsl:template match="/">
<out>;
  <xsl:copy-of select="exslt:node-set('test')"/>;
  <xsl:copy-of select="exslt:node-set(5)"/>;
  <xsl:copy-of select="exslt:node-set(true())"/>;
</out>
</xsl:template>
</xsl:stylesheet>
