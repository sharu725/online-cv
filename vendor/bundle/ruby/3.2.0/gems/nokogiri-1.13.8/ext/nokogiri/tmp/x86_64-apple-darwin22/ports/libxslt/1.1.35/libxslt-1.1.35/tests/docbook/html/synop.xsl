<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY RE "&#10;">
<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<!-- ==================================================================== -->

<!-- synopsis is in verbatim -->

<!-- ==================================================================== -->

<xsl:template match="cmdsynopsis">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <div class="{name(.)}" id="{$id}">
    <a name="{$id}"/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="cmdsynopsis/command">
  <br/>
  <xsl:call-template name="inline.monoseq"/>
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="cmdsynopsis/command[1]" priority="2">
  <xsl:call-template name="inline.monoseq"/>
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="group|arg">
  <xsl:variable name="choice" select="@choice"/>
  <xsl:variable name="rep" select="@rep"/>
  <xsl:variable name="sepchar">
    <xsl:choose>
      <xsl:when test="ancestor-or-self::*/@sepchar">
        <xsl:value-of select="ancestor-or-self::*/@sepchar"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:if test="position()>1"><xsl:value-of select="$sepchar"/></xsl:if>
  <xsl:choose>
    <xsl:when test="$choice='plain'">
      <xsl:value-of select="$arg.choice.plain.open.str"/>
    </xsl:when>
    <xsl:when test="$choice='req'">
      <xsl:value-of select="$arg.choice.req.open.str"/>
    </xsl:when>
    <xsl:when test="$choice='opt'">
      <xsl:value-of select="$arg.choice.opt.open.str"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$arg.choice.def.open.str"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:apply-templates/>
  <xsl:choose>
    <xsl:when test="$rep='repeat'">
      <xsl:value-of select="$arg.rep.repeat.str"/>
    </xsl:when>
    <xsl:when test="$rep='norepeat'">
      <xsl:value-of select="$arg.rep.norepeat.str"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$arg.rep.def.str"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="$choice='plain'">
      <xsl:value-of select="$arg.choice.plain.close.str"/>
    </xsl:when>
    <xsl:when test="$choice='req'">
      <xsl:value-of select="$arg.choice.req.close.str"/>
    </xsl:when>
    <xsl:when test="$choice='opt'">
      <xsl:value-of select="$arg.choice.opt.close.str"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$arg.choice.def.close.str"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="group/arg">
  <xsl:variable name="choice" select="@choice"/>
  <xsl:variable name="rep" select="@rep"/>
  <xsl:if test="position()>1"><xsl:value-of select="$arg.or.sep"/></xsl:if>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="sbr">
  <br/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="synopfragmentref">
  <xsl:variable name="target" select="id(@linkend)"/>
  <xsl:variable name="snum">
    <xsl:apply-templates select="$target" mode="synopfragment.number"/>
  </xsl:variable>
  <i>
    <a href="#{@linkend}">
      <xsl:text>(</xsl:text>
      <xsl:value-of select="$snum"/>
      <xsl:text>)</xsl:text>
    </a>
  </i>
</xsl:template>

<xsl:template match="synopfragment" mode="synopfragment.number">
  <xsl:number format="1"/>
</xsl:template>

<xsl:template match="synopfragment">
  <xsl:variable name="snum">
    <xsl:apply-templates select="." mode="synopfragment.number"/>
  </xsl:variable>
  <p>
    <a name="#{@id}">
      <xsl:text>(</xsl:text>
      <xsl:value-of select="$snum"/>
      <xsl:text>)</xsl:text>
    </a>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </p>
</xsl:template>   

<xsl:template match="funcsynopsis">
  <xsl:call-template name="informal.object"/>
</xsl:template>

<xsl:template match="funcsynopsisinfo">
  <pre class="{name(.)}"><xsl:apply-templates/></pre>
</xsl:template>

