<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:exsl="http://exslt.org/common"
 xmlns:set="http://exslt.org/sets"
 extension-element-prefixes="exsl set"
 exclude-result-prefixes="exsl set"
>

<xsl:output method="xml"/>

<!-- This works as is.  Comment out the p element and un-comment the error line. -->
<xsl:template match="/">
 <results>
   <xsl:variable name="n">
   <p></p>
   </xsl:variable>
   <xsl:copy-of select="set:distinct(exsl:node-set($n)/p/a)"/>
 </results>
</xsl:template>

</xsl:stylesheet>

