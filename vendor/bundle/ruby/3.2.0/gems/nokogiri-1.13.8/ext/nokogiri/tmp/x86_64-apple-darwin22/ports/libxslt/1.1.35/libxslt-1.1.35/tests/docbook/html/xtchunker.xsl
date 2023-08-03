<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xt="http://www.jclark.com/xt"
                extension-element-prefixes="xt"
		version="1.0">

<!-- This stylesheet works with XT; for others use chunker.xsl -->

<!-- ==================================================================== -->

<xsl:template name="make-relative-filename">
  <xsl:param name="base.dir" select="'./'"/>
  <xsl:param name="base.name" select="''"/>

  <!-- XT makes chunks relative -->
  <xsl:choose>
    <xsl:when test="count(parent::*) = 0">
      <xsl:value-of select="concat($base.dir,$base.name)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$base.name"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="write.chunk">
  <xsl:param name="filename" select="''"/>
  <xsl:param name="method" select="'html'"/>
  <xsl:param name="encoding" select="'ISO-8859-1'"/>
  <xsl:param name="indent" select="'no'"/>
  <xsl:param name="content" select="''"/>

  <xsl:message>
    <xsl:text>Writing </xsl:text>
    <xsl:value-of select="$filename"/>
    <xsl:if test="name(.) != ''">
      <xsl:text> for </xsl:text>
      <xsl:value-of select="name(.)"/>
    </xsl:if>
  </xsl:message>

  <!-- apparently XT doesn't support AVTs for method and encoding -->
  <xsl:choose>
    <xsl:when test="$method = 'xml'">
      <xt:document href="{$filename}"
                   method="xml"
                   indent="{$indent}"
                   encoding="ISO-8859-1">
        <xsl:copy-of select="$content"/>
      </xt:document>
    </xsl:when>
    <xsl:when test="$method = 'text'">
      <xt:document href="{$filename}"
                   method="text"
                   indent="{$indent}"
                   encoding="ISO-8859-1">
        <xsl:copy-of select="$content"/>
      </xt:document>
    </xsl:when>
    <xsl:otherwise>
      <xt:document href="{$filename}"
                   method="html"
                   indent="{$indent}"
                   encoding="ISO-8859-1">
        <xsl:copy-of select="$content"/>
      </xt:document>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
