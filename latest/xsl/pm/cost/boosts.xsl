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
  <xsl:template match="/boosts">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Boost Factors</xsl:text>
          </h1>
          <p>
            <xsl:text>Any job may have a boost factor, which will increase
            its budget. The default boost factor of a job is 2x, which
            means 30 minutes.</xsl:text>
            <xsl:text>See </xsl:text>
            <a href="http://datum.zerocracy.com/pages/policy.html#5">§5</a>
            <xsl:text> and </xsl:text>
            <a href="http://datum.zerocracy.com/pages/policy.html#15">§15</a>
            <xsl:text>.</xsl:text>
          </p>
          <table data-sortable="true">
            <thead>
              <tr>
                <th>
                  <xsl:text>Job</xsl:text>
                </th>
                <th>
                  <xsl:text>Factor</xsl:text>
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="boost">
                <xsl:sort select="@id" order="descending" data-type="text"/>
              </xsl:apply-templates>
            </tbody>
          </table>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="boost">
    <tr>
      <td>
        <xsl:call-template name="job">
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="text()"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
