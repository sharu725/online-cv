<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">
  <xsl:attribute-set name="my-attr-set">
    <xsl:attribute name="attr">from-attr-set</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="/">
    <p xsl:use-attribute-sets="my-attr-set" attr="from-p-tag">
      <xsl:attribute name="attr">from-xsl-attr</xsl:attribute>
    </p>
  </xsl:template>

</xsl:stylesheet>
