<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:exsl="http://exslt.org/common"
 extension-element-prefixes="exsl"
 exclude-result-prefixes="exsl">

<xsl:template match="/">
<root>
<xsl:variable name="pkglist">
<sqltable name="F9670" datasource="System - B7333"><colset xmlns:o="http://www.jdedwards.com/OLAF" column-count="18"><col p="1">SUPKGNAME</col><col p="2">SURLS</col><col p="3">SUFRLS</col><col p="4">SUTRLS</col><col p="5">SUDL01</col><col p="6">SUSUTYPE</col><col p="7">SUSUDATE</col></colset><sequencing xmlns:o="http://www.jdedwards.com/OLAF"><col>SUPKGNAME</col></sequencing><results><r><col>JD12367</col><col>B7333</col><col>B7333</col><col>JD12367</col><col>ESU_JD12367_10/2/01</col><col>01</col><col>10/2/2001</col></r><r><col>JD12860</col><col>B7333</col><col>B7333</col><col>JD12860</col><col>ESU_JD12860_11/13/01</col><col>01</col><col>11/14/2001</col></r><r><col>JD14724</col><col>B7333</col><col>B7333</col><col>JD14724</col><col>ESU_JD14724_4/2/02</col><col>01</col><col>4/3/2002</col></r><r><col>JD15448</col><col>B7333</col><col>B7333</col><col>JD15448</col><col>ESU_JD15448_5/28/02</col><col>01</col><col>5/29/2002</col></r></results></sqltable>
</xsl:variable>
<xsl:for-each select="exsl:node-set($pkglist)/sqltable/results/r">
<update name="{col[1]}" release="{col[2]}" from-release="{col[3]}" to-release="{col[4]}" description="{col[5]}"
  type="{col[6]}" date="{col[7]}">
</update>
</xsl:for-each>
</root>

</xsl:template>
</xsl:stylesheet>
