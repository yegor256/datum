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
          <h1>Reminders</h1>
          <p>
            <xsl:text>This document is updated automatically, you don't have
              to do anything with it. We remind users sometimes in their
              jobs for different reasons and keep that reminders here,
              in order to avoid duplication.</xsl:text>
          </p>
          <xsl:apply-templates select="reminders"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="reminders[not(order)]">
    <p>
      <xsl:text>This are not reminders here yet.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="reminders[order]">
    <p>
      <xsl:text>This is the full list of reminders in the current project.</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>Order</xsl:text>
          </th>
          <th>
            <xsl:text>Reminders</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="order">
          <xsl:sort select="@job" order="descending" data-type="text"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="order">
    <tr>
      <td>
        <xsl:call-template name="job">
          <xsl:with-param name="id" select="@job"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:for-each select="reminder">
          <xsl:if test="position() &gt; 1">
            <xsl:text>; </xsl:text>
          </xsl:if>
          <code>
            <xsl:value-of select="label"/>
          </code>
          <xsl:text>/</xsl:text>
          <xsl:call-template name="user">
            <xsl:with-param name="id" select="login"/>
          </xsl:call-template>
        </xsl:for-each>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
