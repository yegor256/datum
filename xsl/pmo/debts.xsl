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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
  <xsl:include href="../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>Debts</h1>
          <xsl:apply-templates select="debts"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="debts">
    <p>
      <xsl:text>The full list of </xsl:text>
      <xsl:value-of select="count(debt)"/>
      <xsl:text> debts:</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>User</xsl:text>
          </th>
          <th>
            <xsl:text>Items</xsl:text>
          </th>
          <th>
            <xsl:text>Failure</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="debt"/>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="debt">
    <tr>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="@login"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:apply-templates select="items"/>
      </td>
      <td>
        <xsl:apply-templates select="failure"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="items">
    <ul>
      <xsl:for-each select="item">
        <li>
          <xsl:value-of select="amount"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="created"/>
          <xsl:text> </xsl:text>
          <xsl:call-template name="par">
            <xsl:with-param name="text" select="details"/>
          </xsl:call-template>
          <xsl:text> (</xsl:text>
          <xsl:call-template name="par">
            <xsl:with-param name="text" select="reason"/>
          </xsl:call-template>
          <xsl:text>)</xsl:text>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  <xsl:template match="failure">
    <xsl:text>#</xsl:text>
    <xsl:value-of select="attempt"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="created"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="reason"/>
  </xsl:template>
</xsl:stylesheet>
