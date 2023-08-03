<?xml version='1.0' encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:rdf="urn:test:rdf"
xmlns:pa="urn:test:pa">

<xsl:template match="address">
  <xsl:variable name="id" select="@id"/>

  <pa:Contact rdf:about="hello">
      <pa:primaryPhone>
        <xsl:attribute name="rdf:about">toto</xsl:attribute>
      </pa:primaryPhone>
  </pa:Contact>
</xsl:template>

</xsl:stylesheet>
