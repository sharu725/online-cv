<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:html="http://www.w3.org/1999/xhtml">
        <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"
doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
        <xsl:namespace-alias stylesheet-prefix="html" result-prefix="#default" />
        <xsl:strip-space elements="*" />
        <xsl:template match="/adoc">
                <html:html>
                        <html:head>
                                <html:title>
                                        A title
                                </html:title>
                        </html:head>
                        <html:body>
                                        Some text
                        </html:body>
                </html:html>
        </xsl:template>
</xsl:stylesheet>