<xsl:template match="funcprototype">
  <p>
    <code>
      <xsl:apply-templates/>
      <xsl:if test="$funcsynopsis.style='kr'">
        <xsl:apply-templates select="./paramdef" mode="kr-funcsynopsis-mode"/>
      </xsl:if>
    </code>
  </p>
</xsl:template>

<xsl:template match="funcdef">
  <code class="{name(.)}">
    <xsl:apply-templates/>
  </code>
</xsl:template>

<xsl:template match="funcdef/function">
  <xsl:choose>
    <xsl:when test="$funcsynopsis.decoration != 0">
      <b class="fsfunc"><xsl:apply-templates/></b>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="void">
  <xsl:choose>
    <xsl:when test="$funcsynopsis.style='ansi'">
      <xsl:text>(void);</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>();</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="varargs">
  <xsl:text>(...);</xsl:text>
</xsl:template>

<xsl:template match="paramdef">
  <xsl:variable name="paramnum">
    <xsl:number count="paramdef" format="1"/>
  </xsl:variable>
  <xsl:if test="$paramnum=1">(</xsl:if>
  <xsl:choose>
    <xsl:when test="$funcsynopsis.style='ansi'">
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="./parameter"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="following-sibling::paramdef">
      <xsl:text>, </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>);</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="paramdef/parameter">
  <xsl:choose>
    <xsl:when test="$funcsynopsis.decoration != 0">
      <var class="pdparam">
        <xsl:apply-templates/>
      </var>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:if test="following-sibling::parameter">
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="paramdef" mode="kr-funcsynopsis-mode">
  <br/>
  <xsl:apply-templates/>
  <xsl:text>;</xsl:text>
</xsl:template>

<xsl:template match="funcparams">
  <xsl:text>(</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>)</xsl:text>
</xsl:template>

<!-- ==================================================================== -->

<xsl:variable name="default-classsynopsis-language">java</xsl:variable>

<xsl:template match="classsynopsis">
  <xsl:param name="language">
    <xsl:choose>
      <xsl:when test="@language">
	<xsl:value-of select="@language"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$default-classsynopsis-language"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <xsl:choose>
    <xsl:when test="$language='java'">
      <xsl:apply-templates select="." mode="java"/>
    </xsl:when>
    <xsl:when test="$language='perl'">
      <xsl:apply-templates select="." mode="perl"/>
    </xsl:when>
    <xsl:when test="$language='idl'">
      <xsl:apply-templates select="." mode="idl"/>
    </xsl:when>
    <xsl:when test="$language='cpp'">
      <xsl:apply-templates select="." mode="cpp"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>
	<xsl:text>Unrecognized language on classsynopsis: </xsl:text>
	<xsl:value-of select="$language"/>
      </xsl:message>
      <xsl:apply-templates select=".">
	<xsl:with-param name="language"
	  select="$default-classsynopsis-language"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ===== Java ======================================================== -->

<xsl:template match="classsynopsis" mode="java">
  <pre class="{name(.)}">
    <xsl:apply-templates select="ooclass[1]" mode="java"/>
    <xsl:if test="ooclass[position() &gt; 1]">
      <xsl:text> extends</xsl:text>
      <xsl:apply-templates select="ooclass[position() &gt; 1]" mode="java"/>
      <xsl:if test="oointerface|ooexception">
	<xsl:text>&RE;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="oointerface">
      <xsl:text>implements</xsl:text>
      <xsl:apply-templates select="oointerface" mode="java"/>
      <xsl:if test="ooexception">
	<xsl:text>&RE;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="ooexception">
      <xsl:text>throws</xsl:text>
      <xsl:apply-templates select="ooexception" mode="java"/>
    </xsl:if>
    <xsl:text>&nbsp;{&RE;&RE;</xsl:text>
    <xsl:apply-templates select="constructorsynopsis
                                 |destructorsynopsis
                                 |fieldsynopsis
                                 |methodsynopsis
                                 |classsynopsisinfo" mode="java"/>
    <xsl:text>}</xsl:text>
  </pre>
