<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

<xsl:output method="xml" /> 

<!--match first element of last item of any orderedlist-->
<!-- <xsl:template match="orderedlist/listitem[position()!=1][position()=last()]/*[1]"> -->
<xsl:template match="orderedlist/listitem[position()!=1][position()=last()]/*[1]">
   <xsl:text>First element of last item of orderedlist</xsl:text>
   <xsl:copy>
     <xsl:apply-templates select="@*|node()"/>
   </xsl:copy>
</xsl:template>

</xsl:stylesheet>


