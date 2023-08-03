<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="ISO-8859-1" method="xml"/>

<xsl:variable name="targetId"></xsl:variable>
<xsl:variable name="action"></xsl:variable>
<xsl:template match="/">
<xsl:apply-templates select="*|@*"/>
</xsl:template>


<xsl:template name="toto">
<toto/>
</xsl:template>


<xsl:template name="add">
<xsl:param name="type"/>
<xsl:choose>
<xsl:when test="$type = 'toto'">
<xsl:call-template name="toto"/>
</xsl:when>
</xsl:choose> </xsl:template> <xsl:template name="copy">
<xsl:copy>
<xsl:apply-templates select="node()|@*"/>
</xsl:copy>
</xsl:template>
<xsl:template name="del">
<!-- effacer ! -->
</xsl:template>

<xsl:template match="*[attribute::id and @id='']">
<!-- attribute::type pour éviter de confondre l'absence d'attibute et
la valeur nulle -->
<xsl:choose>
<xsl:when test="$action='del'">
<xsl:call-template name="del"/>
</xsl:when>
<xsl:when test="$action='add'">
<xsl:call-template name="copy"/>
<xsl:call-template name="add">
<xsl:with-param name="type">toto</xsl:with-param>
</xsl:call-template>
</xsl:when>
<xsl:when test="$action='repl'">
<xsl:choose>
<xsl:when test="$action='del'">
<xsl:call-template name="del"/>
</xsl:when>
</xsl:choose>
<xsl:call-template name="add">
<xsl:with-param name="type">toto</xsl:with-param>
</xsl:call-template>
</xsl:when> </xsl:choose>
</xsl:template>

<!-- liste des elements qui peuvent être édités, donc attribut id -->

<xsl:template match="domain">
<xsl:copy>
<xsl:if test="not(@id)">
<xsl:attribute name="id"><xsl:value-of
select="generate-id()"/></xsl:attribute>
</xsl:if>
<xsl:attribute name="add">task</xsl:attribute>
<xsl:attribute name="del">domain</xsl:attribute>
<xsl:apply-templates select="node()|@*"/>
</xsl:copy>
</xsl:template>

<xsl:template match="name">
<xsl:copy>
<xsl:if test="not(@id)">
<xsl:attribute name="id"><xsl:value-of
select="generate-id()"/></xsl:attribute>
</xsl:if>
<xsl:attribute name="replace">PCDATA</xsl:attribute>
<xsl:apply-templates select="node()|@*"/>
</xsl:copy>
</xsl:template>


<xsl:template match="task">
<xsl:copy>
<xsl:if test="not(@id)">
<xsl:attribute name="id"><xsl:value-of
select="generate-id()"/></xsl:attribute>
</xsl:if>
<xsl:attribute name="replace">PCDATA</xsl:attribute>
<xsl:attribute name="add">task</xsl:attribute> <xsl:apply-templates select="node()|@*"/>
</xsl:copy>
</xsl:template>



<xsl:template match="*">
<xsl:copy>
<xsl:apply-templates select="node()|@*"/>
</xsl:copy>
</xsl:template>
<xsl:template match="@*">
<xsl:copy/>
</xsl:template>
</xsl:stylesheet>
