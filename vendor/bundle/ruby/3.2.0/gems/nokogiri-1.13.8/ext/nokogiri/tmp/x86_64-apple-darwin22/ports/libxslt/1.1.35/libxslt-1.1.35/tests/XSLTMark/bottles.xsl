<?xml version="1.0"?> 

<!-- bottles of beer by Cyrus Dolph May 16, 2000 -->

<!-- input template of form: <bottles>99</bottles> -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

   <xsl:output method="text" encoding="utf-8"/>

   <xsl:template name="bottles">
       <xsl:param name="bottles"/>
       <xsl:choose>
           <xsl:when test="$bottles = 1">
               <xsl:text>1 bottle</xsl:text>
           </xsl:when>
           <xsl:otherwise>
               <xsl:value-of select='concat ($bottles, " bottles")'/>
           </xsl:otherwise>
       </xsl:choose>
   </xsl:template>

   <xsl:template name="verse">
       <xsl:param name="bottles"/>
       <xsl:choose>
           <xsl:when test="$bottles = 0">
               <xsl:text>0 bottles of beer on the wall,
0 bottles of beer!
Go into town, buy a new round
Get some more bottles of beer on the wall!
</xsl:text>
           </xsl:when>
           <xsl:otherwise>
               <xsl:call-template name="bottles">
                   <xsl:with-param name="bottles" select="$bottles"/>
               </xsl:call-template>
               <xsl:text> of beer on the wall,
</xsl:text>
               <xsl:call-template name="bottles">
                   <xsl:with-param name="bottles" select="$bottles"/>
               </xsl:call-template>
               <xsl:text> of beer!
Take one down, pass it around;
</xsl:text>
               <xsl:call-template name="bottles">
                   <xsl:with-param name="bottles" select="$bottles - 1"/>
               </xsl:call-template>
               <xsl:text> of beer on the wall.

</xsl:text>
               <xsl:call-template name="verse">
                   <xsl:with-param name="bottles" select="$bottles - 1"/>
               </xsl:call-template>
           </xsl:otherwise>
       </xsl:choose>
   </xsl:template>
 
   <xsl:template match="/">
       <xsl:call-template name="verse">
           <xsl:with-param name="bottles" select="/bottles"/>
       </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>

