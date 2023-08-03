<?xml version="1.0"?> 

<!-- reassembles an xml tree in reverse order -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output encoding="utf-8"/>

<xsl:template match="*">
  <xsl:copy>
    <xsl:apply-templates select="node()">
      <xsl:sort select="position()" data-type="number" order="descending"/> 
    </xsl:apply-templates> 
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>

