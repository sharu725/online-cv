<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="utf-8"/>
  <xsl:template match="val">
    <val>
      <current>
        <xsl:value-of select="."/>
      </current>
      <smooth>
        <xsl:value-of select="floor(sum(preceding-sibling::val[position() &lt; 4] | following-sibling::val[position() &lt; 4]) div count(preceding-sibling::val[position() &lt; 4] | following-sibling::val[position() &lt; 4]))"/>

      </smooth>
      <delta>
        <xsl:value-of select=". - preceding-sibling::val[1]"/>
      </delta>
    </val>
  </xsl:template>

</xsl:stylesheet>
