<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
		version="1.1"
                exclude-result-prefixes="doc"
                extension-element-prefixes="saxon xalanredirect lxslt">

<!-- This stylesheet works with Saxon and Xalan; for XT use xtchunker.xsl -->

<!-- ==================================================================== -->

<xsl:template name="make-relative-filename">
  <xsl:param name="base.dir" select="'./'"/>
  <xsl:param name="base.name" select="''"/>

  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:choose>
    <xsl:when test="contains($vendor, 'SAXON')">
      <!-- Saxon doesn't make the chunks relative -->
      <xsl:value-of select="concat($base.dir,$base.name)"/>
    </xsl:when>
    <xsl:when test="contains($vendor, 'Apache')">
      <!-- Xalan doesn't make the chunks relative -->
      <xsl:value-of select="concat($base.dir,$base.name)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message terminate="yes">
        <xsl:text>Chunking isn't supported with </xsl:text>
        <xsl:value-of select="$vendor"/>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="write.chunk">
  <xsl:param name="filename" select="''"/>
  <xsl:param name="method" select="'html'"/>
  <xsl:param name="encoding" select="$default.encoding"/>
  <xsl:param name="indent" select="'no'"/>
  <xsl:param name="content" select="''"/>

  <xsl:message>
    <xsl:text>Writing </xsl:text>
    <xsl:value-of select="$filename"/>
    <xsl:if test="name(.) != ''">
      <xsl:text> for </xsl:text>
      <xsl:value-of select="name(.)"/>
      <xsl:if test="@id">
        <xsl:text>(</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>)</xsl:text>
      </xsl:if>
    </xsl:if>
  </xsl:message>

  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:choose>
    <xsl:when test="contains($vendor, 'SAXON 6.2')">
      <!-- Saxon 6.2.x uses xsl:document -->
      <xsl:document href="{$filename}"
                    method="{$method}"
                    encoding="{$encoding}"
                    indent="{$indent}"
                    saxon:character-representation="{$saxon.character.representation}">
        <xsl:copy-of select="$content"/>
      </xsl:document>
    </xsl:when>
    <xsl:when test="contains($vendor, 'SAXON')">
      <!-- Saxon uses saxon:output -->
      <saxon:output file="{$filename}"
                    href="{$filename}"
                    method="{$method}"
                    encoding="{$encoding}"
                    indent="{$indent}"
                    saxon:character-representation="{$saxon.character.representation}">
        <xsl:copy-of select="$content"/>
      </saxon:output>
    </xsl:when>
    <xsl:when test="contains($vendor, 'Apache')">
      <!-- Xalan uses xalanredirect -->
      <xalanredirect:write file="{$filename}">
        <xsl:copy-of select="$content"/>
      </xalanredirect:write>
    </xsl:when>
    <xsl:otherwise>
      <!-- it doesn't matter since we won't be making chunks... -->
      <xsl:message terminate="yes">
        <xsl:text>Can't make chunks with </xsl:text>
        <xsl:value-of select="$vendor"/>
        <xsl:text>'s processor.</xsl:text>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="write.chunk.with.doctype">
  <xsl:param name="filename" select="''"/>
  <xsl:param name="method" select="'html'"/>
  <xsl:param name="encoding" select="$default.encoding"/>
  <xsl:param name="indent" select="'no'"/>
  <xsl:param name="doctype-public" select="''"/>
  <xsl:param name="doctype-system" select="''"/>
  <xsl:param name="content" select="''"/>

  <xsl:message>
    <xsl:text>Writing </xsl:text>
    <xsl:value-of select="$filename"/>
    <xsl:if test="name(.) != ''">
      <xsl:text> for </xsl:text>
      <xsl:value-of select="name(.)"/>
    </xsl:if>
  </xsl:message>

  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:choose>
    <xsl:when test="contains($vendor, 'SAXON 6.2')">
      <!-- Saxon 6.2.x uses xsl:document -->
      <xsl:document href="{$filename}"
                    method="{$method}"
                    encoding="{$encoding}"
                    indent="{$indent}"
                    doctype-public="{$doctype-public}"
                    doctype-system="{$doctype-system}"
                    saxon:character-representation="{$saxon.character.representation}">
        <xsl:copy-of select="$content"/>
      </xsl:document>
    </xsl:when>
    <xsl:when test="contains($vendor, 'SAXON')">
      <!-- Saxon uses saxon:output -->
      <saxon:output file="{$filename}"
                    href="{$filename}"
                    method="{$method}"
                    encoding="{$encoding}"
                    indent="{$indent}"
                    doctype-public="{$doctype-public}"
                    doctype-system="{$doctype-system}"
                    saxon:character-representation="{$saxon.character.representation}">
        <xsl:copy-of select="$content"/>
      </saxon:output>
    </xsl:when>
    <xsl:when test="contains($vendor, 'Apache')">
      <!-- Xalan uses xalanredirect -->
      <xalanredirect:write file="{$filename}">
        <xsl:copy-of select="$content"/>
      </xalanredirect:write>
    </xsl:when>
    <xsl:otherwise>
      <!-- it doesn't matter since we won't be making chunks... -->
      <xsl:message terminate="yes">
        <xsl:text>Can't make chunks with </xsl:text>
        <xsl:value-of select="$vendor"/>
        <xsl:text>'s processor.</xsl:text>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
