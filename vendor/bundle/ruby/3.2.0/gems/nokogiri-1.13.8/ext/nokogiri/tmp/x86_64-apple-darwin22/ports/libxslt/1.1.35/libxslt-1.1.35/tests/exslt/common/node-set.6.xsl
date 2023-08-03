<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
					 xmlns:exslt="http://exslt.org/common"
					 xmlns:set="http://exslt.org/sets"
                extension-element-prefixes="set">


	<xsl:output method="xml"/>
  
	<xsl:template match="document">
		<xsl:element name="document">
			<xsl:copy-of select="/document/metaproperties"/>
			<xsl:apply-templates select="/document/operator-stack/operator[@instruction=1]">
				<xsl:with-param name="selection-criteria">
					<xsl:copy-of select="/document/paradigm"/>
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="operand[@type='domain']">
		<xsl:param name="selection-criteria"/>
		<xsl:variable name="butterfly"><xsl:value-of select="."/></xsl:variable>
		<xsl:for-each select="/document/attributes/name[@name=$butterfly]/value">
			<xsl:variable name="koala"><xsl:value-of select="@value"/></xsl:variable>
			<xsl:variable name="pidgeon">
				<xsl:element name="paradigm">
					<xsl:copy-of select="exslt:node-set($selection-criteria)/paradigm/form[./attribute[@name=$butterfly and @value=$koala]]"/>
				</xsl:element>
			</xsl:variable>
			<xsl:if test="count(exslt:node-set($selection-criteria)/paradigm/form[./attribute[@name=$butterfly and @value=$koala]]) &gt; 0">
				<xsl:element name="node">
					<xsl:attribute name="heading"><xsl:value-of select="@value"/></xsl:attribute>
				</xsl:element>
				<xsl:element name="forms">
					<xsl:copy-of select="exslt:node-set($pidgeon)/paradigm/form"/>
				</xsl:element>
			</xsl:if>	
		</xsl:for-each>		
	</xsl:template>
	
	<xsl:template match="operand[@type='branch']">
		<xsl:param name="selection-criteria"/>
		<xsl:variable name="catapilla"><xsl:value-of select="."/></xsl:variable>
		<xsl:apply-templates select="/document/operator-stack/operator[@instruction=$catapilla]">
			<xsl:with-param name="selection-criteria">
				<xsl:copy-of select="$selection-criteria"/>
			</xsl:with-param>
		</xsl:apply-templates>	
	</xsl:template>

	<xsl:template match="operator[@opcode='tabular']">
		<xsl:param name="selection-criteria"/>
		
		<xsl:variable name="horizontal">
			<xsl:apply-templates select="operand[@arg='1']">
				<xsl:with-param name="selection-criteria">
					<xsl:copy-of select="$selection-criteria"/>
				</xsl:with-param>
			</xsl:apply-templates>	
		</xsl:variable>
		
		<xsl:variable name="vertical">
			<xsl:apply-templates select="operand[@arg='2']">
				<xsl:with-param name="selection-criteria">
					<xsl:copy-of select="$selection-criteria"/>
				</xsl:with-param>
			</xsl:apply-templates>	
		</xsl:variable>
		
		<!--	
		<xsl:element name="horizontal">
			<xsl:copy-of select="$horizontal"/>
		</xsl:element>
	
		<xsl:element name="vertical">
			<xsl:copy-of select="$vertical"/>
		</xsl:element>
		-->

		<xsl:element name="cells">
			<xsl:for-each select="exslt:node-set($horizontal)//forms">
				<xsl:variable name="horizontal-forms">
					<xsl:copy-of select="./form"/>
				</xsl:variable>
				
				<xsl:for-each select="exslt:node-set($vertical)//forms">
					<xsl:variable name="vertical-forms">
						<xsl:copy-of select="./form"/>
					</xsl:variable>
					<xsl:copy-of select="exslt:node-set($horizontal-forms)/form | exslt:node-set($vertical-forms)/form"/>
					<xsl:variable name="pidgeon">
						<xsl:element name="paradigm">
							<!--<xsl:copy-of select="$horizontal-forms[count(.|$vertical-forms)=count($vertical-forms)]"/>-->
							<!--<xsl:copy-of select="set:intersection($horizontal-forms, $vertical-forms)"/>-->
							<!--
							<xsl:call-template name="set:intersection">
							   <xsl:with-param name="nodes1" select="$horizontal-forms" />
								<xsl:with-param name="nodes2" select="$vertical-forms" />
							</xsl:call-template>
							-->
						</xsl:element>
					</xsl:variable>
					<xsl:copy-of select="$pidgeon"/>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:element>
		
	</xsl:template>
	
	<xsl:template match="operator[@opcode='hierarchical']">
		<xsl:param name="selection-criteria"/>
		<xsl:variable name="horse"><xsl:value-of select="@instruction"/></xsl:variable>
		<xsl:element name="node">
			<xsl:attribute name="heading"><xsl:value-of select="operand[@arg='1']"/></xsl:attribute>
			<xsl:variable name="grub"><xsl:value-of select="operand[@arg='1']"/></xsl:variable>
			
			<xsl:for-each select="/document/attributes/name[@name=$grub]/value">
				<xsl:variable name="koala"><xsl:value-of select="@value"/></xsl:variable>
				<xsl:variable name="pidgeon">
					<xsl:element name="paradigm">
						<xsl:copy-of select="exslt:node-set($selection-criteria)/paradigm/form[./attribute[@name=$grub and @value=$koala]]"/>
					</xsl:element>
				</xsl:variable>
				
				<xsl:if test="count(exslt:node-set($selection-criteria)/paradigm/form[./attribute[@name=$grub and @value=$koala]]) &gt; 0">
					<xsl:element name="node">
						<xsl:attribute name="heading"><xsl:value-of select="@value"/></xsl:attribute>
						<xsl:apply-templates select="/document/operator-stack/operator[@instruction=$horse]/operand[@arg='2']">
							<xsl:with-param name="selection-criteria">
								<xsl:copy-of select="$pidgeon"/>
							</xsl:with-param>
						</xsl:apply-templates>	
					</xsl:element>
				</xsl:if>
			</xsl:for-each>	
			
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>

