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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
  <xsl:include href="../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>People</h1>
          <xsl:apply-templates select="resumes"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="resume">
    <p>
      <xsl:text>Resumes:</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>Login</xsl:text>
          </th>
          <th>
            <xsl:text>Submitted</xsl:text>
          </th>
          <th>
            <xsl:text>Examiner</xsl:text>
          </th>
          <th>
            <xsl:text>Text</xsl:text>
          </th>
          <th>
            <xsl:text>Stackoverflow</xsl:text>
          </th>
          <th>
            <xsl:text>Telegram</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="resume"/>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="resume">
    <tr>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="@login"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="submitted"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="text"/>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="examiner">
            <xsl:call-template name="user">
              <xsl:with-param name="id" select="examiner"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>—</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:call-template name="stackoverflow">
          <xsl:with-param name="id" select="stackoverflow"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="telegram">
          <xsl:with-param name="id" select="telegram"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
