<?xml version="1.0"?>
<!--
  This stylesheet is imported by the other stylesheets (e.g. newapi.xsl
  and api.xsl).  For flexibility, it depends upon a global param
  which is normally defined in the importing stylesheet.  This is:
   href_base	The most superior documentation directory (e.g. XML/)
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" encoding="ISO-8859-1"
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

  <!-- dirname is used to 'choose' between libxslt and libexslt -->
  <xsl:param name="dirname" select="''"/>
  <!-- libname is the name of the library being documented -->
  <xsl:param name="libname" select="'libxslt'"/>
  <!-- logo_base points to the *.png logos used in headers -->
  <xsl:param name="logo_base" select="''"/>

  <!-- href_base gives the location of 'base documentation' files 
       and can be changed by importing stylesheets -->
  <xsl:variable name="href_base" select="''"/>

  <xsl:variable name="home_base">
    <xsl:choose>
      <xsl:when test="$dirname != ''">
        <xsl:value-of select = "'../'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select = "''"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="menu_name" select="'Main Menu'"/>

<!--
 - returns the filename associated to an ID in the original file
 -->
  <xsl:template name="filename">
    <xsl:param name="name" select="string(@href)"/>
    <xsl:choose>
      <xsl:when test="$name = '#Introducti'">
        <xsl:text>intro.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#Documentat'">
        <xsl:text>docs.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#Reporting'">
        <xsl:text>bugs.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#help'">
        <xsl:text>help.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#Help'">
        <xsl:text>help.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#Downloads'">
        <xsl:text>downloads.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#News'">
        <xsl:text>news.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#Contributi'">
        <xsl:text>contribs.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#xsltproc'">
        <xsl:text>xsltproc2.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#API'">
        <xsl:text>API.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#Extensions'">
        <xsl:text>extensions.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#Internals'">
        <xsl:text>internals.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#DocBook'">
        <xsl:text>docbook.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#FAQ'">
        <xsl:text>FAQ.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = '#Python'">
        <xsl:text>python.html</xsl:text>
      </xsl:when>
      <xsl:when test="$name = ''">
        <xsl:text>unknown.html</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--
 - The table of content
 -->
  <xsl:variable name="toc">
    <form action="{$home_base}search.php"
          enctype="application/x-www-form-urlencoded" method="get">
      <input name="query" type="text" size="20" value=""/>
      <input name="submit" type="submit" value="Search ..."/>
    </form>
    <ul>
      <li><a href="index.html">Home</a></li>
      <xsl:for-each select="/html/body/h2">
        <xsl:variable name="filename">
          <xsl:call-template name="filename">
            <xsl:with-param name="name" select="concat('#', string(a[1]/@name))"/>
          </xsl:call-template>
        </xsl:variable>
        <li>
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="$filename"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </xsl:element>
        </li>
      </xsl:for-each>

      <xsl:choose>
        <xsl:when test="$dirname != ''">
	  <li><a href="../index.html" style="font-weight:bold">libxslt</a></li>
	</xsl:when>
	<xsl:otherwise>
	  <li><a href="EXSLT/index.html" style="font-weight:bold">libexslt</a></li>
          <li><a href="xslt.html">flat page</a>, <a href="site.xsl">stylesheet</a></li>
	</xsl:otherwise>
      </xsl:choose>

      <li><a href="html/index.html" style="font-weight:bold">API Menu</a></li>
      <li><a href="ChangeLog.html">ChangeLog</a></li>
    </ul>
  </xsl:variable>

  <xsl:variable name="api">
    <ul>
      <li><a href="{$href_base}APIchunk0.html">Alphabetic</a></li>
      <li><a href="{$href_base}APIconstructors.html">Constructors</a></li>
      <li><a href="{$href_base}APIfunctions.html">Functions/Types</a></li>
      <li><a href="{$href_base}APIfiles.html">Modules</a></li>
      <li><a href="{$href_base}APIsymbols.html">Symbols</a></li>
    </ul>
  </xsl:variable>

  <xsl:variable name="related">
    <ul>
      <xsl:choose>
        <xsl:when test="$dirname = ''">
      <li><a href="{$href_base}tutorial/libxslttutorial.html">Tutorial</a>,
          <a href="{$href_base}tutorial2/libxslt_pipes.html">Tutorial2</a></li>
      <li><a href="{$href_base}xsltproc.html">Man page for xsltproc</a></li>
        </xsl:when>
      </xsl:choose>
      <li><a href="http://mail.gnome.org/archives/xslt/">Mail archive</a></li>
      <li><a href="http://xmlsoft.org/">XML libxml2</a></li>
      <li><a href="ftp://xmlsoft.org/">FTP</a></li>
      <li><a href="http://www.zlatkovic.com/projects/libxml/">Windows binaries</a></li>
      <li><a href="http://garypennington.net/libxml2/">Solaris binaries</a></li>
      <li><a href="http://www.explain.com.au/oss/libxml2xslt.html">MacOsX binaries</a></li>
      <li><a href="https://gitlab.gnome.org/GNOME/libxslt/issues">Bug Tracker</a></li>
      <li><a href="http://codespeak.net/lxml/">lxml Python bindings</a></li>
      <li><a href="http://cpan.uwinnipeg.ca/dist/XML-LibXSLT">Perl XSLT bindings</a></li>
      <li><a href="http://www.zend.com/php5/articles/php5-xmlphp.php#Heading17">XSLT with PHP</a></li>
      <li><a href="http://www.mod-xslt2.com/">Apache module</a></li>
      <li><a href="http://sourceforge.net/projects/libxml2-pas/">Pascal bindings</a></li>
      <li><a href="http://xsldbg.sourceforge.net/">Xsldbg Debugger</a></li>
    </ul>
  </xsl:variable>

  <xsl:template name="develtoc">
    <table border="0" cellspacing="0" cellpadding="1" width="100%" bgcolor="#000000">
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="1" cellpadding="3">
            <tr>
              <td colspan="1" bgcolor="#eecfa1" align="center">
                <center>
                  <b><xsl:value-of select="$menu_name"/></b>
                </center>
              </td>
            </tr>
            <tr>
              <td bgcolor="#fffacd">
                <xsl:copy-of select="$toc"/>
              </td>
            </tr>
          </table>
          <table width="100%" border="0" cellspacing="1" cellpadding="3">
            <tr>
              <td colspan="1" bgcolor="#eecfa1" align="center">
                <center>
                  <b>Related links</b>
                </center>
              </td>
            </tr>
            <tr>
              <td bgcolor="#fffacd">
                <xsl:copy-of select="$related"/>
              </td>
            </tr>
          </table>
          <table width="100%" border="0" cellspacing="1" cellpadding="3">
            <tr>
              <td colspan="1" bgcolor="#eecfa1" align="center">
                <center>
                  <b>API Indexes</b>
                </center>
              </td>
            </tr>
            <tr>
              <td bgcolor="#fffacd">
                <xsl:copy-of select="$api"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template mode="head" match="title">
    <title>
      <xsl:apply-templates/>
    </title>
  </xsl:template>
  <xsl:template mode="head" match="meta">