</xsl:template>

<xsl:template match="classsynopsisinfo" mode="java">
  <xsl:apply-templates mode="java"/>
</xsl:template>

<xsl:template match="ooclass|oointerface|ooexception" mode="java">
  <xsl:choose>
    <xsl:when test="position() &gt; 1">
      <xsl:text>, </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text> </xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
  </span>
</xsl:template>

<xsl:template match="modifier" mode="java">
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="classname" mode="java">
  <xsl:if test="name(preceding-sibling::*[1]) = 'classname'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
  </span>
</xsl:template>

<xsl:template match="interfacename" mode="java">
  <xsl:if test="name(preceding-sibling::*[1]) = 'interfacename'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
  </span>
</xsl:template>

<xsl:template match="exceptionname" mode="java">
  <xsl:if test="name(preceding-sibling::*[1]) = 'exceptionname'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
  </span>
</xsl:template>

<xsl:template match="fieldsynopsis" mode="java">
  <div class="{name(.)}">
    <xsl:text>&nbsp;&nbsp;</xsl:text>
    <xsl:apply-templates mode="java"/>
    <xsl:text>;</xsl:text>
  </div>
</xsl:template>

<xsl:template match="type" mode="java">
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="varname" mode="java">
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="initializer" mode="java">
  <span class="{name(.)}">
    <xsl:text>=&nbsp;</xsl:text>
    <xsl:apply-templates mode="java"/>
  </span>
</xsl:template>

<xsl:template match="void" mode="java">
  <span class="{name(.)}">
    <xsl:text>void&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="methodname" mode="java">
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
  </span>
</xsl:template>

<xsl:template match="methodparam" mode="java">
  <xsl:param name="indent">0</xsl:param>
  <xsl:if test="position() &gt; 1">
    <xsl:text>,&RE;</xsl:text>
    <xsl:if test="$indent &gt; 0">
      <xsl:call-template name="copy-string">
	<xsl:with-param name="string">&nbsp;</xsl:with-param>
	<xsl:with-param name="count" select="$indent + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
  </span>
</xsl:template>

<xsl:template match="parameter" mode="java">
  <span class="{name(.)}">
    <xsl:apply-templates mode="java"/>
  </span>
</xsl:template>

<xsl:template mode="java"
  match="constructorsynopsis|destructorsynopsis|methodsynopsis">
  <xsl:variable name="modifiers" select="modifier"/>
  <xsl:variable name="notmod" select="*[name(.) != 'modifier']"/>
  <xsl:variable name="decl">
    <xsl:text>  </xsl:text>
    <xsl:apply-templates select="$modifiers" mode="java"/>

    <!-- type -->
    <xsl:if test="name($notmod[1]) != 'methodname'">
      <xsl:apply-templates select="$notmod[1]" mode="java"/>
    </xsl:if>

    <xsl:apply-templates select="methodname" mode="java"/>
  </xsl:variable>

  <div class="{name(.)}">
    <xsl:copy-of select="$decl"/>
    <xsl:text>(</xsl:text>
    <xsl:apply-templates select="methodparam" mode="java">
      <xsl:with-param name="indent" select="string-length($decl)"/>
    </xsl:apply-templates>
    <xsl:text>)</xsl:text>
    <xsl:if test="exceptionname">
      <xsl:text>&RE;&nbsp;&nbsp;&nbsp;&nbsp;throws&nbsp;</xsl:text>
      <xsl:apply-templates select="exceptionname" mode="java"/>
    </xsl:if>
    <xsl:text>;</xsl:text>
  </div>
</xsl:template>

<!-- ===== C++ ========================================================= -->

