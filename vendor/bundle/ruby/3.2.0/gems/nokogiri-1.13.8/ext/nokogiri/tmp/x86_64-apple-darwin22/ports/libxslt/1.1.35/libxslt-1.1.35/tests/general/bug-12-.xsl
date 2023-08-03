<?xml version='1.0' encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
            version="1.0"
	    encoding="ISO-8859-1"
	    indent="yes" />
	    
<xsl:template match="/">
   <namespace>
   <xsl:value-of select="//namespace::*"/>
   </namespace>
</xsl:template>

</xsl:stylesheet>
