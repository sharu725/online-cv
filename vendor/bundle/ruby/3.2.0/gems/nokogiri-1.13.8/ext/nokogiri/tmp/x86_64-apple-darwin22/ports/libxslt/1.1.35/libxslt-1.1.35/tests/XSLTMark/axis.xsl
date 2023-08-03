<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="utf-8"/>

  <xsl:template match="EIGHT">
      <FOLLOWING>
          <xsl:value-of select="following::*[2]"/>
      </FOLLOWING>
      <PRECEDING>
          <xsl:value-of select="preceding::THREE"/>
      </PRECEDING>
      <EMPTY>
          <xsl:value-of select="preceding::TEN"/>
          <xsl:value-of select="preceding::ELEVEN"/>
          <xsl:value-of select="preceding::TOP"/>
      </EMPTY>
      <EMPTY>
          <xsl:value-of select="following::TWO"/>
          <xsl:value-of select="following::FOUR"/>
          <xsl:value-of select="following::ONE"/>
      </EMPTY>
      <ANCESTOR2>
          <xsl:value-of select="ancestor::*[2]"/>
      </ANCESTOR2>
      <TRICKY>
          <xsl:value-of select="parent::*/descendant::*[3]"/>
      </TRICKY>
  </xsl:template>
  <xsl:template match="NINE">
      <FOLLOWINGSIBLING1>
          <xsl:value-of select="following-sibling::*[1]"/>
      </FOLLOWINGSIBLING1>
      <FOLLOWINGSIBLING2>
          <xsl:value-of select="following-sibling::*[2]"/>
      </FOLLOWINGSIBLING2>
      <FOLLOWINGSIBLING3>
          <xsl:value-of select="following-sibling::*[3]"/>
      </FOLLOWINGSIBLING3>
  </xsl:template>
</xsl:stylesheet>

