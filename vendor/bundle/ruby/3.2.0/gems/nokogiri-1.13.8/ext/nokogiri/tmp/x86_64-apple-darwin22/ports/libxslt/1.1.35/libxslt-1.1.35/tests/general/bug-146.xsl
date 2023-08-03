<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="windows-1251" indent="yes"/>
<xsl:strip-space elements="*"/>
<xsl:key name="EMPTY_EN_CODE_COLLS" match="/root/colls/goodcoll/goodcomb/@COL_ID
[../@EN_CODE = '']" use="../../../@COL_COD"/>
<xsl:key name="EMPTY_EN_CODE_COLRS" match="/root/colls/goodcoll/goodcomb/@COL_ID
[../@EN_CODE = '']" use="concat(.,':',../../../@COL_COD)"/>
<xsl:template match="/">
<root>
 <xsl:for-each select="/root/colls[key('EMPTY_EN_CODE_COLLS',@COL_COD)]">
  <xsl:copy>
   <xsl:copy-of select="@*"/>
   <xsl:for-each select="key('EMPTY_EN_CODE_COLLS',@COL_COD)[generate-id(.) = 
generate-id(key('EMPTY_EN_CODE_COLRS',concat(.,':',../../../@COL_COD)))]">
    <color>
     <xsl:copy-of select="../@TITLE | ../@RU_CODE | ."/>
    </color>
   </xsl:for-each>
  </xsl:copy>
 </xsl:for-each>
</root>
</xsl:template>
</xsl:stylesheet>
