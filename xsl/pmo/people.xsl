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
  <xsl:include href="../_templates.xsl"/>
  <xsl:template match="/people">
    <html lang="en">
      <body>
        <section>
          <h1>People</h1>
          <p>
            This is the full list of people we know.
          </p>
          <table>
            <thead>
              <tr>
                <th>
                  <xsl:text>ID</xsl:text>
                </th>
                <th>
                  <xsl:text>Name</xsl:text>
                </th>
                <th>
                  <xsl:text>Rate</xsl:text>
                </th>
                <th>
                  <xsl:text>Wallet</xsl:text>
                </th>
                <th>
                  <xsl:text>Email</xsl:text>
                </th>
                <th>
                  <xsl:text>Links</xsl:text>
                </th>
                <th>
                  <xsl:text>Vacation</xsl:text>
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="person"/>
            </tbody>
          </table>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="person">
    <tr>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="name"/>
      </td>
      <td>
        <xsl:value-of select="rate"/>
      </td>
      <td>
        <xsl:value-of select="wallet"/>
      </td>
      <td>
        <xsl:value-of select="email"/>
      </td>
      <td>
        <xsl:apply-templates select="links"/>
      </td>
      <td>
        <xsl:if test="vacation/text() = 'true'">
          <xsl:text>On vacation</xsl:text>
        </xsl:if>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="links">
    <xsl:for-each select="link">
      <xsl:if test="position() &gt; 1">
        <xsl:text>, </xsl:text>
      </xsl:if>
      <code>
        <xsl:value-of select="@rel"/>
      </code>
      <xsl:text>:</xsl:text>
      <code>
        <xsl:value-of select="@href"/>
      </code>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
