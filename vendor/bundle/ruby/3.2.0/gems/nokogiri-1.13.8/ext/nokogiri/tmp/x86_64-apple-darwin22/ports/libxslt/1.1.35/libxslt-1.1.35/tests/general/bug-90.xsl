<?xml version="1.0"?>
<!-- 
============================================================
This is a stylesheet that will create, for each input <fruit> element,
two output elements - <new-fruit1> and <new-fruit2> , each of
which should wrap the content of the the input fruit/site element
in a CDATA block.
<new-fruit1> does this 'properly' via  cdata-section-elements
<new-fruit2> does it with a workaround named template 'wrap-cdata'
============================================================
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" cdata-section-elements="new-fruit1" indent="yes"/>
  <xsl:template match="fruit-sites/fruit">
    <new-fruit1 type="{@type}">
      The site is at
      <xsl:value-of select="./site"/>
    </new-fruit1>
    <new-fruit2 type="{@type}">
      <xsl:call-template name="wrap-cdata">
        <xsl:with-param name="content">
	  The site is at <xsl:value-of select="./site"/>
        </xsl:with-param>
      </xsl:call-template>
    </new-fruit2>
  </xsl:template>

  <!-- Wrap $content in a CDATA block  -->
  <xsl:template name="wrap-cdata">
    <xsl:param name="content"/>
    <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text> <!--
    --><xsl:value-of disable-output-escaping="yes" select="$content"/> <!-- 
    --><xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
  </xsl:template>
</xsl:stylesheet>
