<?xml version="1.0" encoding="iso-8859-1"?>

<!--
  Elememtary test for imported exslt stylesheets.  This was composed for
  checking on bug 114812.  test-import1.xsl imports test-import1a.imp
  which in turn imports test-import1b.imp.  If successful, f1() should
  come from this stylesheet, f2() should come from test-import1a.imp,
  and f3() should come from test-import1b.imp.
-->
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:func="http://exslt.org/functions"
        extension-element-prefixes="exsl func"
        exclude-result-prefixes="exsl func my"
    xmlns:my="my://own.uri"
>

<xsl:import href="import-test1a.imp"/>

<func:function name="my:f1">
<func:result>
Func f1 at top level</func:result>
</func:function>

<xsl:template match="/">
    <xsl:value-of select="my:f1()"/>
    <xsl:value-of select="my:f2()"/>
    <xsl:value-of select="my:f3()"/>
</xsl:template>

</xsl:stylesheet>
