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
            <xsl:text>Rates</xsl:text>
          </h1>
          <xsl:apply-templates select="rates"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="rates[not(person)]">
    <p>
      <xsl:text>There are no rates set yet. Default rates users have in their
        profiles will be used when it's time to pay them. If you want to
        set user's rate, see </xsl:text>
      <a href="http://datum.zerocracy.com/pages/policy.html#16">
        <xsl:text>par.16</xsl:text>
      </a>
      <xsl:text>.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="rates[person]">
    <p>
      <xsl:text>Full list of rates of people in this project.</xsl:text>
    </p>
    <table>
      <thead>
        <tr>
          <th>
            <xsl:text>User</xsl:text>
          </th>
          <th>
            <xsl:text>Rate</xsl:text>
          </th>
          <th>
            <xsl:text>Created</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="person"/>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="person">
    <tr>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="rate"/>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="created"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
