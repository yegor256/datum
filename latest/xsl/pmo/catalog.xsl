<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2016-2017 Zerocracy

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
  <xsl:include href="../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Catalog of Projects</xsl:text>
          </h1>
          <xsl:apply-templates select="catalog"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="catalog">
    <p>
      <xsl:text>This is the full list of </xsl:text>
      <xsl:value-of select="count(project)"/>
      <xsl:text> we work with:</xsl:text>
    </p>
    <table>
      <thead>
        <tr>
          <th>
            <xsl:text>ID</xsl:text>
          </th>
          <th>
            <xsl:text>Created</xsl:text>
          </th>
          <th>
            <xsl:text>Prefix</xsl:text>
          </th>
          <th>
            <xsl:text>Links</xsl:text>
          </th>
          <th>
            <xsl:text>Publish</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="project"/>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="project">
    <tr>
      <td>
        <xsl:call-template name="project">
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="created"/>
        </xsl:call-template>
      </td>
      <td>
        <code>
          <xsl:value-of select="prefix"/>
        </code>
      </td>
      <td>
        <xsl:apply-templates select="links"/>
      </td>
      <td>
        <xsl:value-of select="publish"/>
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
