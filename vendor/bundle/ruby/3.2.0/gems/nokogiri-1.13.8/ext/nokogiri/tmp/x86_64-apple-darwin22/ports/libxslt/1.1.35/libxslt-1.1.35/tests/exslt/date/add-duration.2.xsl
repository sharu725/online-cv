<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">

<xsl:output method="text"/>
<xsl:strip-space elements="*"/>

<xsl:template match="date">
add-duration : <xsl:value-of select="@dur1"/> + <xsl:value-of select="@dur2"/>
result       : <xsl:value-of select="date:add-duration(@dur1,@dur2)"/>
</xsl:template>

</xsl:stylesheet>

