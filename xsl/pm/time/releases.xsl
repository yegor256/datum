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
  <xsl:include href="../../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Releases</xsl:text>
          </h1>
          <p>
            <xsl:text>
              This is a list of releases and their corresponding tags.
            </xsl:text>
          </p>
          <xsl:apply-templates select="roles"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="releases">
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>Repo</xsl:text>
          </th>
          <th>
            <xsl:text>Tag</xsl:text>
          </th>
          <th>
            <xsl:text>Published</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="release">
          <xsl:sort select="@repo"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="release">
    <tr>
      <td>
        <xsl:value-of select="@repo"/>
      </td>
      <td>
        <xsl:value-of select="@tag"/>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="published"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
