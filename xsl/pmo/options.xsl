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
  <xsl:include href="../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Options</xsl:text>
          </h1>
          <xsl:apply-templates select="options"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="options">
    <p>
      <xsl:text>Your options:</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>Option</xsl:text>
          </th>
          <th>
            <xsl:text>Value</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:if test="maxJobsInAgenda">
          <tr>
            <td>
              <xsl:text>Max jobs in agend</xsl:text>
            </td>
            <td>
              <xsl:value-of select="maxJobsInAgenda"/>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="notify">
          <tr>
            <td>
              <xsl:text>Notify</xsl:text>
            </td>
            <td>
              <xsl:if test="notify/rfps">
                <xsl:text>RFPS, </xsl:text>
              </xsl:if>
              <xsl:if test="notify/publish">
                <xsl:text>publish, </xsl:text>
              </xsl:if>
              <xsl:if test="notify/students">
                <xsl:text>students</xsl:text>
              </xsl:if>
            </td>
          </tr>
        </xsl:if>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
