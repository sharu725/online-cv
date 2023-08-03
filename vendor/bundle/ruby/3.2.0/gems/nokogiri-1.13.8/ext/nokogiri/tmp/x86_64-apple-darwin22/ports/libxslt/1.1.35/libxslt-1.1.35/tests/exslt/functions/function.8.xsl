<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" 
       xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
       xmlns:func="http://exslt.org/functions"
	     extension-element-prefixes="func"
>
<xsl:output method="text" encoding="ISO-8859-1" omit-xml-declaration="yes" />

<xsl:variable name="prefix" select="/adt/prefix" /> 
<xsl:variable name="prosaName" select="/adt/prosa-name" />

<xsl:variable name="suffix" select="'.h'" />

<!-- makes all letters upper case -->
<func:function name="func:upper">
  <xsl:param name="in" />
  <func:result select="translate($in,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
</func:function>

<!-- makes all letters lower case -->
<func:function name="func:lower">
  <xsl:param name="in" />
  <func:result select="translate($in,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')" />
</func:function>

<!-- makes first letter (of every word) upper case -->
<!-- converts first x to X and every _x to _X       -->
<!-- and every ' x' to 'X' (note the space)        -->
<func:function name="func:firstUpper">
  <xsl:param name="in" />
  <xsl:variable name="tmp" select="$in"/>
  <xsl:choose>
    <!-- Call first upper for each word -->
    <xsl:when test="contains(substring($tmp,2),' ')">
      <func:result select="concat(
        func:firstUpper(substring-before($tmp,' ')),
        func:firstUpper(substring-after(substring($tmp,2),' ')))" />
    </xsl:when>
    <!-- read over '_' -->
    <xsl:when test="contains(substring($tmp,1,1),'_')">
      <func:result select="concat('_',
        func:firstUpper(substring($tmp,2)))" />
    </xsl:when>
    <!-- Make first character upper case and continue -->
    <xsl:otherwise>
      <func:result select="concat(func:upper(substring($tmp,1,1)),
        substring($tmp,2))" />
    </xsl:otherwise> 
  </xsl:choose>
</func:function>

<xsl:template match="adt">

  <xsl:variable name="prosaNameLower" select="func:lower($prosaName)" />

  <xsl:value-of select="concat( 'typedef struct ', 
    func:firstUpper($prefix), '_', func:firstUpper($prosaNameLower), ' ',
    func:firstUpper($prefix), '_', func:firstUpper($prosaNameLower), 
    '; &#10;&#10;' )" />

</xsl:template>

<!-- finished -->
</xsl:stylesheet>
