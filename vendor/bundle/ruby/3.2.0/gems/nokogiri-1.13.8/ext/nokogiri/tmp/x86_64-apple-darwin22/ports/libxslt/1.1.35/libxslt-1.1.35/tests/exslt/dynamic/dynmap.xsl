<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
 xmlns:dyn="http://exslt.org/dynamic"
 exclude-result-prefixes="dyn"
>
<xsl:output indent="yes"/>

<xsl:template match="/dynmap">
<result>
 <node-set>
  <xsl:copy-of select="dyn:map(*, 'child::*[string-length(.) &gt; 3]')"/>
 </node-set> 
 <boolean>
  <xsl:copy-of select="dyn:map(*, 'string-length(name()) &gt; 3')"/>
 </boolean>
 <number>
  <xsl:copy-of select="dyn:map(*, 'count(*)')"/>
 </number>
 <string>
  <xsl:copy-of select="dyn:map(*, 'name()')"/>
  <xsl:copy-of select="dyn:map(., '&quot;&amp;&#41;&quot;')"/>
 </string>  
 <namespace>
  <xsl:copy-of select="dyn:map(namespace::*, 'name(/*)')"/>
 </namespace>
</result> 
</xsl:template>
</xsl:stylesheet>

