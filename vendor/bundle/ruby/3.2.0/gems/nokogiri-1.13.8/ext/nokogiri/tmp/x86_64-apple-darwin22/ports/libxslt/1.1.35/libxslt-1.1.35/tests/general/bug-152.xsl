<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 version="1.0" xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output 
    method="xml"
    version="1.0"
    indent="yes"
    encoding="US-ASCII"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    />

  <xsl:template match="/">
    <html>
      <head>
        <style type="text/css" media="all">@import
"pretty_xhtml.css";</style>        
      </head>
      <body>
        <h1>foo</h1>
      </body>
    </html>
  </xsl:template>

</xsl:transform>



