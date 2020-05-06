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
  <xsl:include href="../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Claims</xsl:text>
          </h1>
          <p>
            <xsl:text>Claims are instructions and messages our internal software
            "stakeholders" send to each other in order to manage
            the artifacts. They are created in this artifact and processed
            almost immediately. Refresh this page and you will see
            a new version of the claims, they change every second.</xsl:text>
          </p>
          <xsl:apply-templates select="claims/@busy"/>
          <xsl:apply-templates select="claims"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="claims/@busy">
    <p>
      <xsl:text>Busy: </xsl:text>
      <span style="color:red;">
        <xsl:value-of select="."/>
      </span>
      <xsl:text>.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="claims[not(claim)]">
    <p>
      <xsl:text>There are no claims yet.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="claims[claim]">
    <p>
      <xsl:text>There are </xsl:text>
      <xsl:value-of select="count(claim)"/>
      <xsl:text> claims.</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>ID</xsl:text>
          </th>
          <th>
            <xsl:text>Type</xsl:text>
          </th>
          <th>
            <xsl:text>Author</xsl:text>
          </th>
          <th>
            <xsl:text>Created</xsl:text>
          </th>
          <th>
            <xsl:text>Token</xsl:text>
          </th>
          <th>
            <xsl:text>Params</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="claim">
          <xsl:sort select="@id" order="ascending" data-type="number"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="claim">
    <tr>
      <td>
        <xsl:value-of select="@id"/>
        <xsl:if test="until">
          <span title="{until}" style="color:red;display:block;font-size:0.8em;line-height:0.8em;">
            <xsl:text>until</xsl:text>
          </span>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="type"/>
      </td>
      <td>
        <xsl:call-template name="user">
          <xsl:with-param name="id" select="author"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="created"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:if test="token">
          <code>
            <xsl:value-of select="token"/>
          </code>
        </xsl:if>
      </td>
      <td>
        <xsl:apply-templates select="params"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="params">
    <xsl:for-each select="param">
      <xsl:if test="position() &gt; 1">
        <br/>
      </xsl:if>
      <code>
        <xsl:value-of select="@name"/>
      </code>
      <xsl:text>:</xsl:text>
      <code>
        <xsl:value-of select="text()"/>
      </code>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
