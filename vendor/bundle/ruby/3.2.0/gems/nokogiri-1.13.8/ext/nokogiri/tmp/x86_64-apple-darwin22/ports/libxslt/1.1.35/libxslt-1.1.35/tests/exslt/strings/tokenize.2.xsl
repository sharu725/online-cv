<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="str">
                                                                                
<xsl:template match="/">
<xsl:for-each select="str:tokenize('This is strange behavior', ' ')" >
 <tok><xsl:value-of select="."/></tok>
</xsl:for-each>
</xsl:template>
                                                                                
</xsl:stylesheet>
