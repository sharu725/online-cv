<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ex="http://www.example.org/"
    version="1.0"
    >

<xsl:output method="xml" />

<xsl:template match="/">
<xsl:copy-of select="/" />
</xsl:template>

</xsl:stylesheet>
