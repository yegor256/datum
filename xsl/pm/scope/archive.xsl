<?xml version="1.0" encoding="UTF-8"?>
<!--
 * Copyright (c) 2016-2017 Zerocracy
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to read
 * the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  version="1.0">
  <xsl:include href="../../_templates.xsl"/>
  <xsl:template match="/archive">
    <html lang="en">
      <body>
        <section>
          <h1>Archive of Jobs</h1>
          <p>
            This is the full list of jobs removed from the WBS
            because of completion.
          </p>
          <table>
            <thead>
              <tr>
                <th>
                  <xsl:text>ID</xsl:text>
                </th>
                <th>
                  <xsl:text>Created</xsl:text>
                </th>
                <th>
                  <xsl:text>Removed</xsl:text>
                </th>
                <th>
                  <xsl:text>Performer</xsl:text>
                </th>
                <th>
                  <xsl:text>Reason</xsl:text>
                </th>
                <th>
                  <xsl:text>Boost</xsl:text>
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="job"/>
            </tbody>
          </table>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="job">
    <tr>
      <td>
        <xsl:call-template name="job">
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="created"/>
      </td>
      <td>
        <xsl:value-of select="removed"/>
      </td>
      <td>
        <xsl:if test="performer">
          <xsl:value-of select="performer"/>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="reason"/>
      </td>
      <td>
        <xsl:value-of select="boost"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
