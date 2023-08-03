<?xml version="1.0"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="utf-8"/>

<xsl:template name="inventory" match="inventory">
  <html>
    <table border="1">
      <xsl:for-each select="warehouse">
        <tr>
          <td class="bigtablehead" colspan="3">
            Warehouse: <xsl:value-of select="name"/>
          </td>
        </tr>
        <tr>
          <td class="tablehead">Sku</td>
          <td class="tablehead">Quantity</td>
          <td class="tablehead">Description</td>
        </tr>
        <xsl:apply-templates select="items/item">
          <xsl:sort select="sku" data-type="number" order="ascending"/>
        </xsl:apply-templates>
        <tr>
          <td class="tablehead">Total:</td>
          <td class="tablehead" colspan="2"> 
             <xsl:value-of select="sum(items/item/qty)"/> instances of
             <xsl:value-of select="count(items/item)"/> kinds of items.
          </td>
        </tr>
      </xsl:for-each>
    </table>
    <table border="1">
      <tr>
        <td colspan="4">Need to Reorder:</td>
      </tr>
<!--        <xsl:copy-of select="$soldout"/> -->
      
      <xsl:apply-templates select="/inventory/warehouse/items/item[qty=0]">
        <xsl:with-param name="pwh" select="1"/>
      </xsl:apply-templates>
      
      <tr>
        <td>Total:</td>
        <td colspan="3">
          <xsl:value-of select="count(/inventory/warehouse/items/item[qty=0])"/> items
        </td>
      </tr>
    </table>
  </html>
</xsl:template>


<xsl:template name="item" match="item">
  <xsl:param name="pwh" select="0"/>
  <tr>
    <xsl:choose>
      <xsl:when test="$pwh=0">
        <td>
          <xsl:attribute name="class">tablecell</xsl:attribute>
          <xsl:value-of select="sku"/>
        </td>
        <td class="tablecell">
          <table border="1">
            <tr>
              <td width="40">     
                 <xsl:value-of select="qty"/>
              </td>
              <td width="{qty}" bgcolor="#ffffff">.</td>
              <td width="{100-qty}" bgcolor="#000000">.</td>
            </tr>     
          </table>
        </td>
        <td class="tablecell">
          <xsl:value-of select="desc"/>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td class="tablecell">
           <xsl:value-of select="ancestor::warehouse/name"/>
        </td>
        <td>
          <xsl:attribute name="class">tablecell</xsl:attribute>
          <xsl:value-of select="sku"/>
        </td>
        <td class="tablecell">
          <xsl:value-of select="qty"/>
        </td>
        <td class="tablecell">
          <xsl:value-of select="desc"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </tr>    
</xsl:template>

<!--
<xsl:variable name="soldout">
  <xsl:apply-templates select="/inventory/warehouse/items/item[qty=0]">
    <xsl:with-param name="pwh" select="1"/>
  </xsl:apply-templates>
</xsl:variable>
-->

</xsl:stylesheet>



    