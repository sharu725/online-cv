<?xml version= "1.0"?>
                             
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>
<!--xsl:import href="test2.xsl"/-->

<xsl:template match="/">
<xsl:processing-instruction name="php">Success</xsl:processing-instruction>
</xsl:template>
   
</xsl:stylesheet>
