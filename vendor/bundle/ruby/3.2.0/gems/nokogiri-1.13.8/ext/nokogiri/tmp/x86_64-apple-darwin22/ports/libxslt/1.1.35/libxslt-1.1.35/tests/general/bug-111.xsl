<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl"
	exclude-result-prefixes="exsl">

	
<xsl:template match="/">
<root>
 <xsl:variable name="dtree">
    <DIRTREE dirpath="c:\file" dirname="file">
      <f n="AdditionalInfo.bmp" s="1999194" m="03/06/2002 11:21" a=" A" />
      <f n="AdditionalInfo.jpg" s="65835" m="03/15/2002 13:43" a=" A" />
      <f n="jdesupport.htm" s="6264" m="03/15/2002 13:32" a=" A" />
      <f n="LoginScreen.bmp" s="1410914" m="03/06/2002 11:18" a=" A" />
      <f n="MainScreen.bmp" s="1683330" m="03/06/2002 11:16" a=" A" />
      <f n="MainScreen.jpg" s="46339" m="03/15/2002 13:43" a=" A" />
      <f n="newsa.htm" s="3646" m="03/15/2002 13:41" a=" A" />
      <f n="OutputOptions.bmp" s="1216234" m="03/06/2002 11:22" a=" A" />
      <f n="ReportSysOverview.bmp" s="2008270" m="03/06/2002 11:23" a=" A" />
      <f n="ReportViewer.jpg" s="56653" m="03/15/2002 13:44" a=" A" />
      <f n="SelectProfile.bmp" s="1683330" m="03/06/2002 11:17" a=" A" />
      <f n="SelectProfile.jpg" s="71648" m="03/15/2002 11:06" a=" A" />
      <d name="utils" />
   </DIRTREE>
 </xsl:variable>
 Test 1
 <xsl:apply-templates select="exsl:node-set($dtree)/DIRTREE"/>
 Test 2
 <xsl:apply-templates select="/DIRTREE"/>

</root>
</xsl:template>

<xsl:template match="DIRTREE[d][f]" priority="100">
 <xsl:value-of select="name()"/> : <xsl:value-of select="boolean(d)"/> : <xsl:value-of select="boolean(f)"/>

</xsl:template>

<xsl:template match="@*|node()">
 Default Template Match Found
</xsl:template>

</xsl:stylesheet>

