<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- FileName: ResultTree005.xsl -->
  <!-- Document: http://www.w3.org/TR/xslt -->
  <!-- Section: 7.1.4 Named Attribute Sets -->
  <!-- Purpose: Set attributes of an xsl:element using attribute sets that 
       inherit. -->
  <!-- Author: Carmelo Montanez -->

<xsl:template match="/">
  <out>
    <xsl:element name="test" use-attribute-sets="set1"/>
  </out>
</xsl:template>

<xsl:attribute-set name="set2" use-attribute-sets="set3">
  <xsl:attribute name="text-decoration">underline</xsl:attribute>
</xsl:attribute-set>
  
<xsl:attribute-set name="set1" use-attribute-sets="set2">
  <xsl:attribute name="color">black</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="set3">
  <xsl:attribute name="font-size">14pt</xsl:attribute>
</xsl:attribute-set>

</xsl:stylesheet>
