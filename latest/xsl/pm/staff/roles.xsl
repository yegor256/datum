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
  <xsl:include href="../../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Roles and Members</xsl:text>
          </h1>
          <p>
            <xsl:text>This is a full list of people and their roles in the
            project. The ARC and the PO are
            allowed to assign roles and resign them. By </xsl:text>
            <a href="http://www.yegor256.com/2016/07/10/software-project-roles.html">
              <xsl:text>convention</xsl:text>
            </a>
            <xsl:text> we use these role names: </xsl:text>
            <a href="http://www.zerocracy.com/policy.html#ARC">
              <xsl:text>ARC</xsl:text>
            </a>
            <xsl:text> (architect), </xsl:text>
            <a href="http://www.zerocracy.com/policy.html#PO">
              <xsl:text>PO</xsl:text>
            </a>
            <xsl:text> (product owner), </xsl:text>
            <a href="http://www.zerocracy.com/policy.html#DEV">
              <xsl:text>DEV</xsl:text>
            </a>
            <xsl:text> (developer), </xsl:text>
            <a href="http://www.zerocracy.com/policy.html#REV">
              <xsl:text>REV</xsl:text>
            </a>
            <xsl:text> (code reviewer), </xsl:text>
            <a href="http://www.zerocracy.com/policy.html#TST">
              <xsl:text>TST</xsl:text>
            </a>
            <xsl:text> (tester), </xsl:text>
            <a href="http://www.zerocracy.com/policy.html#QA">
              <xsl:text>QA</xsl:text>
            </a>
            <xsl:text> (quality assurance), see </xsl:text>
            <a href="http://www.zerocracy.com/policy.html#13">§13</a>
            <xsl:text>.</xsl:text>
          </p>
          <xsl:apply-templates select="roles"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="roles">
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>Login</xsl:text>
          </th>
          <th>
            <xsl:text>Roles</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="person">
          <xsl:sort select="@id"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="person">
    <tr>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:for-each select="role">
          <xsl:if test="position() &gt; 1">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:value-of select="text()"/>
        </xsl:for-each>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
