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
          <p>
            <xsl:text>Capitalization: </xsl:text>
            <xsl:value-of select="cap"/>
            <xsl:text>, total shares: </xsl:text>
            <xsl:value-of select="shares"/>
            <xsl:text>.</xsl:text>
          </p>
          <xsl:apply-templates select="owners"/>
        </section>
      </body>
    </html>
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
    <table>
      <thead>
        <tr>
          <th>
            <xsl:text>User</xsl:text>
          </th>
          <th>
            <xsl:text>Shares</xsl:text>
          </th>
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
        <xsl:value-of select="format-number(.,'0.00')"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
