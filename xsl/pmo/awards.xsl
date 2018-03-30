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
  <xsl:template match="/awards">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Your Awards</xsl:text>
          </h1>
          <p>
            <xsl:text>This is the full list of points recently awarded to you by Zerocrat in </xsl:text>
            <xsl:value-of select="count(award)"/>
            <xsl:text> awards. The list is updated automatically every time you get a new award.</xsl:text>
            <xsl:text> Total score is </xsl:text>
            <xsl:call-template name="points">
              <xsl:with-param name="sum" select="sum(award/points)"/>
            </xsl:call-template>
            <xsl:text>.</xsl:text>
            <xsl:text> Remember, we automatically delete expired awards, according to </xsl:text>
            <a href="http://www.zerocracy.com/policy.html#18">
              <xsl:text>§18</xsl:text>
            </a>
            <xsl:text>.</xsl:text>
          </p>
          <table data-sortable="true">
            <thead>
              <tr>
                <th>
                  <xsl:text>Points</xsl:text>
                </th>
                <th>
                  <xsl:text>Project</xsl:text>
                </th>
                <th>
                  <xsl:text>Job</xsl:text>
                </th>
                <th>
                  <xsl:text>Reason</xsl:text>
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="award">
                <xsl:sort select="added" order="descending" data-type="text"/>
                <xsl:apply-templates select="."/>
              </xsl:for-each>
            </tbody>
          </table>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="award">
    <tr>
      <td style="text-align:right">
        <xsl:call-template name="points">
          <xsl:with-param name="sum" select="points"/>
        </xsl:call-template>
        <span style="line-height:0.8em;font-size:0.8em;color:gray;display:block;">
          <xsl:call-template name="date">
            <xsl:with-param name="iso" select="added"/>
          </xsl:call-template>
        </span>
      </td>
      <td>
        <xsl:call-template name="project">
          <xsl:with-param name="id" select="project"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="job">
          <xsl:with-param name="id" select="job"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="par">
          <xsl:with-param name="text" select="reason"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
