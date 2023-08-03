<xsl:transform
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl">

  <xsl:key name="k" match="a" use="@x"/>

  <xsl:template match="/">
    <xsl:variable name="v">
      <n>
        <a x="1" y="A"/>
        <a x="2" y="B"/>
      </n>
    </xsl:variable>
    <xsl:apply-templates select="exsl:node-set($v)/*"/>
  </xsl:template>

  <xsl:template match="n">
<!--    <xsl:apply-templates select="a[@x='1']"/> -->
    <xsl:apply-templates select="key('k','1')"/>
  </xsl:template>

  <xsl:template match="a">
    <xsl:value-of select="@y"/>
  </xsl:template>

</xsl:transform>
