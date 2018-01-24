<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2016-2018 Zerocracy

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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <xsl:include href="../../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Equity</xsl:text>
          </h1>
          <xsl:apply-templates select="equity"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="equity">
    <p>
      <xsl:text>Capitalization: </xsl:text>
      <xsl:choose>
        <xsl:when test="cap">
          <xsl:value-of select="cap"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>—</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>, total shares: </xsl:text>
      <xsl:choose>
        <xsl:when test="shares">
          <xsl:value-of select="shares"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>—</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>.</xsl:text>
    </p>
    <xsl:apply-templates select="owners">
      <xsl:sort select="." order="descending" data-type="number"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="owners[not(owner)]">
    <p>
      <xsl:text>There are no owners yet, see </xsl:text>
      <a href="http://datum.zerocracy.com/pages/policy.html#37">
        <xsl:text>§37</xsl:text>
      </a>
      <xsl:text>.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="owners[owner]">
    <p>
      <xsl:text>Full list of owners:</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>User</xsl:text>
          </th>
          <th style="text-align:right">
            <xsl:text>Stocks</xsl:text>
          </th>
          <th style="text-align:right">
            <xsl:text>Share</xsl:text>
          </th>
          <xsl:if test="starts-with(/equity/cap,'$')">
            <th style="text-align:right">
              <xsl:text>Value</xsl:text>
            </th>
          </xsl:if>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="owner"/>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="owner">
    <tr>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </td>
      <td style="text-align:right">
        <xsl:value-of select="format-number(text(),'0.00')"/>
      </td>
      <td style="text-align:right">
        <xsl:value-of select="format-number(100 * text() div /equity/shares,'0.0000')"/>
        <xsl:text>%</xsl:text>
      </td>
      <xsl:if test="starts-with(/equity/cap,'$')">
        <xsl:variable name="cap" select="substring(/equity/cap,2)" as="number"/>
        <td style="text-align:right">
          <xsl:text>$</xsl:text>
          <xsl:value-of select="format-number(text() div /equity/shares * $cap,'0.00')"/>
        </td>
      </xsl:if>
    </tr>
  </xsl:template>
</xsl:stylesheet>
