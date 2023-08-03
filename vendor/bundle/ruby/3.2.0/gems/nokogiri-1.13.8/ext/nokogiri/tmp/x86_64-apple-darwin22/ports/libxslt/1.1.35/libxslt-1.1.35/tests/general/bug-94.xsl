<xsl:stylesheet version = '1.0'
     xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
<!-- borrowed from http://www.zvon.org/xxl/XSLTutorial/Output/example35_ch9.html -->

<xsl:template match="/">
     <TABLE>
          <xsl:for-each select="//number">
               <TR>
                    <TH>
                         <xsl:choose>
                              <xsl:when test="text() mod 2">
                                   <xsl:apply-templates select=".">
                                        <xsl:with-param name="type">odd</xsl:with-param>
                                   </xsl:apply-templates>
                              </xsl:when>
                              <xsl:otherwise>
                                   <xsl:apply-templates select="."/>
                              </xsl:otherwise>
                         </xsl:choose>
                    </TH>
               </TR>
          </xsl:for-each>
     </TABLE>
</xsl:template>

<xsl:template match="number">
     <xsl:variable name="type">even</xsl:variable>
     <xsl:value-of select="."/>
     <xsl:text> (</xsl:text>
     <xsl:value-of select="$type"/>
     <xsl:text>)</xsl:text>
</xsl:template>


</xsl:stylesheet> 
