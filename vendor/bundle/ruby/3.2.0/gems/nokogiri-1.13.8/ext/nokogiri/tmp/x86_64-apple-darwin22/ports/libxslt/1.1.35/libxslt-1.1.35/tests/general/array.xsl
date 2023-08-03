<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<!-- filename:      test.xsl                                                         created on:    2001 Jun 14 01:35:21 +0200 (CEST)                                last modified: 2001 Jun 14 01:47:18 +0200 (CEST)                                (c) 2001 by Goetz Bock <bock@blacknet.de>
-->
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:local="data_local_to_this_file"
	       version='1.0'>
<xsl:output method="text" />
<local:benefit>
<local:period ID='12M'>1</local:period>
<local:period ID='18M'>2</local:period>
<local:period ID='24M'>3</local:period>
<local:period ID='2Y' >4</local:period>
<local:period ID='5Y' >5</local:period>
</local:benefit>
<xsl:template match="/">
<xsl:text>First we try to find the value for "12M" (should be 1): </xsl:text>
<xsl:value-of select="document('')//local:benefit/local:period[@ID='12M']"/>
<xsl:text>&#xA;Now we define a variable $BP to be "18M".</xsl:text>
<xsl:variable name="BP">18M</xsl:variable>
<xsl:text>&#xA;$BP is defined as: </xsl:text>
<xsl:value-of select="$BP" />
<xsl:text>&#xA;Now we try to find the value for $BP (should be 2): </xsl:text>
<xsl:value-of select="document('')//local:benefit/local:period[@ID=$BP]"/>
<xsl:text>&#xA;</xsl:text>
</xsl:template>
</xsl:transform>
