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
  <xsl:include href="../../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Orders</xsl:text>
          </h1>
          <p>
            <xsl:text>An order is a job that is assigned to a performer.</xsl:text>
          </p>
          <xsl:apply-templates select="orders"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="orders[not(order)]">
    <p>
      <xsl:text>There are no open orders in the project at the moment.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="orders[order]">
    <p>
      <xsl:text>This is the full list of </xsl:text>
      <xsl:value-of select="count(order)"/>
      <xsl:text> currently active orders in the project.</xsl:text>
    </p>
    <table>
      <thead>
        <tr>
          <th>
            <xsl:text>Job</xsl:text>
          </th>
          <th>
            <xsl:text>Performer</xsl:text>
          </th>
          <th>
            <xsl:text>Reason</xsl:text>
          </th>
          <th>
            <xsl:text>Created</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="order">
          <xsl:sort select="created" order="descending" data-type="text"/>
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
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="performer"/>
        </xsl:call-template>
      </td>
      <td>
        <pre style="max-height:5em;margin-bottom:0;">
          <xsl:value-of select="reason" disable-output-escaping="no"/>
        </pre>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="created"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
