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
            <xsl:text>QA Reviews</xsl:text>
          </h1>
          <p>
            <xsl:text>This document contains all jobs under QA review.</xsl:text>
          </p>
          <xsl:apply-templates select="reviews"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="reviews[not(review)]">
    <p>
      <xsl:text>This are no jobs under review here yet.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="reviews[review]">
    <p>
      <xsl:text>Thare are </xsl:text>
      <xsl:value-of select="count(review)"/>
      <xsl:text> reviews pending:</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>Job</xsl:text>
          </th>
          <th>
            <xsl:text>Requested</xsl:text>
          </th>
          <th>
            <xsl:text>Inspector</xsl:text>
          </th>
          <th>
            <xsl:text>Performer</xsl:text>
          </th>
          <th>
            <xsl:text>Cash</xsl:text>
          </th>
          <th>
            <xsl:text>Mins</xsl:text>
          </th>
          <th>
            <xsl:text>Bonus</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="review">
          <xsl:sort select="@job" order="descending" data-type="text"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="review">
    <tr>
      <td>
        <xsl:call-template name="job">
          <xsl:with-param name="id" select="@job"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="requested"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="inspector"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="performer"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="cash"/>
      </td>
      <td>
        <xsl:value-of select="minutes"/>
      </td>
      <td>
        <xsl:value-of select="bonus"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
