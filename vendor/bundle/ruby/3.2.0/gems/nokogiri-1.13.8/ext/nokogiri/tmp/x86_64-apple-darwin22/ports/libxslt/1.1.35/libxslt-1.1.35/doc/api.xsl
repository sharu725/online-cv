<?xml version="1.0"?>
<!-- this stylesheet builds the API*.html , it works based on libxml2-refs.xml
  -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  exclude-result-prefixes="exsl">

  <!-- Import the rest of the site stylesheets -->
  <xsl:import href="site.xsl"/>

  <!-- Generate XHTML-1.0 transitional -->
  <xsl:output method="xml" encoding="ISO-8859-1" indent="yes"
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

  <xsl:param name="libname" select="'libxslt'"/>
  <xsl:param name="dirname" select="''"/>
  <xsl:param name="logo_base" select="''"/> 

  <!-- href_base controls URI's in site.xsl as well as this stylesheet -->
  <xsl:variable name="href_base" select="''"/>

  <xsl:variable name="apirefs" select="document(concat($dirname, $libname, '-refs.xml'))"/>
  <xsl:variable name="module" select="$apirefs/apirefs/@name"/>
  <xsl:key name="refhref" match="reference" use="@name"/>

  <xsl:template match="ref" mode="anchor">
    <xsl:variable name="name" select="@name"/>
    <xsl:for-each select="document(concat($dirname, $libname, '-refs.xml'))">
	<a href="{key('refhref', $name)/@href}"><xsl:value-of select="$name"/></a><br/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="type" mode="reflist">
    <h2>Type <xsl:value-of select="@name"/>:</h2>
    <p>
      <xsl:for-each select="ref">
        <xsl:apply-templates mode="anchor" select="."/>
	<xsl:text>
</xsl:text>
      </xsl:for-each>
    </p>
  </xsl:template>

  <xsl:template match="letter" mode="reflist">
    <h2>Letter <xsl:value-of select="@name"/>:</h2>
    <p>
      <xsl:for-each select="ref">
        <xsl:apply-templates mode="anchor" select="."/>
	<xsl:text>
</xsl:text>
      </xsl:for-each>
    </p>
  </xsl:template>

  <xsl:template match="file" mode="reflist">
    <h2><a name="{@name}">Module <xsl:value-of select="@name"/></a>:</h2>
    <p>
      <xsl:for-each select="ref">
        <xsl:apply-templates mode="anchor" select="."/>
	<xsl:text>
</xsl:text>
      </xsl:for-each>
    </p>
  </xsl:template>
  <xsl:template match="letter" mode="wordlist">
    <h2>Letter <xsl:value-of select="@name"/>:</h2>
    <dl>
      <xsl:for-each select="word">
        <dt><xsl:value-of select="@name"/></dt>
	<dd>
	<xsl:for-each select="ref">
	  <xsl:apply-templates mode="anchor" select="."/>
	  <xsl:text>
