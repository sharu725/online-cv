<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:bb="http://bbrack.org">
    <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"/>
    <xsl:namespace-alias
        stylesheet-prefix="#default" 
	result-prefix="bb" />
    <xsl:strip-space elements="*" />
    <xsl:template match="/adoc">
        <root>
	    <element1 xmlns="http://delightful.com.hk">
	        <element2>Content 2</element2>
	    </element1>
	    <element3>Content 3</element3>
	</root>
    </xsl:template>
</xsl:stylesheet>
