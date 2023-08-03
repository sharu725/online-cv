<?xml version="1.0"?>

<xsl:transform
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="cp">
    <xsl:apply-templates select="c"/>
  </xsl:template>

  <xsl:template match="c">
    <p>
      <xsl:value-of select="document('../docs/bug-153.doc')/ch/v[@name=current()/v]"/>
    </p>
  </xsl:template>

  <xsl:key name="k" match="u/p" use="un"/>

</xsl:transform>
