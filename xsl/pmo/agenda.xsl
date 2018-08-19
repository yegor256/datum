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
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Your Agenda</xsl:text>
          </h1>
          <xsl:apply-templates select="agenda"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="agenda[not(order)]">
    <p>
      <xsl:text>Your agenda is empty at the moment, there are no jobs to work with.
      Most likely you are not a member of any projects yet, or the projects
      have no new jobs for you. Feel free to </xsl:text>
      <a href="http://www.zerocracy.com/policy.html#2">
        <xsl:text>apply</xsl:text>
      </a>
      <xsl:text> to new projects from the </xsl:text>
      <a href="https://www.0crat.com/board">
        <xsl:text>Board</xsl:text>
      </a>
      <xsl:text>.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="agenda[order]">
    <p>
      <xsl:text>This is the full list of </xsl:text>
      <xsl:value-of select="count(order)"/>
      <xsl:text> jobs currently assigned to you
      in all projects we are managing. Zerocrat adds jobs here
      automatically. This list is presented for the sake of
      your convenience.</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>Job</xsl:text>
          </th>
          <th>
            <xsl:text>Title</xsl:text>
          </th>
          <th>
            <xsl:text>Added</xsl:text>
          </th>
          <th>
            <xsl:text>Role</xsl:text>
          </th>
          <th>
            <xsl:text>Cost</xsl:text>
            <sub>
              <xsl:text>/</xsl:text>
              <a href="http://www.zerocracy.com/policy.html#4">
                <xsl:text>§4</xsl:text>
              </a>
            </sub>
          </th>
          <th>
            <xsl:text>Imp.</xsl:text>
            <sub>
              <xsl:text>/</xsl:text>
              <a href="http://www.zerocracy.com/policy.html#9">
                <xsl:text>§9</xsl:text>
              </a>
            </sub>
          </th>
          <th>
            <xsl:text>QA Rev.</xsl:text>
            <sub>
              <xsl:text>/</xsl:text>
              <a href="http://www.zerocracy.com/policy.html#30">
                <xsl:text>§30</xsl:text>
              </a>
            </sub>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="order">
          <xsl:sort select="added" order="descending" data-type="text"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="order">
    <tr>
      <xsl:attribute name="style">
        <xsl:choose>
          <xsl:when test="inspector">
            <xsl:text>opacity:0.5;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <td>
        <xsl:call-template name="job">
          <xsl:with-param name="id" select="@job"/>
        </xsl:call-template>
        <xsl:call-template name="project">
          <xsl:with-param name="id" select="project"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="title"/>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="added"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="role">
          <xsl:with-param name="role" select="role"/>
        </xsl:call-template>
      </td>
      <td style="text-align:right">
        <xsl:choose>
          <xsl:when test="estimate">
            <xsl:value-of select="estimate"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>—</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:value-of select="impediment"/>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="inspector">
            <a href="https://www.0crat.com/u/{inspector}" title="@{inspector}">
              <img src="https://socatar.com/github/{inspector}/90-90" style="width:30px;height:30px;border-radius:3px;vertical-align:middle;"/>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>-</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
