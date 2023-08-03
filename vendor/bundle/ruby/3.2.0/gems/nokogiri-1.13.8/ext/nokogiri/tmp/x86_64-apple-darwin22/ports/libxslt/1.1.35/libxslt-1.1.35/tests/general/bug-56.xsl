<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
                exclude-result-prefixes="l"
                version="1.0">

<xsl:output method="xml"/>

<xsl:param name="local.l10n.xml" select="document('')"/>

<xsl:template match="doc">
  <xsl:variable name="lang" select="'en'"/>
  <xsl:variable name="dingbat" select="'nestedstartquote'"/>

    <xsl:text>LOCALES: </xsl:text>
    <xsl:value-of select="count(($local.l10n.xml//l:i18n/l:l10n[@language=$lang]/l:dingbat[@key=$dingbat])[1])"/>

  <xsl:variable name="local.l10n.dingbat">
    <xsl:value-of select="($local.l10n.xml//l:i18n/l:l10n[@language=$lang]/l:dingbat[@key=$dingbat])[1]"/>
  </xsl:variable>

    <xsl:text>
LOCALES2: </xsl:text>
    <xsl:value-of select="count($local.l10n.dingbat)"/>

</xsl:template>

</xsl:stylesheet>
