<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<xsl:variable name="x" select="'val'" />
  <xsl:template match="/">
    <xsl:text>
    </xsl:text>
    <foo attr="$x"/> Expect '$x'
    <foo attr="{$x}"/> Expect 'val'
    <foo attr="{{$x"/> Expect 'bracket $x'
    <foo attr="$x}}"/> Expect '$x bracket'
    <foo attr="{{$x}}"/> Expect 'bracket $x bracket'
    <foo attr="{{{$x}}}"/> Expect 'bracket val bracket'
  </xsl:template>

</xsl:stylesheet>
