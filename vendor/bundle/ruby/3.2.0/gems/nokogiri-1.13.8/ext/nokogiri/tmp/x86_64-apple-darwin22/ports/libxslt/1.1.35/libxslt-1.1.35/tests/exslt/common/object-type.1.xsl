<?xml version="1.0"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:exslt="http://exslt.org/common" >

<!-- Test exslt:object-type -->

<xsl:variable name="tree">
<a><b><c><d/></c></b></a>
</xsl:variable>

<xsl:variable name="string" select="'fred'"/>
<xsl:variable name="number" select="93.7"/>
<xsl:variable name="boolean" select="true()"/>
<xsl:variable name="node-set" select="//*"/>

<xsl:template match="/">
  <out>:
    <xsl:value-of select="exslt:object-type($string)"/>;
    <xsl:value-of select="exslt:object-type($number)"/>;
    <xsl:value-of select="exslt:object-type($boolean)"/>;
    <xsl:value-of select="exslt:object-type($node-set)"/>;
    <xsl:value-of select="exslt:object-type($tree)"/>;
    <xsl:if test="function-available('saxon:expression')" 
            xmlns:saxon="http://icl.com/saxon">
        <xsl:value-of select="exslt:object-type(saxon:expression('item'))"/> 
    </xsl:if>;                    
  </out>
</xsl:template>
 
</xsl:stylesheet>
