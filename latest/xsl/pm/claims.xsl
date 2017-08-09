<?xml version="1.0" encoding="UTF-8"?>
<!--
 * Copyright (c) 2016-2017 Zerocracy
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to read
 * the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <xsl:apply-templates select="claims"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="claims[not(claim)]">
    <p>There are no claims yet.</p>
  </xsl:template>
  <xsl:template match="claims[claim]">
    <table>
      <thead>
        <tr>
          <th>
            <xsl:text>ID</xsl:text>
          </th>
          <th>
            <xsl:text>Type</xsl:text>
          </th>
          <th>
            <xsl:text>Author</xsl:text>
          </th>
          <th>
            <xsl:text>Created</xsl:text>
          </th>
          <th>
            <xsl:text>Token</xsl:text>
          </th>
          <th>
            <xsl:text>Params</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="claim"/>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="claim">
    <tr>
      <td>
        <xsl:value-of select="@id"/>
      </td>
      <td>
        <xsl:value-of select="type"/>
      </td>
      <td>
        <xsl:if test="author">
          <a href="https://github.com/{author}">
            <xsl:text>@</xsl:text>
            <xsl:value-of select="author"/>
          </a>
        </xsl:if>
        <xsl:if test="not(author)">
          <xsl:text>-</xsl:text>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="created"/>
      </td>
      <td>
        <code>
          <xsl:value-of select="token"/>
        </code>
      </td>
      <td>
        <xsl:apply-templates select="params"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="params">
    <xsl:for-each select="param">
      <xsl:if test="position() &gt; 1">
        <xsl:text>, </xsl:text>
      </xsl:if>
      <code>
        <xsl:value-of select="@name"/>
      </code>
      <xsl:text>=</xsl:text>
      <code>
        <xsl:value-of select="text()"/>
      </code>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
