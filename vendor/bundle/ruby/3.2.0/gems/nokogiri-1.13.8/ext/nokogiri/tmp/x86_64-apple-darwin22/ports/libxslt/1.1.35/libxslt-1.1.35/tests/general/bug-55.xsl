<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:preserve-space elements="*"/>
<xsl:output method="xml"/>
<xsl:template match="child::foo">
<bar/>
</xsl:template>
</xsl:stylesheet>
