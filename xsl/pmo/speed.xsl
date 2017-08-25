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
  <xsl:template match="/speed">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Speed of Delivery</xsl:text>
          </h1>
          <p>
            <xsl:text>Per each job completed we collect "speed of delivery"
            statistical information. The time interval between
            the moment of job order creation and the moment of
            the order successful closing goes into this document.</xsl:text>
          </p>
          <table>
            <thead>
              <tr>
                <th>
                  <xsl:text>Job</xsl:text>
                </th>
                <th>
                  <xsl:text>Project</xsl:text>
                </th>
                <th>
                  <xsl:text>Time</xsl:text>
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="order">
                <xsl:apply-templates select="."/>
              </xsl:for-each>
            </tbody>
          </table>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="order">
    <tr>
      <td>
        <xsl:call-template name="job">
          <xsl:with-param name="id" select="@job"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="project">
          <xsl:with-param name="id" select="project"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="concat(minutes, ' min.')"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
