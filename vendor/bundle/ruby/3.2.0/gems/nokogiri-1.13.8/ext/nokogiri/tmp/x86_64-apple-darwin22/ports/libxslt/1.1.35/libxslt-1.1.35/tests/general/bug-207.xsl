<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:f="http://exslt.org/functions"
  extension-element-prefixes="f">

  <f:function name="f:f1">
    <xsl:param name="n"/>
    <xsl:for-each select="namespace::*">
      <xsl:sort/>
    </xsl:for-each>
    <xsl:choose>
        <xsl:when test="$n > 0">
            <f:result select="f:f1($n - 1)"/>
        </xsl:when>
        <xsl:otherwise>
            <f:result select="1"/>
        </xsl:otherwise>
    </xsl:choose>
  </f:function>

  <f:function name="f:f2">
    <xsl:for-each select="namespace::*">
      <xsl:sort/>
    </xsl:for-each>
    <f:result select="1"/>
  </f:function>

  <f:function name="f:f3">
    <xsl:for-each select="namespace::*">
      <xsl:sort/>
    </xsl:for-each>
    <f:result>
      <xsl:number/>
    </f:result>
  </f:function>

  <f:function name="f:f4">
    <xsl:for-each select="namespace::*">
      <xsl:sort/>
    </xsl:for-each>
    <f:result>
      <xsl:apply-templates/>
    </f:result>
  </f:function>

  <f:function name="f:f5">
    <xsl:for-each select="namespace::*">
      <xsl:sort/>
    </xsl:for-each>
    <f:result select="key('xxx', 'yyy')"/>
  </f:function>

  <xsl:template match="/*">
    <xsl:value-of select="f:f1(4)"/>
    <xsl:value-of select="f:f2()"/>
    <xsl:value-of select="f:f3()"/>
    <xsl:value-of select="f:f4()"/>
    <xsl:value-of select="f:f5()"/>
  </xsl:template>
</xsl:stylesheet>
