<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:sverb="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Verbatim"
                xmlns:xverb="com.nwalsh.xalan.Verbatim"
                xmlns:lxslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="sverb xverb lxslt"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<lxslt:component prefix="xverb"
                 functions="numberLines"/>

<xsl:template match="programlisting|screen|synopsis">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <xsl:if test="@id">
    <a href="{$id}"/>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="$suppress-numbers = '0'
                    and @linenumbering = 'numbered'
                    and $use.extensions != '0'
                    and $linenumbering.extension != '0'">
      <xsl:variable name="rtf">
        <xsl:apply-templates/>
      </xsl:variable>
      <pre class="{name(.)}">
        <xsl:call-template name="number.rtf.lines">
          <xsl:with-param name="rtf" select="$rtf"/>
        </xsl:call-template>
      </pre>
    </xsl:when>
    <xsl:otherwise>
      <pre class="{name(.)}">
        <xsl:apply-templates/>
      </pre>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="literallayout">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:variable name="rtf">
    <xsl:apply-templates/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$suppress-numbers = '0'
                    and @linenumbering = 'numbered'
                    and $use.extensions != '0'
                    and $linenumbering.extension != '0'">
      <xsl:choose>
        <xsl:when test="@class='monospaced'">
          <pre class="{name(.)}">
            <xsl:call-template name="number.rtf.lines">
              <xsl:with-param name="rtf" select="$rtf"/>
            </xsl:call-template>
          </pre>
        </xsl:when>
        <xsl:otherwise>
          <div class="{name(.)}">
            <xsl:call-template name="number.rtf.lines">
              <xsl:with-param name="rtf" select="$rtf"/>
            </xsl:call-template>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="@class='monospaced'">
          <pre class="{name(.)}">
            <xsl:copy-of select="$rtf"/>
          </pre>
        </xsl:when>
        <xsl:otherwise>
          <div class="{name(.)}">
            <xsl:copy-of select="$rtf"/>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="literallayout[not(@class)
                                   or @class != 'monospaced']//text()">
  <xsl:call-template name="make-verbatim">
    <xsl:with-param name="text" select="."/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="address">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:variable name="rtf">
    <xsl:apply-templates/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$suppress-numbers = '0'
                    and @linenumbering = 'numbered'
                    and $use.extensions != '0'
                    and $linenumbering.extension != '0'">
      <div class="{name(.)}">
        <xsl:call-template name="number.rtf.lines">
          <xsl:with-param name="rtf" select="$rtf"/>
        </xsl:call-template>
      </div>
    </xsl:when>

    <xsl:otherwise>
      <div class="{name(.)}">
        <xsl:apply-templates/>
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="number.rtf.lines">
  <xsl:param name="rtf" select="''"/>
  <xsl:param name="pi.context" select="."/>

  <!-- Save the global values -->
  <xsl:variable name="global.linenumbering.everyNth"
                select="$linenumbering.everyNth"/>

  <xsl:variable name="global.linenumbering.separator"
                select="$linenumbering.separator"/>

  <xsl:variable name="global.linenumbering.width"
                select="$linenumbering.width"/>

  <!-- Extract the <?dbhtml linenumbering.*?> PI values -->
  <xsl:variable name="pi.linenumbering.everyNth">
    <xsl:call-template name="dbhtml-attribute">
      <xsl:with-param name="pis"
                      select="$pi.context/processing-instruction('dbhtml')"/>
      <xsl:with-param name="attribute" select="'linenumbering.everyNth'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="pi.linenumbering.separator">
    <xsl:call-template name="dbhtml-attribute">
      <xsl:with-param name="pis"
                      select="$pi.context/processing-instruction('dbhtml')"/>
      <xsl:with-param name="attribute" select="'linenumbering.separator'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="pi.linenumbering.width">
    <xsl:call-template name="dbhtml-attribute">
      <xsl:with-param name="pis"
                      select="$pi.context/processing-instruction('dbhtml')"/>
      <xsl:with-param name="attribute" select="'linenumbering.width'"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- Construct the 'in-context' values -->
  <xsl:variable name="linenumbering.everyNth">
    <xsl:choose>
      <xsl:when test="$pi.linenumbering.everyNth != ''">
        <xsl:value-of select="$pi.linenumbering.everyNth"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$global.linenumbering.everyNth"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="linenumbering.separator">
    <xsl:choose>
      <xsl:when test="$pi.linenumbering.separator != ''">
        <xsl:value-of select="$pi.linenumbering.separator"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$global.linenumbering.separator"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="linenumbering.width">
    <xsl:choose>
      <xsl:when test="$pi.linenumbering.width != ''">
        <xsl:value-of select="$pi.linenumbering.width"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$global.linenumbering.width"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:choose>
    <xsl:when test="contains($vendor, 'SAXON ')">
      <xsl:copy-of select="sverb:numberLines($rtf)"/>
    </xsl:when>
    <xsl:when test="contains($vendor, 'Apache Software Foundation')">
      <xsl:copy-of select="xverb:numberLines($rtf)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message terminate="yes">
        <xsl:text>Don't know how to do line numbering with </xsl:text>
        <xsl:value-of select="$vendor"/>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="address//text()">
  <xsl:call-template name="make-verbatim">
    <xsl:with-param name="text" select="."/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="make-verbatim">
  <xsl:param name="text" select="''"/>

  <xsl:variable name="starts-with-space"
                select="substring($text, 1, 1) = ' '"/>

  <xsl:variable name="starts-with-nl"
                select="substring($text, 1, 1) = '&#xA;'"/>

  <xsl:variable name="before-space">
    <xsl:if test="contains($text, ' ')">
      <xsl:value-of select="substring-before($text, ' ')"/>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="before-nl">
    <xsl:if test="contains($text, '&#xA;')">
      <xsl:value-of select="substring-before($text, '&#xA;')"/>
    </xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$starts-with-space">
      <xsl:text>&#160;</xsl:text>
      <xsl:call-template name="make-verbatim">
        <xsl:with-param name="text" select="substring($text,2)"/>
      </xsl:call-template>
    </xsl:when>

    <xsl:when test="$starts-with-nl">
      <br/><xsl:text>&#xA;</xsl:text>
      <xsl:call-template name="make-verbatim">
        <xsl:with-param name="text" select="substring($text,2)"/>
      </xsl:call-template>
    </xsl:when>

    <!-- if the string before a space is shorter than the string before
         a newline, fix the space...-->
    <xsl:when test="$before-space != ''
                    and ((string-length($before-space)
                          &lt; string-length($before-nl))
                          or $before-nl = '')">
      <xsl:value-of select="$before-space"/>
      <xsl:text>&#160;</xsl:text>
      <xsl:call-template name="make-verbatim">
        <xsl:with-param name="text" select="substring-after($text, ' ')"/>
      </xsl:call-template>
    </xsl:when>

    <!-- if the string before a newline is shorter than the string before
         a space, fix the newline...-->
    <xsl:when test="$before-nl != ''
                    and ((string-length($before-nl)
                          &lt; string-length($before-space))
                          or $before-space = '')">
      <xsl:value-of select="$before-nl"/>
      <br/><xsl:text>&#xA;</xsl:text>
      <xsl:call-template name="make-verbatim">
        <xsl:with-param name="text" select="substring-after($text, '&#xA;')"/>
      </xsl:call-template>
    </xsl:when>

    <!-- the string before the newline and the string before the
         space are the same; which means they must both be empty -->
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
