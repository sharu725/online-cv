<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:func="http://exslt.org/functions" xmlns:abc="DEF" version="1.0" extension-element-prefixes="func">
  <func:function name="abc:f">
    <xsl:element name="elem"/>
  </func:function>
  <xsl:variable name="v" select="abc:f()"/>
</xsl:stylesheet>
