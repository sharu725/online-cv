<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- generate text output as mime type model/vrml, using default charset -->
<xsl:output method="text" encoding="UTF-8" media-type="model/vrml"/>  

        <xsl:template match="/">#VRML V2.0 utf8 
 
# externproto definition of a single bar element 
EXTERNPROTO bar [ 
  field SFInt32 x  
  field SFInt32 y  
  field SFInt32 z  
  field SFString name  
  ] 
  "http://www.vrml.org/WorkingGroups/dbwork/barProto.wrl" 
 
# inline containing the graph axes 
Inline {  
        url "http://www.vrml.org/WorkingGroups/dbwork/barAxes.wrl" 
        } 
        
                <xsl:for-each select="sales/division">
bar {
        x <xsl:value-of select="revenue"/>
        y <xsl:value-of select="growth"/>
        z <xsl:value-of select="bonus"/>
        name "<xsl:value-of select="@id"/>" 
        }
                </xsl:for-each>
        
        </xsl:template> 
 
</xsl:stylesheet>
