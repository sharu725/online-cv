<?xml version="1.0"?> 



<!--
<?xml version="1.0" encoding="ISO-8859-1"?>
Copyright (C) 1999 Capella Computers Ltd. 

Author: Oren Ben-Kiki
Date: 1999-06-14

This stylesheet is public domain. However, if you modify it or decide to use
it as part of an XSLT benchmark/testing suite, I'd appreciate it if you let
me know at oren@capella.co.il

-->

<!--

This XSL stylesheet will convert an XML document of the form:

<BoardSize>8</BoardSize>

Into an HTML document listing all 8x8 chess boards containing
8 queens such that no one threatens another.

It uses the 1999-04-21 XSLT draft version.

<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
                xmlns:html="http://www.w3.org/TR/REC-html40"
                default-space="strip"
                indent-results="no"
                result-ns="html">

-->



<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output encoding="utf-8"/>

<xsl:template match="BoardSize">
    <xsl:call-template name="PlaceQueenInRow">
        <xsl:with-param name="BoardSize" select="."/>
        <xsl:with-param name="PlacedQueens" select="'-'"/>
        <xsl:with-param name="Row" select="0"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="PlaceQueenInRow">
    <xsl:param name="BoardSize"/>
    <xsl:param name="PlacedQueens"/>
    <xsl:param name="Row"/>

    <xsl:choose>
        <xsl:when test="$Row = $BoardSize">
            <xsl:call-template name="PrintBoard">
                <xsl:with-param name="BoardSize" select="$BoardSize"/>
                <xsl:with-param name="PlacedQueens"
                           select="substring-after($PlacedQueens, '-')"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="PlaceQueenInColumn">
                <xsl:with-param name="BoardSize" select="$BoardSize"/>
                <xsl:with-param name="PlacedQueens" select="$PlacedQueens"/>
                <xsl:with-param name="Row" select="$Row"/>
                <xsl:with-param name="Column" select="0"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="PlaceQueenInColumn">
    <xsl:param name="BoardSize"/>
    <xsl:param name="PlacedQueens"/>
    <xsl:param name="Row"/>
    <xsl:param name="Column"/>

    <xsl:if test="$Column &lt; $BoardSize">
        <xsl:if test="not(contains(concat('-', $PlacedQueens, '-'),
                                   concat('-', $Column, '-')))">
            <xsl:call-template name="TestQueenPosition">
                <xsl:with-param name="BoardSize" select="$BoardSize"/>
                <xsl:with-param name="PlacedQueens">
                    <xsl:value-of select="$PlacedQueens"/>
                    <xsl:value-of select="$Column"/>
                    <xsl:text>-</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="Row" select="$Row"/>
                <xsl:with-param name="Column" select="$Column"/>
                <xsl:with-param name="TestQueens"
                           select="substring-after($PlacedQueens, '-')"/>
                <xsl:with-param name="Offset" select="$Row"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="PlaceQueenInColumn">
            <xsl:with-param name="BoardSize" select="$BoardSize"/>
            <xsl:with-param name="PlacedQueens" select="$PlacedQueens"/>
            <xsl:with-param name="Row" select="$Row"/>
            <xsl:with-param name="Column" select="$Column + 1"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="TestQueenPosition">
    <xsl:param name="BoardSize"/>
    <xsl:param name="PlacedQueens"/>
    <xsl:param name="Row"/>
    <xsl:param name="Column"/>
    <xsl:param name="TestQueens"/>
    <xsl:param name="Offset"/>

    <xsl:choose>
        <xsl:when test="not($TestQueens)">
            <xsl:call-template name="PlaceQueenInRow">
                <xsl:with-param name="BoardSize" select="$BoardSize"/>
                <xsl:with-param name="PlacedQueens" select="$PlacedQueens"/>
                <xsl:with-param name="Row" select="$Row + 1"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="NextQueen"
                          select="substring-before($TestQueens, '-')"/>
            <xsl:if test="not($Column = $NextQueen + $Offset)
                      and not($Column = $NextQueen - $Offset)">
                <xsl:call-template name="TestQueenPosition">
                    <xsl:with-param name="BoardSize" select="$BoardSize"/>
                    <xsl:with-param name="PlacedQueens" select="$PlacedQueens"/>
                    <xsl:with-param name="Row" select="$Row"/>
                    <xsl:with-param name="Column" select="$Column"/>
                    <xsl:with-param name="TestQueens"
                               select="substring-after($TestQueens, '-')"/>
                    <xsl:with-param name="Offset" select="$Offset - 1"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="PrintBoard">
    <xsl:param name="BoardSize"/>
    <xsl:param name="PlacedQueens"/>

    <xsl:element name="P"/>
    <xsl:element name="TABLE">
        <xsl:call-template name="PrintBoardRow">
            <xsl:with-param name="BoardSize" select="$BoardSize"/>
            <xsl:with-param name="ColumnInThisRow"
                       select="substring-before($PlacedQueens, '-')"/>
            <xsl:with-param name="ColumnsInOtherRows"
                       select="substring-after($PlacedQueens, '-')"/>
        </xsl:call-template>
    </xsl:element>
</xsl:template>

<xsl:template name="PrintBoardRow">
    <xsl:param name="BoardSize"/>
    <xsl:param name="ColumnInThisRow"/>
    <xsl:param name="ColumnsInOtherRows"/>

    <xsl:element name="TR">
        <xsl:call-template name="PrintBoardCell">
            <xsl:with-param name="CellsLeft" select="$BoardSize"/>
            <xsl:with-param name="QueenCell" select="$ColumnInThisRow"/>
        </xsl:call-template>
    </xsl:element>

    <xsl:if test="$ColumnsInOtherRows">
        <xsl:call-template name="PrintBoardRow">
            <xsl:with-param name="BoardSize" select="$BoardSize"/>
            <xsl:with-param name="ColumnInThisRow"
                       select="substring-before($ColumnsInOtherRows, '-')"/>
            <xsl:with-param name="ColumnsInOtherRows"
                       select="substring-after($ColumnsInOtherRows, '-')"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="PrintBoardCell">
    <xsl:param name="CellsLeft"/>
    <xsl:param name="QueenCell"/>

    <xsl:if test="not($CellsLeft = 0)">
        <xsl:element name="TD">
            <xsl:choose>
                <xsl:when test="$QueenCell = 0">Q</xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
            </xsl:choose>
        </xsl:element>
        <xsl:call-template name="PrintBoardCell">
            <xsl:with-param name="CellsLeft" select="$CellsLeft - 1"/>
            <xsl:with-param name="QueenCell" select="$QueenCell - 1"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
