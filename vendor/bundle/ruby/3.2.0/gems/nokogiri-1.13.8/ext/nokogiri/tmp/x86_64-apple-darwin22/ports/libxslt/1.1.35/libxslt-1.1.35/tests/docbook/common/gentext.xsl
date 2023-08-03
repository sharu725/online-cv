<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                version='1.0'>

<!-- ============================================================ -->

<xsl:template match="*" mode="object.title.template">
  <xsl:call-template name="gentext.template">
    <xsl:with-param name="context" select="'title'"/>
    <xsl:with-param name="name" select="local-name(.)"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="section|sect1|sect2|sect3|sect4|sect5|simplesect"
              mode="object.title.template">
  <xsl:choose>
    <xsl:when test="$section.autolabel != 0">
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'section-title-numbered'"/>
        <xsl:with-param name="name" select="local-name(.)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'section-title'"/>
        <xsl:with-param name="name" select="local-name(.)"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="article/appendix"
              mode="object.title.template">
  <!-- FIXME: HACK HACK HACK! -->
  <xsl:text>%n. %t</xsl:text>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="*" mode="object.subtitle.template">
  <xsl:call-template name="gentext.template">
    <xsl:with-param name="context" select="'subtitle'"/>
    <xsl:with-param name="name" select="local-name(.)"/>
  </xsl:call-template>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="*" mode="object.xref.template">
  <xsl:call-template name="gentext.template">
    <xsl:with-param name="context" select="'xref'"/>
    <xsl:with-param name="name" select="local-name(.)"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="section|simplesect
                     |sect1|sect2|sect3|sect4|sect5
                     |refsect1|refsect2|refsect3"
              mode="object.xref.template">
  <xsl:choose>
    <xsl:when test="$section.autolabel != 0">
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'section-xref-numbered'"/>
        <xsl:with-param name="name" select="local-name(.)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'section-xref'"/>
        <xsl:with-param name="name" select="local-name(.)"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="*" mode="object.title.markup">
  <xsl:variable name="template">
    <xsl:apply-templates select="." mode="object.title.template"/>
  </xsl:variable>

<!--
  <xsl:message>
    <xsl:text>object.title.markup: </xsl:text>
    <xsl:value-of select="local-name(.)"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="$template"/>
  </xsl:message>
-->

  <xsl:call-template name="substitute-markup">
    <xsl:with-param name="allow-anchors" select="1"/>
    <xsl:with-param name="template" select="$template"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="*" mode="object.title.markup.textonly">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="object.title.markup"/>
  </xsl:variable>
  <xsl:value-of select="$title"/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="*" mode="object.subtitle.markup">
  <xsl:variable name="template">
    <xsl:apply-templates select="." mode="object.subtitle.template"/>
  </xsl:variable>

  <xsl:call-template name="substitute-markup">
    <xsl:with-param name="template" select="$template"/>
  </xsl:call-template>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="*" mode="object.xref.markup">
  <xsl:variable name="template">
    <xsl:apply-templates select="." mode="object.xref.template"/>
  </xsl:variable>

<!--
  <xsl:message>
    <xsl:text>object.xref.markup: </xsl:text>
    <xsl:value-of select="local-name(.)"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="$template"/>
  </xsl:message>
-->

  <xsl:call-template name="substitute-markup">
    <xsl:with-param name="template" select="$template"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="section|simplesect
                     |sect1|sect2|sect3|sect4|sect5
                     |refsect1|refsect2|refsect3"
              mode="object.xref.markup">
  <xsl:variable name="template">
    <xsl:apply-templates select="." mode="object.xref.template"/>
  </xsl:variable>

<!--
  <xsl:message>
    <xsl:text>object.xref.markup: </xsl:text>
    <xsl:value-of select="local-name(.)"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="$template"/>
  </xsl:message>
-->

  <xsl:call-template name="substitute-markup">
    <xsl:with-param name="template" select="$template"/>
  </xsl:call-template>
</xsl:template>

<!-- ============================================================ -->

<xsl:template name="substitute-markup">
  <xsl:param name="template" select="''"/>
  <xsl:param name="allow-anchors" select="'0'"/>
  <xsl:variable name="bef-n" select="substring-before($template, '%n')"/>
  <xsl:variable name="bef-s" select="substring-before($template, '%s')"/>
  <xsl:variable name="bef-t" select="substring-before($template, '%t')"/>

<!--
  <xsl:message>
    <xsl:text>sm: </xsl:text>
    <xsl:value-of select="name(.)"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$allow-anchors"/>
  </xsl:message>