</xsl:template>

<!--
 - The global title
 -->
  <xsl:variable name="globaltitle" select="string(/html/body/h1[1])"/>
<!--
 - Write the styles in the head
 -->
  <xsl:template name="style">
    <style type="text/css">
TD {font-family: Verdana,Arial,Helvetica}
BODY {font-family: Verdana,Arial,Helvetica; margin-top: 2em; margin-left: 0em; margin-right: 0em}
H1 {font-family: Verdana,Arial,Helvetica}
H2 {font-family: Verdana,Arial,Helvetica}
H3 {font-family: Verdana,Arial,Helvetica}
A:link, A:visited, A:active { text-decoration: underline }
    </style>
  </xsl:template>

<!--
 - Write the title box on top
 -->
  <xsl:template name="titlebox">
    <xsl:param name="title" select="'Main Page'"/>
    <table border="0" width="100%" cellpadding="5" cellspacing="0" align="center">
      <tr>
        <td width="120">
          <a href="http://swpat.ffii.org/"><img src="{$logo_base}epatents.png" alt="Action against software patents"/></a>
        </td>
        <td width="180">
          <a href="http://www.gnome.org/"><img src="{$logo_base}gnome2.png" alt="GNOME2 Logo"/></a>
          <a href="http://www.w3.org/Status"><img src="{$logo_base}w3c.png" alt="W3C logo"/></a>
          <a href="http://www.redhat.com"><img src="{$logo_base}redhat.gif" alt="Red Hat Logo"/></a>
          <div align="left">
            <a href="http://xmlsoft.org/XSLT/"><img src="{$logo_base}Libxslt-Logo-180x168.gif" alt="Made with Libxslt Logo"/></a>
          </div>
        </td>
        <td>
          <table border="0" width="90%" cellpadding="2" cellspacing="0" align="center" bgcolor="#000000">
            <tr>
              <td>
                <table width="100%" border="0" cellspacing="1" cellpadding="3" bgcolor="#fffacd">
                  <tr>
                    <td align="center">
                      <xsl:element name="h1">
                        <xsl:value-of select="$globaltitle"/>
                      </xsl:element>
                      <xsl:element name="h2">
                        <xsl:value-of select="$title"/>
                      </xsl:element>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

