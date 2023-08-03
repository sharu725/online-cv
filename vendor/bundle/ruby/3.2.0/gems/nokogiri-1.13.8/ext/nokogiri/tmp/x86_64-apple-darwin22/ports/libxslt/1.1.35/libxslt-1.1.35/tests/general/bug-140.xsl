<?xml version="1.0" encoding="iso-8859-1" standalone="no"?>

<!DOCTYPE xsl:stylesheet [

<!ENTITY bar "bar"> 

<!ENTITY foo "var foo = &bar;"> 

<!-- namespace for SVG -->
<!ENTITY svgns "http://www.w3.org/2000/svg">
<!-- namespace for XSLT -->
<!ENTITY xsltns "http://www.w3.org/1999/XSL/Transform">

]>

<xsl:stylesheet version="1.0" 
                xmlns="&svgns;" 
                xmlns:xsl="&xsltns;"
                exclude-result-prefixes="xsl">

<xsl:output method="xml" indent="yes" encoding="iso-8859-1"
standalone="yes" cdata-section-elements="script"/>

<xsl:variable name="foo" select="'bar'"/>

<xsl:template match="/">
  <script type="text/ecmascript">
  var foo2 = text;
  </script>
</xsl:template>            

</xsl:stylesheet>
