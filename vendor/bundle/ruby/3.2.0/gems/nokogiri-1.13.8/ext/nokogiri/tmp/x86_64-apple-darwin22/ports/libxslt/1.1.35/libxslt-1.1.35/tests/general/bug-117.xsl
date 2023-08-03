<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:l="http://www.foobar.com/xmlns/l"
                xmlns:s="http://www.foobar.com/xmlns/s"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="l"
                extension-element-prefixes="exsl"
>

<xsl:output method="html" media-type="text/html" encoding="ISO-8859-1" />

<xsl:template match="/">
        <xsl:apply-templates select="l:doc" />
</xsl:template>

<xsl:template match="l:doc">
        <s:doc>
                <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}"><xsl:value-of
select="."/></xsl:attribute>
                </xsl:for-each>
                <s:doc-head>
                        <xsl:apply-templates select="l:doc-head"/>
                </s:doc-head>
                <s:doc-body>
                        <s:div class="header">
                                <s:a href="/">
                                        <s:img
src="/images/logo/mylogo.jpg" width="200" height="100" border="0"
title="LOGO" alt="LOGO"/>
                                </s:a>
                        </s:div>
                        <s:br/>
                        <s:div class="body">
                                <xsl:apply-templates select="l:doc-content"/>
                        </s:div>
                </s:doc-body>
        </s:doc>
</xsl:template>

<xsl:template match="l:doc-title">
        <s:doc-title><xsl:apply-templates/></s:doc-title>
</xsl:template>

<!-- some HTML-like elements -->
<xsl:template
match="l:a|l:abbr|l:acronym|l:address|l:area|l:b|l:base|l:bdo|l:big|l:blockquote|l:body|l:br|l:button|l:caption|l:cite|l:code|l:col|l:colgroup|l:dd|l:del|l:dfn|l:div|l:dl|l:dt|l:em|l:fieldset|l:form|l:frame|l:framset|l:h1|l:h2|l:h3|l:h4|l:h5|l:h6|l:head|l:hr|l:i|l:iframe|l:img|l:input|l:ins|l:kbd|l:label|l:legend|l:li|l:link|l:map|l:noframes|l:noscript|l:object|l:ol|l:optgroup|l:option|l:p|l:param|l:pre|l:q|l:samp|l:script|l:select|l:small|l:span|l:strong|l:style|l:sub|l:sup|l:table|l:tbody|l:td|l:textarea|l:tfoot|l:th|l:thead|l:tr|l:tt|l:ul|l:var">
        <xsl:element name="s:{local-name()}">
                <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}"><xsl:value-of
select="." /></xsl:attribute>
                </xsl:for-each>
                <xsl:apply-templates />
        </xsl:element>
</xsl:template>

</xsl:stylesheet>
