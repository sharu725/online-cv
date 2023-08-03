<?xml version="1.0" encoding="iso-8859-1" standalone="no"?>

<!DOCTYPE xsl:stylesheet [

<!-- namespace for SVG -->
<!ENTITY svgns "http://www.w3.org/2000/svg">
<!-- namespace for XSLT -->
<!ENTITY xsltns "http://www.w3.org/1999/XSL/Transform">

<!-- namespaces for several EXSLT extension modules (see
     http://www.exslt.org for description) -->
<!ENTITY cns   "http://exslt.org/common"> <!-- EXSLT-Common -->
<!ENTITY fns   "http://exslt.org/functions"> <!-- EXSLT-Functions -->
<!ENTITY mns   "http://exslt.org/math"> <!-- EXSLT-Math -->

<!ENTITY foons "http://www.foo.org/bar">

]>

<xsl:stylesheet version="1.0" 
                xmlns="&svgns;" 
                xmlns:xsl="&xsltns;"
                xmlns:exsl="&cns;"
                xmlns:func="&fns;"
                xmlns:math="&mns;"
                xmlns:foo="&foons;"
                extension-element-prefixes="exsl func math foo"
                exclude-result-prefixes="xsl exsl func math">

<xsl:output method="xml" indent="yes" encoding="iso-8859-1" standalone="yes"/>

<xsl:template match="/">

    <xsl:text>Largest number value: </xsl:text>
    <xsl:value-of 
  select="math:max(rootelement/childelement/@val[string(number(.)) != 'NaN'])"/>
    <xsl:text>
Largest number value (computed by function foo:getMaxVal): </xsl:text>
    <xsl:value-of select="foo:getMaxVal(rootelement/childelement)"/>
    <xsl:text>
Largest number value (computed by function foo:getMaxVal2): </xsl:text>
    <xsl:value-of select="foo:getMaxVal2(rootelement/childelement)"/>
</xsl:template>            

<func:function name="foo:getMaxVal">
  <xsl:param name="nodes"/>

  <xsl:variable name="resNodes">
    <xsl:for-each select="$nodes">
      <xsl:if test="@val and string(number(@val)) != 'NaN'">
        <dummynode>
          <xsl:value-of select="@val"/>
        </dummynode>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="resNodeSet" select="exsl:node-set($resNodes)"/>
  
  <func:result select="math:max($resNodeSet/*)"/>
</func:function>

<func:function name="foo:getMaxVal2">
  <xsl:param name="nodes"/>

  <xsl:variable name="resNodes">
    <xsl:for-each select="$nodes">
      <xsl:if test="@val and string(number(@val)) != 'NaN'">
        <dummynode>
          <xsl:value-of select="@val"/>
        </dummynode>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
  
  <func:result select="math:max(exsl:node-set($resNodes)/*)"/>
</func:function>

</xsl:stylesheet>

