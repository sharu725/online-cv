<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output indent="yes"/>

<xsl:template match="/">
  <results>
    <r>
      <xsl:number value="1234567890" grouping-separator="." grouping-size="3"/>
    </r>
    <r>
      <xsl:number value="1234567890" grouping-separator="’" grouping-size="3"/>
    </r>
    <r>
      <xsl:number value="1234567890" grouping-separator="." grouping-size="1"/>
    </r>
    <r>
      <xsl:number value="1234567890" grouping-separator="." grouping-size="0"/>
    </r>
    <r>
      <xsl:number value="1234567890" grouping-separator="." grouping-size="-1"/>
    </r>
    <r>
      <xsl:number value="1234567890" grouping-separator="." grouping-size="99"/>
    </r>
    <r>
      <xsl:number value="1234567890" grouping-separator="." grouping-size="abc"/>
    </r>
    <r>
      <xsl:number value="1234567890" grouping-separator="" grouping-size="3"/>
    </r>
  </results>
</xsl:template>

</xsl:stylesheet>