</xsl:text>
	</xsl:for-each>
	</dd>
      </xsl:for-each>
    </dl>
  </xsl:template>

  <xsl:template match="constructors">
    <xsl:message>Generating API Constructors</xsl:message>
    <xsl:variable name="title">List of constructors for <xsl:value-of select="$module"/></xsl:variable>
    <xsl:variable name="doref">
      <xsl:apply-templates mode="reflist" select="type"/>
    </xsl:variable>
    <xsl:call-template name="new_page">
      <xsl:with-param name="filename" select="'APIconstructors.html'"/>
      <xsl:with-param name="title" select="$title"/>
      <xsl:with-param name="target" select="$doref"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="files">
    <xsl:message>Generating API List of symbols per file</xsl:message>
    <xsl:variable name="title">List of Symbols per Module for <xsl:value-of select="$module"/></xsl:variable>
    <xsl:variable name="doref">
      <xsl:apply-templates mode="reflist" select="file"/>
    </xsl:variable>
    <xsl:call-template name="new_page">
      <xsl:with-param name="filename" select="'APIfiles.html'"/>
      <xsl:with-param name="title" select="$title"/>
      <xsl:with-param name="target" select="$doref"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="functions">
    <xsl:message>Generating API Functions by Type</xsl:message>
    <xsl:variable name="title">List of function manipulating types in <xsl:value-of select="$module"/></xsl:variable>
    <xsl:variable name="doref">
      <xsl:apply-templates mode="reflist" select="type"/>
    </xsl:variable>
    <xsl:call-template name="new_page">
      <xsl:with-param name="filename" select="'APIfunctions.html'"/>
      <xsl:with-param name="title" select="$title"/>
      <xsl:with-param name="target" select="$doref"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="alpha">
    <xsl:message>Generating API Alphabetic list</xsl:message>
    <xsl:variable name="title">Alphabetic List of Symbols in <xsl:value-of select="$module"/></xsl:variable>
    <xsl:variable name="doref">
      <xsl:apply-templates mode="reflist" select="letter"/>
    </xsl:variable>
    <xsl:call-template name="new_page">
      <xsl:with-param name="filename" select="'APIsymbols.html'"/>
      <xsl:with-param name="title" select="$title"/>
      <xsl:with-param name="target" select="$doref"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="apichunks">
    <h2 align="center">
    <xsl:for-each select="/apirefs/index/chunks/chunk">
      <xsl:variable name="name" select="@name"/>
      <xsl:variable name="start" select="@start"/>
      <xsl:variable name="end" select="@end"/>
      <xsl:variable name="block" select="concat($start, '-', $end)"/>
      <a href="API{$name}.html"><xsl:value-of select="$block"/></a>
      <xsl:text>
</xsl:text>
    </xsl:for-each>
    </h2>
  </xsl:template>

  <xsl:template match="chunk">
    <xsl:variable name="name" select="@name"/>
    <xsl:variable name="start" select="@start"/>
    <xsl:variable name="end" select="@end"/>
    <xsl:variable name="block" select="concat($start, '-', $end)"/>
    <xsl:variable name="target" select="/apirefs/index/chunk[@name = $name]"/>
    <xsl:variable name="title">API Alphabetic Index <xsl:value-of select="$block"/> for <xsl:value-of select="$module"/></xsl:variable>
    <xsl:variable name="dochunk">
      <xsl:call-template name="apichunks"/>
      <xsl:apply-templates mode="wordlist" select="$target/letter"/>
      <xsl:call-template name="apichunks"/>
    </xsl:variable>
    <xsl:call-template name="new_page">
      <xsl:with-param name="filename" select="concat('API', $name, '.html')"/>
      <xsl:with-param name="title" select="$title"/>
      <xsl:with-param name="target" select="$dochunk"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="index">
    <xsl:message>Generating API Index</xsl:message>
    <xsl:apply-templates select="chunks/chunk"/>
  </xsl:template>

  <xsl:template match="apirefs">
    <xsl:message>Generating API Cross References</xsl:message>
    <xsl:apply-templates select="constructors"/>
    <xsl:apply-templates select="functions"/>
    <xsl:apply-templates select="alpha"/>
    <xsl:apply-templates select="files"/>
    <xsl:apply-templates select="index"/>
  </xsl:template>

  <xsl:template match="/">
    <xsl:message>Executing api.xsl</xsl:message>
    <xsl:apply-templates select="$apirefs/apirefs"/>
    <xsl:if test="$dirname=''">	<!-- template for search only for base dir -->
      <xsl:message>Generating search template</xsl:message>
      <xsl:variable name="dummydata">
        <xsl:element name="insert_php">
          <xsl:value-of select="'Insert point for php code'"/>
        </xsl:element>
      </xsl:variable>
      <xsl:call-template name="new_page">
        <xsl:with-param name="filename" select="'search.templ'"/>
        <xsl:with-param name="title" select="'Search engine'"/>
        <xsl:with-param name="target" select="$dummydata"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