<xsl:template match="classsynopsis" mode="cpp">
  <pre class="{name(.)}">
    <xsl:apply-templates select="ooclass[1]" mode="cpp"/>
    <xsl:if test="ooclass[position() &gt; 1]">
      <xsl:text>: </xsl:text>
      <xsl:apply-templates select="ooclass[position() &gt; 1]" mode="cpp"/>
      <xsl:if test="oointerface|ooexception">
	<xsl:text>&RE;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="oointerface">
      <xsl:text> implements</xsl:text>
      <xsl:apply-templates select="oointerface" mode="cpp"/>
      <xsl:if test="ooexception">
	<xsl:text>&RE;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="ooexception">
      <xsl:text> throws</xsl:text>
      <xsl:apply-templates select="ooexception" mode="cpp"/>
    </xsl:if>
    <xsl:text>&nbsp;{&RE;&RE;</xsl:text>
    <xsl:apply-templates select="constructorsynopsis
                                 |destructorsynopsis
                                 |fieldsynopsis
                                 |methodsynopsis
                                 |classsynopsisinfo" mode="cpp"/>
    <xsl:text>}</xsl:text>
  </pre>
</xsl:template>

<xsl:template match="classsynopsisinfo" mode="cpp">
  <xsl:apply-templates mode="cpp"/>
</xsl:template>

<xsl:template match="ooclass|oointerface|ooexception" mode="cpp">
  <xsl:if test="position() &gt; 1">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
  </span>
</xsl:template>

<xsl:template match="modifier" mode="cpp">
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="classname" mode="cpp">
  <xsl:if test="name(preceding-sibling::*[1]) = 'classname'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
  </span>
</xsl:template>

<xsl:template match="interfacename" mode="cpp">
  <xsl:if test="name(preceding-sibling::*[1]) = 'interfacename'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
  </span>
</xsl:template>

<xsl:template match="exceptionname" mode="cpp">
  <xsl:if test="name(preceding-sibling::*[1]) = 'exceptionname'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
  </span>
</xsl:template>

<xsl:template match="fieldsynopsis" mode="cpp">
  <div class="{name(.)}">
    <xsl:text>&nbsp;&nbsp;</xsl:text>
    <xsl:apply-templates mode="cpp"/>
    <xsl:text>;</xsl:text>
  </div>
</xsl:template>

<xsl:template match="type" mode="cpp">
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="varname" mode="cpp">
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="initializer" mode="cpp">
  <span class="{name(.)}">
    <xsl:text>=&nbsp;</xsl:text>
    <xsl:apply-templates mode="cpp"/>
  </span>
</xsl:template>

<xsl:template match="void" mode="cpp">
  <span class="{name(.)}">
    <xsl:text>void&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="methodname" mode="cpp">
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
  </span>
</xsl:template>

<xsl:template match="methodparam" mode="cpp">
  <xsl:if test="position() &gt; 1">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
  </span>
</xsl:template>

<xsl:template match="parameter" mode="cpp">
  <span class="{name(.)}">
    <xsl:apply-templates mode="cpp"/>
  </span>
</xsl:template>

<xsl:template mode="cpp"
  match="constructorsynopsis|destructorsynopsis|methodsynopsis">
  <xsl:variable name="modifiers" select="modifier"/>
  <xsl:variable name="notmod" select="*[name(.) != 'modifier']"/>
  <xsl:variable name="type">
  </xsl:variable>
  <div class="{name(.)}">
    <xsl:text>  </xsl:text>
    <xsl:apply-templates select="$modifiers" mode="cpp"/>

    <!-- type -->
    <xsl:if test="name($notmod[1]) != 'methodname'">
      <xsl:apply-templates select="$notmod[1]" mode="cpp"/>
    </xsl:if>

    <xsl:apply-templates select="methodname" mode="cpp"/>
    <xsl:text>(</xsl:text>
    <xsl:apply-templates select="methodparam" mode="cpp"/>
    <xsl:text>)</xsl:text>
    <xsl:if test="exceptionname">
      <xsl:text>&RE;&nbsp;&nbsp;&nbsp;&nbsp;throws&nbsp;</xsl:text>
      <xsl:apply-templates select="exceptionname" mode="cpp"/>
    </xsl:if>
    <xsl:text>;</xsl:text>
  </div>
