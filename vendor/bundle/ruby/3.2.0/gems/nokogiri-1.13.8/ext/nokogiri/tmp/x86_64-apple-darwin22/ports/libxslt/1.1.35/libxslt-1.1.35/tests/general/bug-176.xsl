<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:msxsl="urn:schemas-microsoft-com:xslt"
               exclude-result-prefixes="msxsl"
               version="1.0">
    <xsl:template match="/">
        <result>
            <xsl:value-of select="system-property('msxsl:version')"/>
        </result>
    </xsl:template>
</xsl:transform>
