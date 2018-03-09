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
  <xsl:include href="../../templates.xsl"/>
  <xsl:template match="/">
    <html lang="en">
      <body>
        <section>
          <h1>
            <xsl:text>Ledger</xsl:text>
          </h1>
          <p>
            <xsl:text>The Ledger is a full list of transactions that
              happened in the project since we started to manage it.</xsl:text>
          </p>
          <xsl:apply-templates select="ledger"/>
        </section>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="ledger">
    <xsl:apply-templates select="deficit"/>
    <xsl:apply-templates select="balance"/>
    <xsl:apply-templates select="transactions"/>
  </xsl:template>
  <xsl:template match="deficit">
    <p>
      <span style="color:darkred">
        <xsl:text>IMPORTANT</xsl:text>
      </span>
      <xsl:text>: The project is in </xsl:text>
      <strong>
        <xsl:text>deficit</xsl:text>
      </strong>
      <xsl:text>. This means that all funds are currently allocated to active orders.</xsl:text>
      <xsl:text> You need to fund it if you want to continue assigning jobs to performers and pay them.</xsl:text>
    </p>
  </xsl:template>
  <xsl:template match="balance">
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>Account</xsl:text>
          </th>
          <th>
            <xsl:text>Dt</xsl:text>
          </th>
          <th>
            <xsl:text>Ct</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="account">
          <xsl:sort select="name" data-type="text"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="account">
    <tr>
      <td>
        <xsl:value-of select="name"/>
        <xsl:if test="namex">
          <xsl:text>:</xsl:text>
          <xsl:value-of select="namex"/>
        </xsl:if>
      </td>
      <td style="text-align:right">
        <xsl:value-of select="dt"/>
      </td>
      <td style="text-align:right">
        <xsl:value-of select="ct"/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="transactions">
    <p>
      <xsl:text>There are </xsl:text>
      <xsl:value-of select="count(transaction)"/>
      <xsl:text> transactions in the Ledger:</xsl:text>
    </p>
    <table data-sortable="true">
      <thead>
        <tr>
          <th>
            <xsl:text>ID</xsl:text>
          </th>
          <th style="text-align:right">
            <xsl:text>Amount</xsl:text>
          </th>
          <th>
            <xsl:text>Dt/Ct</xsl:text>
          </th>
          <th>
            <xsl:text>Details</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="transaction">
          <xsl:sort select="created" order="descending" data-type="text"/>
        </xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="transaction">
    <tr>
      <td>
        <xsl:value-of select="@id"/>
        <xsl:if test="@parent">
          <sub>
            <xsl:value-of select="@parent"/>
          </sub>
        </xsl:if>
        <span style="display:block;font-size:0.8em;line-height:0.8em;">
          <xsl:call-template name="date">
            <xsl:with-param name="iso" select="created"/>
          </xsl:call-template>
        </span>
      </td>
      <td style="text-align:right">
        <xsl:value-of select="amount"/>
      </td>
      <td>
        <span style="display:block">
          <xsl:value-of select="dt"/>
          <xsl:text>:</xsl:text>
          <xsl:value-of select="dtx"/>
        </span>
        <span style="display:block">
          <xsl:value-of select="ct"/>
          <xsl:text>:</xsl:text>
          <xsl:value-of select="ctx"/>
        </span>
      </td>
      <td>
        <xsl:call-template name="par">
          <xsl:with-param name="text" select="details"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
