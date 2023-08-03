<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
		xmlns:exsl="http://exslt.org/common"
		xmlns:str="http://exslt.org/strings"
		extension-element-prefixes="exsl str"
		exclude-result-prefixes="exsl str">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- This is convoluted but needed to force the current document to
       be the API one and not the result tree from the tokenize() result,
       because the keys are only defined on the main document -->
  <xsl:template mode="dumptoken" match='*'>
    <xsl:param name="token"/>
    <xsl:variable name="ref" select="key('symbols', $token)"/>
    <xsl:choose>
      <xsl:when test="$ref">
        <a href="libxslt-{$ref/@file}.html#{$ref/@name}"><xsl:value-of select="$token"/></a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$token"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- dumps a string, making cross-reference links -->
  <xsl:template name="dumptext">
    <xsl:param name="text"/>
    <xsl:variable name="ctxt" select='.'/>
    <!-- <xsl:value-of select="$text"/> -->
    <xsl:for-each select="str:tokenize($text, ' &#9;')">
      <xsl:apply-templates select="$ctxt" mode='dumptoken'>
        <xsl:with-param name="token" select="string(.)"/>
      </xsl:apply-templates>
      <xsl:if test="position() != last()">
        <xsl:text> </xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

<!--

             The following builds the Synopsis section

-->
  <xsl:template mode="synopsis" match="function">
    <xsl:variable name="name" select="string(@name)"/>
    <xsl:variable name="nlen" select="string-length($name)"/>
    <xsl:variable name="tlen" select="string-length(return/@type)"/>
    <xsl:variable name="blen" select="(($nlen + 8) - (($nlen + 8) mod 8)) + (($tlen + 8) - (($tlen + 8) mod 8))"/>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="return/@type"/>
    </xsl:call-template>
    <xsl:text>&#9;</xsl:text>
    <a href="#{@name}"><xsl:value-of select="@name"/></a>
    <xsl:if test="$blen - 40 &lt; -8">
      <xsl:text>&#9;</xsl:text>
    </xsl:if>
    <xsl:if test="$blen - 40 &lt; 0">
      <xsl:text>&#9;</xsl:text>
    </xsl:if>
    <xsl:text>&#9;(</xsl:text>
    <xsl:if test="not(arg)">
      <xsl:text>void</xsl:text>
    </xsl:if>
    <xsl:for-each select="arg">
      <xsl:call-template name="dumptext">
        <xsl:with-param name="text" select="@type"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text><br/>
	<xsl:if test="$blen - 40 &gt; 8">
	  <xsl:text>&#9;</xsl:text>
	</xsl:if>
	<xsl:if test="$blen - 40 &gt; 0">
	  <xsl:text>&#9;</xsl:text>
	</xsl:if>
	<xsl:text>&#9;&#9;&#9;&#9;&#9; </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>);</xsl:text>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template mode="synopsis" match="functype">
    <xsl:variable name="name" select="string(@name)"/>
    <xsl:variable name="nlen" select="string-length($name)"/>
    <xsl:variable name="tlen" select="string-length(return/@type)"/>
    <xsl:variable name="blen" select="(($nlen + 8) - (($nlen + 8) mod 8)) + (($tlen + 8) - (($tlen + 8) mod 8))"/>
    <xsl:text>typedef </xsl:text>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="return/@type"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <a href="#{@name}"><xsl:value-of select="@name"/></a>
    <xsl:if test="$blen - 40 &lt; -8">
      <xsl:text>&#9;</xsl:text>
    </xsl:if>
    <xsl:if test="$blen - 40 &lt; 0">
      <xsl:text>&#9;</xsl:text>
    </xsl:if>
    <xsl:text>&#9;(</xsl:text>
    <xsl:if test="not(arg)">
      <xsl:text>void</xsl:text>
    </xsl:if>
    <xsl:for-each select="arg">
      <xsl:call-template name="dumptext">
        <xsl:with-param name="text" select="@type"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text><br/>
	<xsl:if test="$blen - 40 &gt; 8">
	  <xsl:text>&#9;</xsl:text>
	</xsl:if>
	<xsl:if test="$blen - 40 &gt; 0">
	  <xsl:text>&#9;</xsl:text>
	</xsl:if>
	<xsl:text>&#9;&#9;&#9;&#9;&#9; </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>);</xsl:text>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template mode="synopsis" match="exports[@type='function']">
    <xsl:variable name="def" select="key('symbols',@symbol)"/>
    <xsl:apply-templates mode="synopsis" select="$def"/>
  </xsl:template>

  <xsl:template mode="synopsis" match="exports[@type='typedef']">
    <xsl:text>typedef </xsl:text>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="string(key('symbols',@symbol)/@type)"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <a href="#{@symbol}"><xsl:value-of select="@symbol"/></a>
    <xsl:text>;
