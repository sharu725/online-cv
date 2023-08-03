<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" encoding="utf-8"/>

<xsl:decimal-format name="default"/>

<xsl:decimal-format name="funky" 
  decimal-separator="&amp;" 
  grouping-separator="/"
  infinity="unfunity"
  minus-sign="_"
  NaN="(c'est nes pas un nombre)"
  percent="@"
  per-mille="!"
  zero-digit="x"
  digit="#"
  pattern-separator=";"/> 

<xsl:decimal-format name="dumb" digit="@" pattern-separator="R"/>

<xsl:template match="numbertest">
<xsl:apply-templates select="number"/>
</xsl:template>

<xsl:template match="number">
<xsl:text>
ONE </xsl:text><xsl:value-of select="format-number(., '##,##,00.##')"/>
<xsl:text>
TWO </xsl:text><xsl:value-of select="format-number(., '####000,00.##;000.00000')"/>
<xsl:text>
THREE </xsl:text><xsl:value-of select="format-number(., '%##0.00')"/>
<xsl:text>
FOUR </xsl:text><xsl:value-of select="format-number(., '?###0.00')"/>
<xsl:text>
FIVE </xsl:text><xsl:value-of select="format-number(., '##,##00,000.##;-000000000.0')"/>
<xsl:text>
SIX </xsl:text><xsl:value-of select="format-number(., 'abc0.00123')"/>
<xsl:text>
SEVEN </xsl:text><xsl:value-of select="format-number(., '-0;0')"/>
<xsl:text>
EIGHT </xsl:text><xsl:value-of select="format-number(., '-0;-0')"/>
<xsl:text>
NINE </xsl:text><xsl:value-of select="format-number(., '-0')"/>
<xsl:text>
</xsl:text>
</xsl:template>


</xsl:stylesheet>