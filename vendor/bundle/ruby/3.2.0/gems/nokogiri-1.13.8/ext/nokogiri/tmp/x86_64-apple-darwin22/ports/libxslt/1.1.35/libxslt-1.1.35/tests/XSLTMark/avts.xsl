<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output encoding="utf-8"/>

<xsl:template match="table">
  <table>
    <xsl:apply-templates/>
  </table>
</xsl:template>

<xsl:template match="row">
  <address id="{id}" 
           firstname="{firstname}"
           lastname="{lastname}"
           street="{street}"
           city="{city}"
           state="{state}"
           zip="{zip}"/>
</xsl:template>

</xsl:stylesheet>
