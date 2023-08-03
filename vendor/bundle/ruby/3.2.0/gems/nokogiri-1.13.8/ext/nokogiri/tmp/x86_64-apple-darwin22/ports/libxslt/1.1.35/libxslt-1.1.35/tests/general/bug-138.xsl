<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://me.envelope"
    version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="report">
    <Message>
      <Header>
        <Title><xsl:value-of select="title"/></Title>
        <From><xsl:value-of select="origin"/></From>
      </Header>
      <Body xmlns="http://me.content">
        <xsl:for-each select="form">
          <Item>
            <Ref><xsl:value-of select="code"/></Ref>
            <xsl:element name="Info">
              <xsl:attribute name="desc">
                <xsl:value-of select="description"/>
              </xsl:attribute>
              <Note><xsl:value-of select="description/@note"/></Note>
            </xsl:element>
            <Quantity><xsl:value-of select="qty"/></Quantity>
          </Item>
        </xsl:for-each>
      </Body>
    </Message>
  </xsl:template>
</xsl:stylesheet>
