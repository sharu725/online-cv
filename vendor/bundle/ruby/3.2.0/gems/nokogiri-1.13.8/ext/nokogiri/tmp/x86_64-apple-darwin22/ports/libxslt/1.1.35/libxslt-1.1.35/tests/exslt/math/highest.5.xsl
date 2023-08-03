<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/" xmlns:math="http://exslt.org/math">
    <out>
        * <lowest-prices>
        <xsl:for-each select="math:lowest(//sale/@price)">
            <xsl:value-of select="../@id"/>;
        </xsl:for-each>    
        </lowest-prices>
        * <highest-prices>
        <xsl:for-each select="math:highest(//sale/@price)">
            <xsl:value-of select="../@id"/>;
        </xsl:for-each>
        </highest-prices>
    </out>
    </xsl:template>
</xsl:stylesheet>

