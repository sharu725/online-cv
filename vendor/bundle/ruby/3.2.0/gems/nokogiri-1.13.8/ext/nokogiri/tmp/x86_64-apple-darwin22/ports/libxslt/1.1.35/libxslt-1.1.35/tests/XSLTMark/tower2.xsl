<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="towerheight">


  <xsl:output encoding="utf-8"/>


    <xsl:variable name="height">
        <xsl:value-of select="."/>
    </xsl:variable>

    <xsl:variable name="tower">
        <xsl:call-template name="initialize">
            <xsl:with-param name="height" select="$height"/>
        </xsl:call-template>
    </xsl:variable>

    <towers>
        <xsl:copy-of select="$tower"/>
        <xsl:call-template name="transferstack">
            <xsl:with-param name="tower" select="$tower"/>
            <xsl:with-param name="source" select="'left'"/>
            <xsl:with-param name="target" select="'center'"/>
            <xsl:with-param name="spare" select="'right'"/>
            <xsl:with-param name="howmany" select="$height"/>
        </xsl:call-template>
    </towers>

</xsl:template>

<xsl:template name="initialize">
    <xsl:param name="height"/>
    <tower>
        <leftstack>
            <xsl:call-template name="initstack">
                <xsl:with-param name="height" select="$height"/>
            </xsl:call-template>
        </leftstack>
        <centerstack/>
        <rightstack/>
    </tower>
</xsl:template>

<xsl:template name="initstack">
    <xsl:param name="height"/>
    <xsl:param name="size" select="0"/>
    <xsl:if test="$size > 0">
        <disc size="{$size}"/>
    </xsl:if>
    <xsl:if test="$size &lt; $height">
        <xsl:call-template name="initstack">
            <xsl:with-param name="height" select="$height"/>
            <xsl:with-param name="size" select="$size + 1"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="transferstack">
    <xsl:param name="tower"/>
    <xsl:param name="source"/>
    <xsl:param name="target"/>
    <xsl:param name="spare"/>
    <xsl:param name="howmany"/>

    <xsl:if test="$howmany > 0">

        <xsl:variable name="firstpart">
            <xsl:call-template name="transferstack">
                <xsl:with-param name="tower" select="$tower"/>
                <xsl:with-param name="source" select="$source"/>
                <xsl:with-param name="target" select="$spare"/>
                <xsl:with-param name="spare" select="$target"/>
                <xsl:with-param name="howmany" select="$howmany - 1"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="lasttower">
            <xsl:choose>
                <xsl:when test="$firstpart/tower[last()]">
                    <xsl:copy-of select="$firstpart/tower[last()]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="$tower"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="secondpart">
            <xsl:call-template name="transferdisc">
                <xsl:with-param name="tower" select="$lasttower"/>
                <xsl:with-param name="source" select="$source"/>
                <xsl:with-param name="target" select="$target"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:copy-of select="$firstpart"/>
        <xsl:copy-of select="$secondpart"/>

        <xsl:call-template name="transferstack">
            <xsl:with-param name="tower" select="$secondpart"/>
            <xsl:with-param name="source" select="$spare"/>
            <xsl:with-param name="target" select="$target"/>
            <xsl:with-param name="spare" select="$source"/>
            <xsl:with-param name="howmany" select="$howmany - 1"/>
        </xsl:call-template>

    </xsl:if>
</xsl:template>

<xsl:template name="transferdisc">
    <xsl:param name="tower"/>
    <xsl:param name="source"/>
    <xsl:param name="target"/>

    <xsl:variable name="disc">
        <xsl:choose>
            <xsl:when test="$source = 'left'">
                <xsl:copy-of select="$tower/tower/leftstack/disc[1]"/>
            </xsl:when>
            <xsl:when test="$source = 'center'">
                <xsl:copy-of select="$tower/tower/centerstack/disc[1]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$tower/tower/rightstack/disc[1]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="newleft">
        <xsl:choose>
            <xsl:when test="$source = 'left'">
                <leftstack>
                    <xsl:copy-of select="$tower/tower/leftstack/disc[position() > 1]"/>
                </leftstack>
            </xsl:when>
            <xsl:when test="$target = 'left'">
                <leftstack>
                    <xsl:copy-of select="$disc"/>
                    <xsl:copy-of select="$tower/tower/leftstack/disc"/>
                </leftstack>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$tower/tower/leftstack"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="newcenter">
        <xsl:choose>
            <xsl:when test="$source = 'center'">
                <centerstack>
                    <xsl:copy-of select="$tower/tower/centerstack/disc[position() > 1]"/>
                </centerstack>
            </xsl:when>
            <xsl:when test="$target = 'center'">
                <centerstack>
                    <xsl:copy-of select="$disc"/>
                    <xsl:copy-of select="$tower/tower/centerstack/disc"/>
                </centerstack>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$tower/tower/centerstack"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="newright">
        <xsl:choose>
            <xsl:when test="$source = 'right'">
                <rightstack>
                    <xsl:copy-of select="$tower/tower/rightstack/disc[position() > 1]"/>
                </rightstack>
            </xsl:when>
            <xsl:when test="$target = 'right'">
                <rightstack>
                    <xsl:copy-of select="$disc"/>
                    <xsl:copy-of select="$tower/tower/rightstack/disc"/>
                </rightstack>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$tower/tower/rightstack"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <tower>
        <xsl:copy-of select="$newleft"/>
        <xsl:copy-of select="$newcenter"/>
        <xsl:copy-of select="$newright"/>
    </tower>
</xsl:template>

</xsl:stylesheet>