</xsl:template>

<!-- ===== IDL ========================================================= -->

<xsl:template match="classsynopsis" mode="idl">
  <pre class="{name(.)}">
    <xsl:text>interface </xsl:text>
    <xsl:apply-templates select="ooclass[1]" mode="idl"/>
    <xsl:if test="ooclass[position() &gt; 1]">
      <xsl:text>: </xsl:text>
      <xsl:apply-templates select="ooclass[position() &gt; 1]" mode="idl"/>
      <xsl:if test="oointerface|ooexception">
	<xsl:text>&RE;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="oointerface">
      <xsl:text> implements</xsl:text>
      <xsl:apply-templates select="oointerface" mode="idl"/>
      <xsl:if test="ooexception">
	<xsl:text>&RE;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="ooexception">
      <xsl:text> throws</xsl:text>
      <xsl:apply-templates select="ooexception" mode="idl"/>
    </xsl:if>
    <xsl:text>&nbsp;{&RE;&RE;</xsl:text>
    <xsl:apply-templates select="constructorsynopsis
                                 |destructorsynopsis
                                 |fieldsynopsis
                                 |methodsynopsis
                                 |classsynopsisinfo" mode="idl"/>
    <xsl:text>}</xsl:text>
  </pre>
</xsl:template>

<xsl:template match="classsynopsisinfo" mode="idl">
  <xsl:apply-templates mode="idl"/>
</xsl:template>

<xsl:template match="ooclass|oointerface|ooexception" mode="idl">
  <xsl:if test="position() &gt; 1">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
  </span>
</xsl:template>

<xsl:template match="modifier" mode="idl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="classname" mode="idl">
  <xsl:if test="name(preceding-sibling::*[1]) = 'classname'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
  </span>
</xsl:template>

<xsl:template match="interfacename" mode="idl">
  <xsl:if test="name(preceding-sibling::*[1]) = 'interfacename'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
  </span>
</xsl:template>

<xsl:template match="exceptionname" mode="idl">
  <xsl:if test="name(preceding-sibling::*[1]) = 'exceptionname'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
  </span>
</xsl:template>

<xsl:template match="fieldsynopsis" mode="idl">
  <div class="{name(.)}">
    <xsl:text>&nbsp;&nbsp;</xsl:text>
    <xsl:apply-templates mode="idl"/>
    <xsl:text>;</xsl:text>
  </div>
</xsl:template>

<xsl:template match="type" mode="idl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="varname" mode="idl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="initializer" mode="idl">
  <span class="{name(.)}">
    <xsl:text>=&nbsp;</xsl:text>
    <xsl:apply-templates mode="idl"/>
  </span>
</xsl:template>

<xsl:template match="void" mode="idl">
  <span class="{name(.)}">
    <xsl:text>void&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="methodname" mode="idl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
  </span>
</xsl:template>

<xsl:template match="methodparam" mode="idl">
  <xsl:if test="position() &gt; 1">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
  </span>
</xsl:template>

<xsl:template match="parameter" mode="idl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="idl"/>
  </span>
</xsl:template>

