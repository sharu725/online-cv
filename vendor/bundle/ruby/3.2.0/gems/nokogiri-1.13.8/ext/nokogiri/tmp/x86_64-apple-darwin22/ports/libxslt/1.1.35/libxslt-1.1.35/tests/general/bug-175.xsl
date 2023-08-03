<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:test="#test"
               exclude-result-prefixes="test"
               version="2.0">
   <xsl:output method="html" encoding="iso-8859-1" version="4.0"
               doctype-public="-//W3C//DTD HTML 4.01//EN"
               indent="yes"/>

   <xsl:template match="/">
      <html>
         <head>
            <title>xsl:function</title>
         </head>
         <body>
            <xsl:choose>
               <xsl:when test="function-available('test:test')">
                  <p>Result: <xsl:value-of select="test:test()"/></p>
               </xsl:when>
               <xsl:otherwise>
                  <p><tt>xsl:function</tt> not supported, but properly handled (ignored)</p>
               </xsl:otherwise>
            </xsl:choose>
         </body>
      </html>
   </xsl:template>

   <xsl:function name="test:test">
      <xsl:param name="x"/>
      <xsl:text>YES</xsl:text>
   </xsl:function>

</xsl:transform>
