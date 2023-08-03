<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="ns">
 <ns xmlns:ns="http://whatever"/>
</xsl:template>


<xsl:template match="/*">
 <elem>
   <xsl:copy-of select="document('')/*/
		       xsl:template[@name='ns']/
		       ns/namespace::ns"/>
 </elem>
</xsl:template>

</xsl:stylesheet>
