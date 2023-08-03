<?xml version="1.0"?>

<!-- TEST use of set:trailing  -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:set="http://exslt.org/sets" exclude-result-prefixes="set"
>

  <xsl:template match="doc">
    <out>;
      <xsl:value-of select="count(set:trailing(*, d))"/>;
      <xsl:value-of select="count(set:trailing(*, b|d|f))"/>;
      <xsl:value-of select="count(set:trailing(*, a|f|h))"/>;
      <xsl:value-of select="count(set:trailing(*, x))"/>;
      <xsl:value-of select="count(set:trailing(x, *))"/>;
      <xsl:value-of select="count(set:trailing(d|e|f, a|e))"/>;
    </out>
  </xsl:template>

</xsl:stylesheet>
