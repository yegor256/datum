<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2016-2019 Zerocracy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to read
the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="xml"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="/">
    <errors>
      <xsl:apply-templates select="document('impediments.xml')/impediments/order"/>
    </errors>
  </xsl:template>
  <xsl:template match="order">
    <xsl:variable name="job" select="@id"/>
    <xsl:if test="not(document('orders.xml')/orders/order[@job=$job])">
      <error>
        <xsl:text>The impediment for order/job "</xsl:text>
        <xsl:value-of select="$job"/>
        <xsl:text>" exists in impediments.xml, but the order is absent among </xsl:text>
        <xsl:value-of select="count(document('orders.xml')/orders/order)"/>
        <xsl:text> orders.</xsl:text>
      </error>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
