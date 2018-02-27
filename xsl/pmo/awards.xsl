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
            <xsl:value-of select="sum(award/points)"/>
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
                  <xsl:text>Added</xsl:text>
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
      <td>
        <xsl:if test="points &gt; 0">
          <xsl:text>+</xsl:text>
        </xsl:if>
        <xsl:value-of select="points"/>
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
        <xsl:call-template name="date">
          <xsl:with-param name="iso" select="added"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:call-template name="award-reason">
          <xsl:with-param name="reason" select="reason"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
  <xsl:template name="award-reason">
    <xsl:param name="reason"/>
    <xsl:call-template name="award-tokenize">
      <xsl:with-param name="text" select="$reason"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="award-tokenize">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text, '§')">
        <xsl:if test="substring-before($text, '§') != ''">
          <xsl:value-of select="substring-before($text, '§')"/>
        </xsl:if>
        <xsl:call-template name="buildParagraphAnchor">
          <xsl:with-param name="tail" select="substring-after($text, '§')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="buildParagraphAnchor">
    <xsl:param name="tail"/>
    <xsl:variable name="paragraphNumber">
      <xsl:choose>
        <xsl:when test="contains($tail, ' ')">
          <xsl:value-of select="substring-before($tail, ' ')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$tail"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <a href="http://www.zerocracy.com/policy.html#{$paragraphNumber}">
      <xsl:text>§</xsl:text>
      <xsl:value-of select="$paragraphNumber"/>
    </a>
    <xsl:if test="contains($tail, ' ')">
      <xsl:call-template name="award-tokenize">
        <xsl:with-param name="text" select="concat(' ', substring-after($tail, ' '))"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