</xsl:text>
  </xsl:template>

  <xsl:template mode="synopsis" match="exports[@type='macro']">
    <xsl:variable name="def" select="key('symbols',@symbol)"/>
    <xsl:text>#define </xsl:text>
    <a href="#{@symbol}"><xsl:value-of select="@symbol"/></a>
    <xsl:if test="$def/arg">
      <xsl:text>(</xsl:text>
      <xsl:for-each select="$def/arg">
        <xsl:value-of select="@name"/>
	<xsl:if test="position() != last()">
	  <xsl:text>, </xsl:text>
	</xsl:if>
      </xsl:for-each>
      <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:text>;
</xsl:text>
  </xsl:template>
  <xsl:template mode="synopsis" match="exports[@type='enum']">
  </xsl:template>
  <xsl:template mode="synopsis" match="exports[@type='struct']">
  </xsl:template>

<!--

             The following builds the Details section

-->
  <xsl:template mode="details" match="struct">
    <xsl:variable name="name" select="string(@name)"/>
    <div class="refsect2" lang="en">
    <h3><a name="{$name}">Structure </a><xsl:value-of select="$name"/></h3>
    <pre class="programlisting">
    <xsl:value-of select="@type"/><xsl:text> {
</xsl:text>
    <xsl:if test="not(field)">
      <xsl:text>The content of this structure is not made public by the API.
</xsl:text>
    </xsl:if>
    <xsl:for-each select="field">
        <xsl:text>    </xsl:text>
	<xsl:call-template name="dumptext">
	  <xsl:with-param name="text" select="@type"/>
	</xsl:call-template>
	<xsl:text>&#9;</xsl:text>
	<xsl:value-of select="@name"/>
	<xsl:if test="@info != ''">
	  <xsl:text>&#9;: </xsl:text>
	  <xsl:call-template name="dumptext">
	    <xsl:with-param name="text" select="substring(@info, 1, 70)"/>
	  </xsl:call-template>
	</xsl:if>
	<xsl:text>
</xsl:text>
    </xsl:for-each>
    <xsl:text>} </xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>;
</xsl:text>
    </pre>
    <p>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="info"/>
    </xsl:call-template>
    </p><xsl:text>
</xsl:text>
    </div><hr/>
  </xsl:template>

  <xsl:template mode="details" match="typedef[@type != 'enum']">
    <xsl:variable name="name" select="string(@name)"/>
    <div class="refsect2" lang="en">
    <h3><a name="{$name}">Typedef </a><xsl:value-of select="$name"/></h3>
    <pre class="programlisting">
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="string(@type)"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>;
</xsl:text>
    </pre>
    <p>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="info"/>
    </xsl:call-template>
    </p><xsl:text>
</xsl:text>
    </div><hr/>
  </xsl:template>

  <xsl:template mode="details" match="variable">
    <xsl:variable name="name" select="string(@name)"/>
    <div class="refsect2" lang="en">
    <h3><a name="{$name}">Variable </a><xsl:value-of select="$name"/></h3>
    <pre class="programlisting">
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="string(@type)"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>;
</xsl:text>
    </pre>
    <p>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="info"/>
    </xsl:call-template>
    </p><xsl:text>
</xsl:text>
    </div><hr/>
  </xsl:template>

  <xsl:template mode="details" match="typedef[@type = 'enum']">
    <xsl:variable name="name" select="string(@name)"/>
    <div class="refsect2" lang="en">
    <h3><a name="{$name}">Enum </a><xsl:value-of select="$name"/></h3>
    <pre class="programlisting">
    <xsl:text>enum </xsl:text>
    <a href="#{$name}"><xsl:value-of select="$name"/></a>
    <xsl:text> {
</xsl:text>
    <xsl:for-each select="/api/symbols/enum[@type=$name]">
      <xsl:sort select="@value" data-type="number" order="ascending"/>
      <xsl:text>    </xsl:text>
      <a name="{@name}"><xsl:value-of select="@name"/></a>
      <xsl:if test="@value">
        <xsl:text> = </xsl:text>
	<xsl:value-of select="@value"/>
      </xsl:if>
      <xsl:if test="@info">
        <xsl:text> /* </xsl:text>
	<xsl:value-of select="@info"/>
        <xsl:text> */</xsl:text>
      </xsl:if>
      <xsl:text>
</xsl:text>
    </xsl:for-each>
    <xsl:text>};
</xsl:text>
    </pre>
    <p>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="info"/>
    </xsl:call-template>
    </p><xsl:text>
</xsl:text>
    </div><hr/>
  </xsl:template>

  <xsl:template mode="details" match="macro">
    <xsl:variable name="name" select="string(@name)"/>
    <div class="refsect2" lang="en">
    <h3><a name="{$name}">Macro </a><xsl:value-of select="$name"/></h3>
    <pre class="programlisting">
    <xsl:text>#define </xsl:text>
    <a href="#{$name}"><xsl:value-of select="$name"/></a>
    <xsl:if test="arg">
      <xsl:text>(</xsl:text>
      <xsl:for-each select="arg">
        <xsl:value-of select="@name"/>
	<xsl:if test="position() != last()">
	  <xsl:text>, </xsl:text>
	</xsl:if>
      </xsl:for-each>
      <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:text>;
</xsl:text>
    </pre>
    <p>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="info"/>
    </xsl:call-template>
    </p>
    <xsl:if test="arg">
      <div class="variablelist"><table border="0"><col align="left"/><tbody>
      <xsl:for-each select="arg">
        <tr>
          <td><span class="term"><i><tt><xsl:value-of select="@name"/></tt></i>:</span></td>
	  <td>
	    <xsl:call-template name="dumptext">
	      <xsl:with-param name="text" select="@info"/>
	    </xsl:call-template>
	  </td>
        </tr>
      </xsl:for-each>
      </tbody></table></div>
    </xsl:if>
    <xsl:text>
</xsl:text>
    </div><hr/>
  </xsl:template>

  <xsl:template mode="details" match="function">
    <xsl:variable name="name" select="string(@name)"/>
    <xsl:variable name="nlen" select="string-length($name)"/>
    <xsl:variable name="tlen" select="string-length(return/@type)"/>
    <xsl:variable name="blen" select="(($nlen + 8) - (($nlen + 8) mod 8)) + (($tlen + 8) - (($tlen + 8) mod 8))"/>
    <div class="refsect2" lang="en">
    <h3><a name="{$name}"></a><xsl:value-of select="$name"/> ()</h3>
    <pre class="programlisting">
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="return/@type"/>
    </xsl:call-template>
    <xsl:text>&#9;</xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:if test="$blen - 40 &lt; -8">
      <xsl:text>&#9;</xsl:text>
    </xsl:if>
    <xsl:if test="$blen - 40 &lt; 0">
      <xsl:text>&#9;</xsl:text>
    </xsl:if>
    <xsl:text>&#9;(</xsl:text>
    <xsl:if test="not(arg)">
      <xsl:text>void</xsl:text>
    </xsl:if>
    <xsl:for-each select="arg">
      <xsl:call-template name="dumptext">
        <xsl:with-param name="text" select="@type"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text><br/>
	<xsl:if test="$blen - 40 &gt; 8">
	  <xsl:text>&#9;</xsl:text>
	</xsl:if>
	<xsl:if test="$blen - 40 &gt; 0">
	  <xsl:text>&#9;</xsl:text>
	</xsl:if>
	<xsl:text>&#9;&#9;&#9;&#9;&#9; </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>)</xsl:text><br/>
    <xsl:text>
</xsl:text>
    </pre>
    <p>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="info"/>
    </xsl:call-template>
    </p><xsl:text>
</xsl:text>
    <xsl:if test="arg | return/@info">
      <div class="variablelist"><table border="0"><col align="left"/><tbody>
      <xsl:for-each select="arg">
        <tr>
          <td><span class="term"><i><tt><xsl:value-of select="@name"/></tt></i>:</span></td>
	  <td>
	    <xsl:call-template name="dumptext">
	      <xsl:with-param name="text" select="@info"/>
	    </xsl:call-template>
	  </td>
        </tr>
      </xsl:for-each>
      <xsl:if test="return/@info">
        <tr>
          <td><span class="term"><i><tt>Returns</tt></i>:</span></td>
	  <td>
	    <xsl:call-template name="dumptext">
	      <xsl:with-param name="text" select="return/@info"/>
	    </xsl:call-template>
	  </td>
        </tr>
      </xsl:if>
      </tbody></table></div>
    </xsl:if>
    </div><hr/>
  </xsl:template>

  <xsl:template mode="details" match="functype">
    <xsl:variable name="name" select="string(@name)"/>
    <xsl:variable name="nlen" select="string-length($name)"/>
    <xsl:variable name="tlen" select="string-length(return/@type)"/>
    <xsl:variable name="blen" select="(($nlen + 8) - (($nlen + 8) mod 8)) + (($tlen + 8) - (($tlen + 8) mod 8))"/>
    <div class="refsect2" lang="en">
    <h3><a name="{$name}"></a>Function type <xsl:value-of select="$name"/> </h3>
    <pre class="programlisting">
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="return/@type"/>
    </xsl:call-template>
    <xsl:text>&#9;</xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:if test="$blen - 40 &lt; -8">
      <xsl:text>&#9;</xsl:text>
    </xsl:if>
    <xsl:if test="$blen - 40 &lt; 0">
      <xsl:text>&#9;</xsl:text>
    </xsl:if>
    <xsl:text>&#9;(</xsl:text>
    <xsl:if test="not(arg)">
      <xsl:text>void</xsl:text>
    </xsl:if>
    <xsl:for-each select="arg">
      <xsl:call-template name="dumptext">
        <xsl:with-param name="text" select="@type"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text><br/>
	<xsl:if test="$blen - 40 &gt; 8">
	  <xsl:text>&#9;</xsl:text>
	</xsl:if>
	<xsl:if test="$blen - 40 &gt; 0">
	  <xsl:text>&#9;</xsl:text>
	</xsl:if>
	<xsl:text>&#9;&#9;&#9;&#9;&#9; </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>)</xsl:text><br/>
    <xsl:text>
</xsl:text>
    </pre>
    <p>
    <xsl:call-template name="dumptext">
      <xsl:with-param name="text" select="info"/>
    </xsl:call-template>
    </p><xsl:text>
</xsl:text>
    <xsl:if test="arg | return/@info">
      <div class="variablelist"><table border="0"><col align="left"/><tbody>
      <xsl:for-each select="arg">
        <tr>
          <td><span class="term"><i><tt><xsl:value-of select="@name"/></tt></i>:</span></td>
	  <td>
	    <xsl:call-template name="dumptext">
	      <xsl:with-param name="text" select="@info"/>
	    </xsl:call-template>
	  </td>
        </tr>
      </xsl:for-each>
      <xsl:if test="return/@info">
        <tr>
          <td><span class="term"><i><tt>Returns</tt></i>:</span></td>
	  <td>
	    <xsl:call-template name="dumptext">
	      <xsl:with-param name="text" select="return/@info"/>
	    </xsl:call-template>
	  </td>
        </tr>
      </xsl:if>
      </tbody></table></div>
    </xsl:if>
    </div><hr/>
  </xsl:template>

<!--

             The following builds the general.html page

-->
  <xsl:template name="generate_general">
    <xsl:variable name="next" select="string(/api/files/file[position()=1]/@name)"/>
    <xsl:document xmlns="" href="general.html" method="xml" indent="yes" encoding="UTF-8">
      <html>
        <head>
	  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	  <title><xsl:value-of select="concat(@name, ': ', summary)"/></title>
	  <meta name="generator" content="Libxml2 devhelp stylesheet"/>
	  <link rel="start" href="index.html" title="libxslt Reference Manual"/>
	  <link rel="up" href="index.html" title="libxslt Reference Manual"/>
	  <link rel="stylesheet" href="style.css" type="text/css"/>
	  <link rel="chapter" href="index.html" title="libxslt Reference Manual"/>
        </head>
	<body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF">

          <table class="navigation" width="100%" summary="Navigation header" cellpadding="2" cellspacing="2">
	    <tr valign="middle">
              <td><a accesskey="u" href="index.html"><img src="up.png" width="24" height="24" border="0" alt="Up"/></a></td>
              <td><a accesskey="h" href="index.html"><img src="home.png" width="24" height="24" border="0" alt="Home"/></a></td>
	      <xsl:if test="$next != ''">
		<td><a accesskey="n" href="libxslt-{$next}.html"><img src="right.png" width="24" height="24" border="0" alt="Next"/></a></td>
	      </xsl:if>
              <th width="100%" align="center">libxslt Reference Manual</th>
            </tr>
	  </table>
	  <h2><span class="refentrytitle">libxslt API Modules</span></h2>
	  <p>
	  <xsl:for-each select="/api/files/file">
	    <a href="libxslt-{@name}.html"><xsl:value-of select="@name"/></a> - <xsl:value-of select="summary"/><br/>
	  </xsl:for-each>
	  </p>
	</body>
      </html>
    </xsl:document>
  </xsl:template>

<!--

             The following builds the index.html page

-->
  <xsl:template name="generate_index">
    <xsl:document xmlns="" href="index.html" method="xml" indent="yes" encoding="UTF-8">
      <html>
        <head>
	  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	  <title>libxslt Reference Manual</title>
	  <meta name="generator" content="Libxml2 devhelp stylesheet"/>
	  <link rel="stylesheet" href="style.css" type="text/css"/>
        </head>
	<body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF">

          <table class="navigation" width="100%" summary="Navigation header" cellpadding="2" cellspacing="2">
	    <tr valign="middle">
              <td><a accesskey="h" href="index.html"><img src="home.png" width="24" height="24" border="0" alt="Home"/></a></td>
	      <td><a accesskey="n" href="general.html"><img src="right.png" width="24" height="24" border="0" alt="Next"/></a></td>
              <th width="100%" align="center">libxslt Reference Manual</th>
            </tr>
	  </table>
	  <h2><span class="refentrytitle">libxslt Reference Manual</span></h2>
<p>libxslt is the <a href="http://www.w3.org/TR/xslt">XSLT</a> C library
developed for the GNOME project. XSLT itself is a an XML language to define
transformation for XML. Libxslt is based on <a
href="https://gitlab.gnome.org/GNOME/libxml2/">libxml2</a> the XML C library developed for the
GNOME project. It also implements most of the <a
href="http://www.exslt.org/">EXSLT</a> set of processor-portable extensions
functions and some of Saxon's evaluate and expressions extensions.</p>
	</body>
      </html>
    </xsl:document>
  </xsl:template>

</xsl:stylesheet>


