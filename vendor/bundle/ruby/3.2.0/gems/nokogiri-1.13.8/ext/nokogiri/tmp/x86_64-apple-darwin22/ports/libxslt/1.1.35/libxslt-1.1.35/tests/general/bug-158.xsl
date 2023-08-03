<?xml version="1.0" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.0"
                xmlns:dsl="http://www.decisionsoft.com/website"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:layout="http://www.decisionsoft.com/website-layout"
                xmlns="http://www.w3.org/1999/xhtml">

<xsl:variable name="myPath" select="/dsl:page/@path" />
<xsl:variable name="layout" select="document('../docs/bug-158.doc')"/>
<xsl:variable name="root"><xsl:value-of select="$layout//layout:page[@path=$myPath]" />
</xsl:variable>

<xsl:template match="/">
myPath is <xsl:value-of select="$myPath" />
root is <xsl:value-of select="$root" />
</xsl:template>

</xsl:stylesheet>
