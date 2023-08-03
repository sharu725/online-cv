<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ns1="urn:foo"
  exclude-result-prefixes="ns1">

  <xsl:import href="bug-190-imp.xsl"/>
  <xsl:output indent="yes"/>

  <xsl:template match="/">
    <result>
      <elem xsl:use-attribute-sets="ns1:set"/>
    </result>
  </xsl:template>

</xsl:stylesheet>
