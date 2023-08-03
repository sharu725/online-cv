<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"/>
    <xsl:template match="/">
        <result>
            <number>
                <xsl:number format="1" value="3.51"/>
            </number>
            <number>
                <xsl:number format="1" value="-123.456"/>
            </number>
            <number>
                <!-- 2 ** 53 -->
                <xsl:number format="1" value="9007199254740992"/>
            </number>
            <number>
                <xsl:number format="a" value="3.51"/>
            </number>
            <number>
                <xsl:number format="a" value="-123.456"/>
            </number>
            <number>
                <xsl:number format="a" value="0"/>
            </number>
            <number>
                <xsl:number format="a" value="9007199254740992"/>
            </number>
            <number>
                <xsl:number format="I" value="3.51"/>
            </number>
            <number>
                <xsl:number format="I" value="-123.456"/>
            </number>
            <number>
                <xsl:number format="I" value="0"/>
            </number>
            <number>
                <xsl:number format="I" value="9007199254740992"/>
            </number>
        </result>
    </xsl:template>
</xsl:stylesheet>

