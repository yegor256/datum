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
  xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <xsl:template match="/awards">
    <html lang="en">
      <body>
        <section>
          <table>
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
              <xsl:apply-templates select="award"/>
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
        <code>
          <xsl:value-of select="project"/>
        </code>
      </td>
      <td>
        <code>
          <xsl:value-of select="job"/>
        </code>
      </td>
      <td>
        <xsl:value-of select="added"/>
      </td>
      <td>
        <xsl:value-of select="reason"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
