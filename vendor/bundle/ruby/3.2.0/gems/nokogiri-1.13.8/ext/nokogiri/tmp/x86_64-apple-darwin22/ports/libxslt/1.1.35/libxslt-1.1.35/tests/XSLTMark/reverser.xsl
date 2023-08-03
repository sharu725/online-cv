<?xml version="1.0"?> 

<!-- string flipper -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="utf-8"/>

<xsl:template name="textflipper">
  <xsl:param name="instring" select='""'/>
 
  <xsl:variable name="firstword" select='substring-before($instring," ")'/>

  <xsl:choose>
    <xsl:when test="string-length($firstword) > 0">
      <xsl:call-template name="textflipper">
        <xsl:with-param name="instring" select="substring($instring,string-length($firstword)+2)"/>
      </xsl:call-template>
      <xsl:text> </xsl:text> 
      <xsl:value-of select="$firstword"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$instring"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="text()">
  <xsl:call-template name="textflipper">
    <xsl:with-param name="instring" select="normalize-space(.)"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>

