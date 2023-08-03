<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes"/>
    <xsl:template match="test">
        <results>
            <xsl:for-each select="formats/format">
                <format f="{.}">
                    <xsl:variable name="f" select="."/>
                    <xsl:for-each select="/test/values/value">
                        <value v="{.}">
                            <xsl:number value="." format="{$f}"/>
                        </value>
                    </xsl:for-each>
                </format>
            </xsl:for-each>
        </results>
    </xsl:template>
</xsl:stylesheet>
