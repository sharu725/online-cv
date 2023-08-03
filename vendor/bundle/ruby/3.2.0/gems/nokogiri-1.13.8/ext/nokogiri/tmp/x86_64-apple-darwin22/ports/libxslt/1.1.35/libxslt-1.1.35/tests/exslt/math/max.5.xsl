<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/" xmlns:math="http://exslt.org/math">
    <out>
        Minimum: <minprice><xsl:value-of select="math:min(//sale/@price)"/></minprice>
        Maximum: <maxprice><xsl:value-of select="math:max(//sale/@price)"/></maxprice>
    </out>
    </xsl:template>
</xsl:stylesheet>

