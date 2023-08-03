<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'> 

  <xsl:output encoding="utf-8"/>

  <xsl:template match="item">
      <item>
         <xsl:value-of select="@name"/>
         
      </item>
  </xsl:template>

  <xsl:template match="//blah">
      <first>
         <xsl:apply-templates select="//glossary/item[@name=current()/@ref]"/>
      </first>
      <second>
         <xsl:apply-templates select="//glossary/item[@name=./@ref]"/>
      </second>
      <third>
         <xsl:apply-templates select="//glossary/item[@name=@ref]"/>
      </third>
  </xsl:template>
</xsl:stylesheet>