<xsl:template mode="idl"
  match="constructorsynopsis|destructorsynopsis|methodsynopsis">
  <xsl:variable name="modifiers" select="modifier"/>
  <xsl:variable name="notmod" select="*[name(.) != 'modifier']"/>
  <xsl:variable name="type">
  </xsl:variable>
  <div class="{name(.)}">
    <xsl:text>  </xsl:text>
    <xsl:apply-templates select="$modifiers" mode="idl"/>

    <!-- type -->
    <xsl:if test="name($notmod[1]) != 'methodname'">
      <xsl:apply-templates select="$notmod[1]" mode="idl"/>
    </xsl:if>

    <xsl:apply-templates select="methodname" mode="idl"/>
    <xsl:text>(</xsl:text>
    <xsl:apply-templates select="methodparam" mode="idl"/>
    <xsl:text>)</xsl:text>
    <xsl:if test="exceptionname">
      <xsl:text>&RE;&nbsp;&nbsp;&nbsp;&nbsp;raises(</xsl:text>
      <xsl:apply-templates select="exceptionname" mode="idl"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:text>;</xsl:text>
  </div>
</xsl:template>

<!-- ===== Perl ======================================================== -->

<xsl:template match="classsynopsis" mode="perl">
  <pre class="{name(.)}">
    <xsl:text>package </xsl:text>
    <xsl:apply-templates select="ooclass[1]" mode="perl"/>
    <xsl:text>;&RE;</xsl:text>

    <xsl:if test="ooclass[position() &gt; 1]">
      <xsl:text>@ISA = (</xsl:text>
      <xsl:apply-templates select="ooclass[position() &gt; 1]" mode="perl"/>
      <xsl:text>);&RE;</xsl:text>
    </xsl:if>

    <xsl:apply-templates select="constructorsynopsis
                                 |destructorsynopsis
                                 |fieldsynopsis
                                 |methodsynopsis
                                 |classsynopsisinfo" mode="perl"/>
  </pre>
</xsl:template>

<xsl:template match="classsynopsisinfo" mode="perl">
  <xsl:apply-templates mode="perl"/>
</xsl:template>

<xsl:template match="ooclass|oointerface|ooexception" mode="perl">
  <xsl:if test="position() &gt; 1">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
  </span>
</xsl:template>

<xsl:template match="modifier" mode="perl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="classname" mode="perl">
  <xsl:if test="name(preceding-sibling::*[1]) = 'classname'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
  </span>
</xsl:template>

<xsl:template match="interfacename" mode="perl">
  <xsl:if test="name(preceding-sibling::*[1]) = 'interfacename'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
  </span>
</xsl:template>

<xsl:template match="exceptionname" mode="perl">
  <xsl:if test="name(preceding-sibling::*[1]) = 'exceptionname'">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
  </span>
</xsl:template>

<xsl:template match="fieldsynopsis" mode="perl">
  <div class="{name(.)}">
    <xsl:text>&nbsp;&nbsp;</xsl:text>
    <xsl:apply-templates mode="perl"/>
    <xsl:text>;</xsl:text>
  </div>
</xsl:template>

<xsl:template match="type" mode="perl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="varname" mode="perl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
    <xsl:text>&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="initializer" mode="perl">
  <span class="{name(.)}">
    <xsl:text>=&nbsp;</xsl:text>
    <xsl:apply-templates mode="perl"/>
  </span>
</xsl:template>

<xsl:template match="void" mode="perl">
  <span class="{name(.)}">
    <xsl:text>void&nbsp;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="methodname" mode="perl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
  </span>
</xsl:template>

<xsl:template match="methodparam" mode="perl">
  <xsl:if test="position() &gt; 1">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
  </span>
</xsl:template>

<xsl:template match="parameter" mode="perl">
  <span class="{name(.)}">
    <xsl:apply-templates mode="perl"/>
  </span>
</xsl:template>

<xsl:template mode="perl"
  match="constructorsynopsis|destructorsynopsis|methodsynopsis">
  <xsl:variable name="modifiers" select="modifier"/>
  <xsl:variable name="notmod" select="*[name(.) != 'modifier']"/>
  <xsl:variable name="type">
  </xsl:variable>
  <div class="{name(.)}">
    <xsl:text>sub </xsl:text>

    <xsl:apply-templates select="methodname" mode="perl"/>
    <xsl:text> { ... };</xsl:text>
  </div>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
