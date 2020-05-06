<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2016-2020 Zerocracy

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
            <xsl:text>Work Breakdown Structure (WBS)</xsl:text>
          </h1>
          <p>
            <xsl:text>The WBS is a hierarchical decomposition of the total scope
            of work to be carried out by the project team to accomplish
            the project objectives and create the required deliverables.
            The WBS organizes and defines the total scope of the project,
            and represents the work specified in the current approved
            project scope statement.</xsl:text>
            <xsl:text> You can add and remove jobs to/from this list, see </xsl:text>
            <a href="http://www.zerocracy.com/policy.html#14">§14</a>
            <xsl:text>.</xsl:text>
          </p>
          <xsl:apply-templates select="wbs"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="wbs">
    <p>
      <xsl:text>There are </xsl:text>
      <xsl:value-of select="count(job)"/>
      <xsl:text> jobs in the WBS:</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>ID</xsl:text>
          </th>
          <th>
            <xsl:text>Role</xsl:text>
          </th>
          <th>
            <xsl:text>Created</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="job">
          <xsl:sort select="created" order="descending" data-type="text"/>
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
        <code>
          <xsl:value-of select="role"/>
        </code>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="created"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
