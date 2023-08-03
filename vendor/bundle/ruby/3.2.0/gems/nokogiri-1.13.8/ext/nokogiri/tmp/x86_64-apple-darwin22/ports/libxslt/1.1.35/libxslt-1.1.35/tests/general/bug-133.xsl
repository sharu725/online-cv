<xsl:stylesheet version="1.0"	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" />

<xsl:key name="next-headings" match="h2"
	use="generate-id(preceding-sibling::h1[1])" />

<xsl:key name="immediate-nodes"
	match="node()[not(self::h1 | self::h2)]"
	use="generate-id(preceding-sibling::*[self::h1 or self::h2][1])" />

<xsl:template match="h1 | h2">
	<hintsection>
		<hinttitle><xsl:apply-templates /></hinttitle>
		<xsl:apply-templates
			select="key('immediate-nodes', generate-id(.))" />
		<xsl:apply-templates select="key('next-headings', generate-id(.))" />
	</hintsection>
</xsl:template>

<xsl:template match="node()|@*">
	<xsl:copy>
		<xsl:apply-templates select="node()|@*"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="body">
	<xsl:copy>
		<xsl:apply-templates select="(h1|h2)[1]" />
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
