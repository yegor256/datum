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
            <xsl:text>Elections</xsl:text>
          </h1>
          <p>
            <xsl:text>Zerocrat automatically elects performers and assigns jobs
            to them. This is the full list of jobs where elections
            already happened. The results of them are here, with full details.</xsl:text>
            <xsl:text>See </xsl:text>
            <a href="http://datum.zerocracy.com/pages/policy.html#3">par.3</a>
            <xsl:text>.</xsl:text>
          </p>
          <xsl:apply-templates select="elections"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="elections[not(job)]">
    <p>
      <xsl:text>There are no elections at the moment in the project.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="elections[job]">
    <table>
      <thead>
        <tr>
          <th>
            <xsl:text>Job</xsl:text>
          </th>
          <th>
            <xsl:text>Elections</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="job">
          <xsl:sort select="@id" order="descending" data-type="text"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="job">
    <tr>
      <td>
        <xsl:call-template name="job">
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </td>
      <td>
        <div style="max-height:4em;">
          <ul>
            <xsl:apply-templates select="election"/>
          </ul>
        </div>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="election">
    <li>
      <xsl:text>Elected </xsl:text>
      <xsl:call-template name="date">
        <xsl:with-param name="iso" select="@date"/>
      </xsl:call-template>
      <ul>
        <xsl:apply-templates select="vote"/>
      </ul>
    </li>
  </xsl:template>
  <xsl:template match="vote">
    <li>
      <code>
        <xsl:value-of select="@author"/>
      </code>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="@weight"/>
      <xsl:text>):</xsl:text>
      <ul>
        <xsl:apply-templates select="person"/>
      </ul>
    </li>
  </xsl:template>
  <xsl:template match="person">
    <li>
      <xsl:call-template name="user">
        <xsl:with-param name="id" select="@login"/>
      </xsl:call-template>
      <xsl:text>; </xsl:text>
      <xsl:value-of select="@points"/>
      <xsl:text>; </xsl:text>
      <xsl:value-of select="text()"/>
    </li>
  </xsl:template>
</xsl:stylesheet>
