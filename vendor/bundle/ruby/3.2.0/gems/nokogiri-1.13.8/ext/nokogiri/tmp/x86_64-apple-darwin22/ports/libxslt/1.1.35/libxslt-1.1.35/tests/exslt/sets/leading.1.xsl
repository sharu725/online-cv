<?xml version="1.0"?>

<!-- TEST use of set:leading  -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:set="http://exslt.org/sets" exclude-result-prefixes="set"
>

  <xsl:template match="doc">
    <out>;
      <xsl:value-of select="count(set:leading(*, g))"/>;
      <xsl:value-of select="count(set:leading(*, b))"/>;
      <xsl:value-of select="count(set:leading(*, d|f|h))"/>;
      <xsl:value-of select="count(set:leading(*, a|f|h))"/>;
      <xsl:value-of select="count(set:leading(*, x))"/>;
      <xsl:value-of select="count(set:leading(x, *))"/>;
      <xsl:value-of select="count(set:leading(a|b|c, h))"/>;
    </out>
  </xsl:template>

</xsl:stylesheet>
