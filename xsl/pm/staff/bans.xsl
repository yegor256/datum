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
  <xsl:template match="/bans">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>List of Bans</xsl:text>
          </h1>
          <p>
            <xsl:text>This is the list of people who are banned from certain
            jobs for different reasons. Our automated election process
            takes this list into account when making a decision who
            should be the performer of a new job.</xsl:text>
          </p>
          <table data-sortable="true">
            <thead>
              <tr>
                <th>
                  <xsl:text>Job</xsl:text>
                </th>
                <th>
                  <xsl:text>Login</xsl:text>
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
              <xsl:apply-templates select="ban">
                <xsl:sort select="created" order="descending" data-type="text"/>
              </xsl:apply-templates>
            </tbody>
          </table>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="ban">
    <tr>
      <td>
        <xsl:call-template name="job">
          <xsl:with-param name="id" select="@job"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="login"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="reason"/>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="created"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
