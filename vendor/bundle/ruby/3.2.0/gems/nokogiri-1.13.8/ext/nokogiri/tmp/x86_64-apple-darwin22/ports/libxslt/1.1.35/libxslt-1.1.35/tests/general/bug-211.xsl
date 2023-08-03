<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                xmlns:fn="http://exslt.org/functions"
                xmlns:adoc="http://asciidoc.org/"
                extension-element-prefixes="fn">

  <fn:function name="adoc:sanitize">
    <xsl:param name="id"/>
    <xsl:variable name="tmp" select="str:replace($id, '__', '_')"/>
    <xsl:choose>
      <xsl:when test="contains($tmp, '__')">
        <fn:result select="adoc:sanitize($tmp)"/>
      </xsl:when>
      <xsl:otherwise>
        <fn:result select="$id"/>
      </xsl:otherwise>
    </xsl:choose>
  </fn:function>

  <xsl:template match="*">
    <xsl:value-of select="adoc:sanitize('________')"/>
  </xsl:template>

</xsl:stylesheet>
