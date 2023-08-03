<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output encoding="utf-8"/>
<xsl:template match="towerheight">
    <towersequence>
        <xsl:call-template name="print">
            <xsl:with-param name="height1" select="."/>
            <xsl:with-param name="height2" select="0"/>
            <xsl:with-param name="height3" select="0"/>
        </xsl:call-template>        
        <xsl:call-template name="transferstack">
            <xsl:with-param name="source" select="1"/>
            <xsl:with-param name="target" select="2"/>
            <xsl:with-param name="spare" select="3"/>
            <xsl:with-param name="height1" select="."/>
            <xsl:with-param name="height2" select="0"/>
            <xsl:with-param name="height3" select="0"/>
            <xsl:with-param name="howmany" select="."/>
        </xsl:call-template>
    </towersequence>
</xsl:template>

<xsl:template name="transferstack">
    <xsl:param name="source"/>
    <xsl:param name="target"/>
    <xsl:param name="spare"/>
    <xsl:param name="height1"/>
    <xsl:param name="height2"/>
    <xsl:param name="height3"/>
    <xsl:param name="howmany"/>
    <xsl:if test="$howmany > 0">
        <xsl:call-template name="transferstack">
            <xsl:with-param name="source" select="$source"/>
            <xsl:with-param name="target" select="$spare"/>
            <xsl:with-param name="spare" select="$target"/>
            <xsl:with-param name="height1" select="$height1"/>
            <xsl:with-param name="height2" select="$height2"/>
            <xsl:with-param name="height3" select="$height3"/>
            <xsl:with-param name="howmany" select="$howmany - 1"/>
        </xsl:call-template>
        <xsl:call-template name="print">
            <xsl:with-param name="height1" 
                select="($source = 1) * ($height1 - $howmany) + ($target = 1) * ($height1 + 1) + ($spare = 1) * ($height1 + $howmany - 1)"/>
            <xsl:with-param name="height2" 
                select="($source = 2) * ($height2 - $howmany) + ($target = 2) * ($height2 + 1) + ($spare = 2) * ($height2 + $howmany - 1)"/>
            <xsl:with-param name="height3" 
                select="($source = 3) * ($height3 - $howmany) + ($target = 3) * ($height3 + 1) + ($spare = 3) * ($height3 + $howmany - 1)"/>
        </xsl:call-template>        
        
        <xsl:call-template name="transferstack">
            <xsl:with-param name="source" select="$spare"/>
            <xsl:with-param name="target" select="$target"/>
            <xsl:with-param name="spare" select="$source"/>
            <xsl:with-param name="height1" 
                select="($source = 1) * ($height1 - $howmany) + ($target = 1) * ($height1 + 1) + ($spare = 1) * ($height1 + $howmany - 1)"/>
            <xsl:with-param name="height2" 
                select="($source = 2) * ($height2 - $howmany) + ($target = 2) * ($height2 + 1) + ($spare = 2) * ($height2 + $howmany - 1)"/>
            <xsl:with-param name="height3" 
                select="($source = 3) * ($height3 - $howmany) + ($target = 3) * ($height3 + 1) + ($spare = 3) * ($height3 + $howmany - 1)"/>
            <xsl:with-param name="howmany" select="$howmany - 1"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="print">
    <xsl:param name="height1"/>
    <xsl:param name="height2"/>
    <xsl:param name="height3"/>
    <tower>
        <pole height="{$height1}"/>
        <pole height="{$height2}"/>
        <pole height="{$height3}"/>
    </tower>
</xsl:template>

</xsl:stylesheet>
