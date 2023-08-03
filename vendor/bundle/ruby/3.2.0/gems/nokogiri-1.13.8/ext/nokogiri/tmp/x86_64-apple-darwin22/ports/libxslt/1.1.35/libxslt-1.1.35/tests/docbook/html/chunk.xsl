<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
		version="1.1"
                exclude-result-prefixes="doc"
                extension-element-prefixes="saxon xalanredirect lxslt">

<!-- This stylesheet works with Saxon and Xalan; for XT use xtchunk.xsl -->

<xsl:import href="autoidx.xsl"/>
<xsl:include href="chunk-common.xsl"/>
<xsl:include href="chunker.xsl"/>

</xsl:stylesheet>
