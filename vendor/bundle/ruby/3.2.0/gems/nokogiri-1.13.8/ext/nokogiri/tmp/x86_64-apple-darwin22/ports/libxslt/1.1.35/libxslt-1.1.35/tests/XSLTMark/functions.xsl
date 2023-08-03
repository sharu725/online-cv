<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="utf-8"/>

  <xsl:template match="table">
    <xsl:for-each select="row">
      <xsl:text>
      </xsl:text>
      <person>
        <xsl:value-of select="concat(firstname, ' ', lastname)"/>
        <xsl:value-of select="string-length(firstname)"/>
        <!-- rot13 -->
        <xsl:value-of select="translate(firstname,
                              'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
                              'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM')"/>
        <xsl:value-of select="sum(preceding-sibling::row/id)"/>
        <xsl:value-of select="floor(id div 17)"/>
        <xsl:value-of select="ceiling(id*3.1415)"/>
        <xsl:value-of select="substring(lastname,4,3)"/>
      </person>
      <extra>
        <xsl:if test="starts-with(id,'001')">
          <xsl:value-of select="zip"/>
        </xsl:if>
        <xsl:if test="contains(lastname,'k')">
          <xsl:value-of select="substring-after(lastname,'k')"/>
        </xsl:if>
      </extra>



    </xsl:for-each>
    <xsl:text>
    </xsl:text>

  </xsl:template>

</xsl:stylesheet>


