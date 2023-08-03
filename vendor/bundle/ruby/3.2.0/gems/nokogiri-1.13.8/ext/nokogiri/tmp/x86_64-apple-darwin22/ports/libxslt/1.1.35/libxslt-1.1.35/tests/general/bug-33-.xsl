<?xml version="1.0" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">

 <xsl:output method="html"/>

 <xsl:template match="/">
   <html>
     <head>
       <title><xsl:value-of select="exam/@name"/></title>
       <script>
	 <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
	 funtion test() {
	   var a;
	   var b;

	   if (a &lt; b) { alert('Hello'); }
	 }

	 <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
       </script>
     </head>
     <body bgcolor="white">
     </body>
   </html>
 </xsl:template>

</xsl:stylesheet>
