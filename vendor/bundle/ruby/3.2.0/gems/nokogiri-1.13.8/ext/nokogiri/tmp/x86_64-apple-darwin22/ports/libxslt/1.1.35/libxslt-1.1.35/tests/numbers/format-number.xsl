<xsl:stylesheet version="1.0"
	      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output
 method="xml"
 indent="yes"
 encoding="iso-8859-1"
/>

<xsl:decimal-format
 name = "special"
 decimal-separator = "*"
/>

<xsl:template match="/format-number">
  <format-number>
    <xsl:apply-templates/>
  </format-number>
</xsl:template>

<xsl:template match="/format-number/fixes">
  <fixes>
    one <xsl:value-of select="format-number(pi, 'prefix#,#,###.##suffix')"/>
    two <xsl:value-of select="format-number(negpi, '_#,#,###.##_')"/>
    three <xsl:value-of select="format-number(negpi, '_#,#,000.000##_')"/>
    four <xsl:value-of select="format-number(negpi, '_#.#_;_(#.#)_')"/>
    five <xsl:value-of select="format-number(pi, 'prefix#,#,###*##suffix','special')"/>
    <xsl:text>&#10;  </xsl:text>
  </fixes>
</xsl:template>

<xsl:template match="/format-number/point-test">
  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>,'#'  )<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'#')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>,'0'  )<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'0')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>, '.' )<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'.')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>,'#.' )<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'#.')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>,'0.' )<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'0.')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>, '.#')<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'.#')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>, '.##')<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'.##')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>, '.0')<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'.0')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>,'#.#')<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'#.#')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>,'0.0')<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'0.0')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>,'#.0')<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'#.0')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test><xsl:text>&#10;  </xsl:text>

  <point-test>
    <xsl:for-each select="number">
    format-number(<xsl:value-of select="."/>,'0.#')<xsl:text> = </xsl:text>
    <xsl:value-of select="format-number(.,'0.#')"/>
    </xsl:for-each>
    <xsl:text>&#10;  </xsl:text>
  </point-test>
</xsl:template>

</xsl:stylesheet>
