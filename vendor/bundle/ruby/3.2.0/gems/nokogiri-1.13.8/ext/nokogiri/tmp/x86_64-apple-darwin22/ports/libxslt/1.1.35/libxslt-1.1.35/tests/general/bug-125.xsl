<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:strip-space elements="*" />
  <xsl:output method="html" indent="no"/>

  <xsl:template match="/">
    <div class="errataset">
      <xsl:text>&#x0a;</xsl:text>
      <xsl:for-each select="errataset/errata">
        <xsl:sort select="@page" data-type="number" />
        <xsl:sort select="@paragraph" data-type="number" />
        <xsl:sort select="@line" data-type="number" />
        <xsl:apply-templates select="." />
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template name="errata" match="errata">
    <div class="errata"><xsl:text>&#x0a;</xsl:text>
      <xsl:call-template name="show-attributes" />
      <xsl:for-each select="*|text()">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </div><xsl:text>&#x0a;</xsl:text>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:if test="string-length(normalize-space(.))">
      <p style="clear: both; padding: 3px;">
        <xsl:value-of select="normalize-space(.)" />
      </p>
      <xsl:text>&#x0a;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="explanation" match="explanation">
    <blockquote class="explanation"><xsl:text>&#x0a;</xsl:text>
      <p><xsl:text>&#x0a;</xsl:text>
        <xsl:value-of select="normalize-space(text())" />
        <xsl:text>&#x0a;</xsl:text>
      </p><xsl:text>&#x0a;</xsl:text>
    </blockquote><xsl:text>&#x0a;</xsl:text>
  </xsl:template>

  <xsl:template name="show-attributes">
    <table class="location-type" cellspacing="0" cellpadding="2">
      <xsl:text>&#x0a;</xsl:text>
      <xsl:choose>
        <xsl:when test="@paragraph">
          <xsl:choose>
            <xsl:when test="@line">
              <tr>
                <td style="width: 15%;" class="page">Page: <xsl:value-of select="@page" /></td>
                <xsl:text>&#x0a;</xsl:text>
                <td style="width: 15%;" class="paragraph">Paragraph: <xsl:value-of select="@paragraph" /></td>
                <xsl:text>&#x0a;</xsl:text>
                <td style="width: 15%;" class="line">Line: <xsl:value-of select="@line" /></td>
                <xsl:text>&#x0a;</xsl:text>
                <td style="width: 55%;" class="type"><xsl:value-of select="@type" /></td>
                <xsl:text>&#x0a;</xsl:text>
              </tr><xsl:text>&#x0a;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <tr>
                <td style="width: 15%;" class="page">Page: <xsl:value-of select="@page" /></td>
                <xsl:text>&#x0a;</xsl:text>
                <td style="width: 15%;" class="paragraph">Paragraph: <xsl:value-of select="@paragraph" /></td>
                <xsl:text>&#x0a;</xsl:text>
                <td style="width: 70%;" class="type"><xsl:value-of select="@type" /></td>
                <xsl:text>&#x0a;</xsl:text>
              </tr><xsl:text>&#x0a;</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="@line">
          <tr><xsl:text>&#x0a;</xsl:text>
            <td style="width: 15%;" class="page">Page: <xsl:value-of select="@page" /></td>
            <xsl:text>&#x0a;</xsl:text>
            <td style="width: 15%;" class="line">Line: <xsl:value-of select="@line" /></td>
            <xsl:text>&#x0a;</xsl:text>
            <td style="width: 70%;" class="type"><xsl:value-of select="@type" /></td>
            <xsl:text>&#x0a;</xsl:text>
          </tr><xsl:text>&#x0a;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <tr>
            <td style="width: 15%;" class="page">Page: <xsl:value-of select="@page" /></td>
            <xsl:text>&#x0a;</xsl:text>
            <td style="width: 85%;" class="type"><xsl:value-of select="@type" /></td>
            <xsl:text>&#x0a;</xsl:text>
          </tr><xsl:text>&#x0a;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </table><xsl:text>&#x0a;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
