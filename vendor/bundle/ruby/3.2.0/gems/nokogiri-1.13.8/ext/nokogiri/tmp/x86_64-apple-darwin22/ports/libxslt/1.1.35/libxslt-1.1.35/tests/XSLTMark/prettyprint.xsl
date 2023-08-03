<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="utf-8"/>

  <xsl:template name="element">
    <xsl:param name="indent" select="0"/>
    <xsl:text>
</xsl:text>
    <!-- this next one's a real kludge!! -->
    <xsl:value-of select="substring ('                                                                                                ', 0, $indent * 3)"/>
    <xsl:choose>
      <xsl:when test="self::text()">
        <span class="text">
          <xsl:value-of select="normalize-space(.)"/>
        </span>
      </xsl:when>
      <xsl:when test="self::*">
        <span class="element">
          <xsl:value-of select="concat('&lt;',name(.),'&gt;')"/>
        </span>
        <xsl:for-each select="node()">
          <xsl:call-template name="element">
            <xsl:with-param name="indent">
              <xsl:value-of select="$indent + 1"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>              
        <xsl:text>
</xsl:text>
        <xsl:value-of select="substring ('                                                                                                ', 0, $indent * 3)"/>
        <span class="element">
          <xsl:value-of select="concat('&lt;/',name(.),'&gt;')"/>
        </span>
      </xsl:when>
    </xsl:choose>      
  </xsl:template>


  <xsl:template match="/">
    <html>
      <style>
body      { background-color: #ffffff; }
.element  { color: #447744; }
.text     { color: #774444; }
      </style>
      <body>
        <pre>
          <xsl:for-each select="node()">
            <xsl:call-template name="element">
              <xsl:with-param name="indent">
                1
              </xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>              
        </pre>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

