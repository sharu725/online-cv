<?xml version= "1.0"?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:my="http://my/namespace"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="my">
  
  <!-- Root Node -->
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="my:document/my:name"/></title>
      </head>	
      <xsl:apply-templates/>
    </html>
  </xsl:template>
  
  <!-- Header and Body for the Document -->
  <xsl:template match="my:document">
    <body>
      <h1><xsl:value-of select="my:name"/></h1>
      <xsl:apply-templates/>
      <hr/>
    </body>
  </xsl:template>
  
  <!--Don't display name-->
  <xsl:template match="my:name">
  </xsl:template>

</xsl:stylesheet>