<!--
 - Handling of nodes in the body before the first H2, table of content
 - Everything is just copied over, except href which may get rewritten
 - and h1/h2/a at the top level
 -->
  <xsl:template priority="2" mode="subcontent" match="a">
    <xsl:variable name="filename">
      <xsl:call-template name="filename">
        <xsl:with-param name="name" select="string(@href)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:copy>
      <xsl:attribute name="href">
        <xsl:value-of select="$filename"/>
      </xsl:attribute>
      <xsl:apply-templates mode="subcontent" select="node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="subcontent" match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates mode="subcontent" select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template mode="content" match="@*|node()">
    <xsl:if test="name() != 'h1' and name() != 'h2'">
      <xsl:copy>
        <xsl:apply-templates mode="subcontent" select="@*|node()"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

<!--
 - Handling of nodes in the body after an H2
 - Open a new file and dump all the siblings up to the next H2
 -->
  <xsl:template name="subfile">
    <xsl:param name="header" select="following-sibling::h2[1]"/>
    <xsl:variable name="filename">
      <xsl:call-template name="filename">
        <xsl:with-param name="name" select="concat('#', string($header/a[1]/@name))"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="title">
      <xsl:value-of select="$header"/>
    </xsl:variable>
    <xsl:variable name="content">
      <xsl:apply-templates mode="subfile" select=
         "$header/following-sibling::*[preceding-sibling::h2[1] = $header and name() != 'h2' and position() != last()]"/>
    </xsl:variable>
    <xsl:call-template name="new_page">
      <xsl:with-param name="filename" select="concat($dirname, $filename)"/>
      <xsl:with-param name="title" select="$title"/>
      <xsl:with-param name="target" select="$content"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="subfile" match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates mode="content" select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

<!--
 - Handling of the initial body and head HTML document
 -->
  <xsl:template match="body">
    <xsl:variable name="firsth2" select="./h2[1]"/>
    <xsl:variable name="rest2" select="./h2[position()&gt;1]"/>
    <xsl:variable name="content">
      <xsl:apply-templates mode="content" select="($firsth2/preceding-sibling::*)"/>
      <xsl:for-each select="./h2">
        <xsl:call-template name="subfile">
          <xsl:with-param name="header" select="."/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:variable>
    <xsl:call-template name="generic_page">
      <xsl:with-param name="title" select="$libname"/>
      <xsl:with-param name="target" select="$content"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template match="head">
  <!--
    The output <head> node is created during initial processing
  -->
  </xsl:template>

  <xsl:template match="html">
  <!--
    The output <html> node is created during initial processing
  -->
    <xsl:apply-templates/>
  </xsl:template>

<!--
  new_page creates a new output document using the parameter "filename", then calls upon
  the template generic_page to do the actual page generation.
-->
  <xsl:template name="new_page">
    <xsl:param name="filename"/>  <!-- Output filename -->
    <xsl:param name="title"/>     <!-- Page title -->
    <xsl:param name="target"/>    <!-- The nodes (RTF) to be copied into document -->
    <xsl:document href="{$filename}" method="xml" encoding="ISO-8859-1"
          doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
          doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      <xsl:call-template name="generic_page">
        <xsl:with-param name="title" select="$title"/>
        <xsl:with-param name="target" select="$target"/>
	  <xsl:with-param name="toc" select="$toc"/>
      </xsl:call-template>
    </xsl:document>
  </xsl:template>

<!--
  generic_page produces the "standard" page used by all the different doc files.
-->
  <xsl:template name="generic_page">
    <xsl:param name="title"/>
    <xsl:param name="target"/>    <!-- The nodes (RTF) that make up the main page content -->
      <html>
        <head>
        <xsl:call-template name="style"/>
	<xsl:element name="title">
	  <xsl:value-of select="$title"/>
	</xsl:element>
        </head>
        <body bgcolor="#8b7765" text="#000000" link="#a06060" vlink="#000000">
          <xsl:call-template name="titlebox">
	    <xsl:with-param name="title" select="$title"/>
	  </xsl:call-template>
          <table border="0" cellpadding="4" cellspacing="0" width="100%" align="center">
            <tr>
              <td bgcolor="#8b7765">
                <table border="0" cellspacing="0" cellpadding="2" width="100%">
                  <tr>
                    <td valign="top" width="200" bgcolor="#8b7765">
                      <xsl:call-template name="develtoc"/>
                    </td>
                    <td valign="top" bgcolor="#8b7765">
                      <table border="0" cellspacing="0" cellpadding="1" width="100%">
                        <tr>
                          <td>
                            <table border="0" cellspacing="0" cellpadding="1" width="100%" bgcolor="#000000">
                              <tr>
                                <td>
                                  <table border="0" cellpadding="3" cellspacing="1" width="100%">
                                    <tr>
                                      <td bgcolor="#fffacd">
                                        <xsl:copy-of select="$target"/>
                                        <p><a href="{$href_base}bugs.html">Daniel Veillard</a></p>
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </body>
      </html>
  </xsl:template>
</xsl:stylesheet>
