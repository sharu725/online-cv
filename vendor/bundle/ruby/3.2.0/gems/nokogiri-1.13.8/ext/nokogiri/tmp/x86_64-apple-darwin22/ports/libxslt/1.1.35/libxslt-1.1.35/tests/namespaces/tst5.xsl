<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
        xmlns:xhtml="http://www.w3.org/1999/xhtml"   >
   <xsl:output method="xml" indent="yes" encoding="iso-8859-1" />
   <xsl:template match="/">
      <?xml-stylesheet href="chrome://global/skin/" type="text/css"?>
      <windows>
        <vbox flex="1">
                   <xsl:apply-templates />
            </vbox>
      </windows>
   </xsl:template>
   <xsl:template match="a">
         <vbox>
                <xhtml:div>Hello</xhtml:div>
                <xsl:element name="xhtml:div">
                        foo
                </xsl:element>
         </vbox>
   </xsl:template>
</xsl:stylesheet>

