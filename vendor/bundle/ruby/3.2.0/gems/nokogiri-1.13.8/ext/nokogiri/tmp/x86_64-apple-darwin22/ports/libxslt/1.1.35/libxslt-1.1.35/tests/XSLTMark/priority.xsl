<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="utf-8"/>
  <xsl:template match="node" mode="keep">
    <node key="{@key}">
      <xsl:if test="left">
        <left>
          <xsl:apply-templates select="left/node" mode="keep"/>
        </left>
      </xsl:if>
      <xsl:if test="right">
        <right>
          <xsl:apply-templates select="right/node" mode="keep"/>
        </right>
      </xsl:if>
    </node>
  </xsl:template>

  <xsl:template match="*"/>  

  <xsl:template match="node">
    <xsl:choose>
      <xsl:when test="(left and not(right)) or (left/node/@key &lt; right/node/@key)">
        <node key="{left/node/@key}">
          <left>
            <xsl:apply-templates select="left/node"/>
          </left>
          <xsl:if test="right">
            <right>
              <xsl:apply-templates select="right/node" mode="keep"/>
            </right>
          </xsl:if>
        </node>
      </xsl:when>
      <xsl:when test="right">
        <node key="{right/node/@key}">
          <xsl:if test="left">
            <left>
              <xsl:apply-templates select="left/node" mode="keep"/>
            </left>
          </xsl:if>
          <right>
            <xsl:apply-templates select="right/node"/>
          </right>
        </node>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>