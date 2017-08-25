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
  <xsl:template match="/milestones">
    <html lang="en">
      <body>
        <section>
          <h1>Milestones</h1>
          <p>
            This is the full list of milestones identified in the project.
            Jobs may use them for prioritization and scheduling.
          </p>
          <table>
            <thead>
              <tr>
                <th>
                  <xsl:text>Milestone</xsl:text>
                </th>
                <th>
                  <xsl:text>Date</xsl:text>
                </th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="milestone">
                <xsl:sort select="date" order="descending" data-type="text"/>
              </xsl:apply-templates>
            </tbody>
          </table>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="milestone">
    <tr>
      <td>
        <xsl:value-of select="@id"/>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="date"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