-->

  <xsl:choose>
    <!-- n=1 -->
    <xsl:when test="starts-with($template, '%n')">
      <xsl:apply-templates select="." mode="label.markup"/>
      <xsl:call-template name="substitute-markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="template"
                        select="substring-after($template, '%n')"/>
      </xsl:call-template>
    </xsl:when>

    <!-- t=1 -->
    <xsl:when test="starts-with($template, '%t')">
      <xsl:apply-templates select="." mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
      </xsl:apply-templates>
      <xsl:call-template name="substitute-markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="template"
                        select="substring-after($template, '%t')"/>
      </xsl:call-template>
    </xsl:when>

    <!-- s=1 -->
    <xsl:when test="starts-with($template, '%s')">
      <xsl:apply-templates select="." mode="subtitle.markup"/>
      <xsl:call-template name="substitute-markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="template"
                        select="substring-after($template, '%s')"/>
      </xsl:call-template>
    </xsl:when>

    <!-- n and t and s -->
    <xsl:when test="contains($template, '%n')
                    and contains($template, '%t')
                    and contains($template, '%s')">
      <xsl:choose>
        <!-- n is first -->
        <xsl:when test="string-length($bef-n) &lt; string-length($bef-s)
                        and string-length($bef-n) &lt; string-length($bef-t)">
          <xsl:value-of select="$bef-n"/>
          <xsl:apply-templates select="." mode="label.markup"/>
          <xsl:call-template name="substitute-markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
            <xsl:with-param name="template"
                            select="substring-after($template, '%n')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- s is first -->
        <xsl:when test="string-length($bef-s) &lt; string-length($bef-n)
                        and string-length($bef-s) &lt; string-length($bef-t)">
          <xsl:value-of select="$bef-s"/>
          <xsl:apply-templates select="." mode="subtitle.markup"/>
          <xsl:call-template name="substitute-markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
            <xsl:with-param name="template"
                            select="substring-after($template, '%s')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- t must be first -->
        <xsl:otherwise>
          <xsl:value-of select="$bef-t"/>
          <xsl:apply-templates select="." mode="title.markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
          </xsl:apply-templates>
          <xsl:call-template name="substitute-markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
            <xsl:with-param name="template"
                            select="substring-after($template, '%t')"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- n and t -->
    <xsl:when test="contains($template, '%n')
                    and contains($template, '%t')">
      <xsl:choose>
        <!-- n is first -->
        <xsl:when test="string-length($bef-n) &lt; string-length($bef-t)">
          <xsl:value-of select="$bef-n"/>
          <xsl:apply-templates select="." mode="label.markup"/>
          <xsl:call-template name="substitute-markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
            <xsl:with-param name="template"
                            select="substring-after($template, '%n')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- t is first -->
        <xsl:otherwise>
          <xsl:value-of select="$bef-t"/>
          <xsl:apply-templates select="." mode="title.markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
          </xsl:apply-templates>
          <xsl:call-template name="substitute-markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
            <xsl:with-param name="template"
                            select="substring-after($template, '%t')"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- n and s -->
    <xsl:when test="contains($template, '%n')
                    and contains($template, '%s')">
      <xsl:choose>
        <!-- n is first -->
        <xsl:when test="string-length($bef-n) &lt; string-length($bef-s)">
          <xsl:value-of select="$bef-n"/>
          <xsl:apply-templates select="." mode="label.markup"/>
          <xsl:call-template name="substitute-markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
            <xsl:with-param name="template"
                            select="substring-after($template, '%n')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- s is first -->
        <xsl:otherwise>
          <xsl:value-of select="$bef-s"/>
          <xsl:apply-templates select="." mode="subtitle.markup"/>
          <xsl:call-template name="substitute-markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
            <xsl:with-param name="template"
                            select="substring-after($template, '%s')"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- t and s -->
    <xsl:when test="contains($template, '%t')
                    and contains($template, '%s')">
      <xsl:choose>
        <!-- t is first -->
        <xsl:when test="string-length($bef-t) &lt; string-length($bef-s)">
          <xsl:value-of select="$bef-t"/>
          <xsl:apply-templates select="." mode="title.markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
          </xsl:apply-templates>
          <xsl:call-template name="substitute-markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
            <xsl:with-param name="template"
                            select="substring-after($template, '%t')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- s is first -->
        <xsl:otherwise>
          <xsl:value-of select="$bef-s"/>
          <xsl:apply-templates select="." mode="subtitle.markup"/>
          <xsl:call-template name="substitute-markup">
            <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
            <xsl:with-param name="template"
                            select="substring-after($template, '%s')"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- n -->
    <xsl:when test="contains($template, '%n')">
      <xsl:value-of select="$bef-n"/>
      <xsl:apply-templates select="." mode="label.markup"/>
      <xsl:call-template name="substitute-markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="template"
                        select="substring-after($template, '%n')"/>
      </xsl:call-template>
    </xsl:when>

    <!-- t -->
    <xsl:when test="contains($template, '%t')">
      <xsl:value-of select="$bef-t"/>
      <xsl:apply-templates select="." mode="title.markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
      </xsl:apply-templates>
      <xsl:call-template name="substitute-markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="template"
                        select="substring-after($template, '%t')"/>
      </xsl:call-template>
    </xsl:when>

    <!-- s -->
    <xsl:when test="contains($template, '%s')">
      <xsl:value-of select="$bef-s"/>
      <xsl:apply-templates select="." mode="subtitle.markup"/>
      <xsl:call-template name="substitute-markup">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        <xsl:with-param name="template"
                        select="substring-after($template, '%s')"/>
      </xsl:call-template>
    </xsl:when>

    <!-- neither n nor t nor s -->
    <xsl:otherwise>
      <xsl:value-of select="$template"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->

</xsl:stylesheet>

