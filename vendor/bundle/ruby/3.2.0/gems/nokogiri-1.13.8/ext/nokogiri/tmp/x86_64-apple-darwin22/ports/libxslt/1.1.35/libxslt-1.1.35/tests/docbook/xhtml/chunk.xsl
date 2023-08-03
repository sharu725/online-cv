<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:mml="http://www.w3.org/1998/Math/MathML"
		version="1.0">

<!-- This stylesheet works with Saxon and Xalan; for XT use xtchunk.xsl -->

<xsl:import href="../html/chunk.xsl"/>

<xsl:param name="html.ext" select="'.xhtm'"/>

<xsl:output method="xml"/>

<xsl:template match="mml:*">
  <xsl:element name="{name(.)}">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
