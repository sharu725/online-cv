<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:g="http://glandium.org/" xmlns:日本語="http://glandium.org/nihongo/" xmlns:date="http://exslt.org/dates-and-times" exclude-result-prefixes="g 日本語 date">

  <xsl:template match="g:posts">
    <html xml:lang="fr">
      <body>
        <xsl:apply-templates select="*"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="g:posts/g:post[g:date]">
    <xsl:variable name="id" select="@id"/>
    <xsl:variable name="date" select="concat(substring(g:date,1,4),'/',substring(g:date,5,2),'/',substring(g:date,7,2))"/>

    <div id="post{$id}">
      <xsl:if test="lang(ja)">
        <xsl:attribute name="xml:lang">ja</xsl:attribute>
      </xsl:if>
      <h3><a href="{$date}/{$id}">
        <xsl:apply-templates select="g:title"/>
      </a></h3>
      <xsl:apply-templates select="g:content"/>
    </div>
  </xsl:template>

  <xsl:template match="g:post/g:title">
    <xsl:apply-templates mode="日本語" select="."/>
  </xsl:template>

  <xsl:template match="g:post/g:content">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="g:content/g:para">
    <p><xsl:apply-templates mode="link" select="."/></p>
  </xsl:template>

  <xsl:template match="g:para/g:span|g:item/g:span|g:span/g:span">
    <xsl:apply-templates mode="link" select="."/>
  </xsl:template>

  <xsl:template match="g:content/g:list|g:item/g:list">
    <ul><xsl:apply-templates mode="link" select="."/></ul>
  </xsl:template>

  <xsl:template match="g:list/g:item">
    <li><xsl:apply-templates mode="link" select="."/></li>
  </xsl:template>

  <xsl:template match="g:span[@href]|g:para[@href]|g:item[@href]" mode="link">
    <a href="{@href}">
      <xsl:apply-templates mode="日本語" select="."/>
    </a>
  </xsl:template>

  <xsl:template match="*" mode="link">
    <xsl:apply-templates mode="日本語" select="."/>
  </xsl:template>

  <xsl:template match="*" mode="日本語">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*[lang('ja') and not(ancestor::*[@xml:lang='ja'])]" mode="日本語">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="g:span[lang('ja') and not (ancestor::*[@xml:lang='ja'])][not(@href)]" mode="日本語">
    <span xml:lang="ja">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="*[lang('fr')]" mode="日本語">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="g:span[lang('fr')][not(@href)]" mode="日本語">
    <span xml:lang="fr">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>
