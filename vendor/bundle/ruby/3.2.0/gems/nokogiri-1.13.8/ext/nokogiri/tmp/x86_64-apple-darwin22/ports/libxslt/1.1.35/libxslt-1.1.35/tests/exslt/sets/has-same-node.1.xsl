<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:set="http://exslt.org/sets" >

<!-- Test set:has-same-node -->

<xsl:variable name="a1" select="//city[@name='Vienna' or @name='Salzburg']"/>
<xsl:variable name="a2" select="//city[@country='Austria']"/>

<xsl:template match="/">
  <out>
    Test has-same-node() between two intersecting sets:
    <xsl:if test="set:has-same-node($a1,$a2)">OK</xsl:if>;
    Test has-same-node() between two non-intersecting sets:
    <xsl:if test="not(set:has-same-node($a1,//city/@name))">OK</xsl:if>;
    Test has-same-node() between two identical sets of namespace nodes:
    <xsl:if test="set:has-same-node((//city[1])/namespace::*,(//city[1])/namespace::*)">OK</xsl:if>;        
    Test has-same-node() between two disjoint sets of namespace nodes:
    <xsl:if test="not(set:has-same-node((//city[1])/namespace::*,(//city[2])/namespace::*))">OK</xsl:if>;        
  </out>
</xsl:template>
 
</xsl:stylesheet>
