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
  <xsl:template name="job">
    <xsl:param name="id"/>
    <xsl:choose>
      <xsl:when test="starts-with($id, 'gh:')">
        <xsl:variable name="issue" select="substring-after($id, '#')"/>
        <xsl:variable name="repo" select="substring-before(substring-after($id, 'gh:'), '#')"/>
        <a title="Issue #{$issue} in {$repo} GitHub repository"
          href="https://github.com/{$repo}/issues/{$issue}">
          <xsl:value-of select="$repo"/>
          <xsl:text>#</xsl:text>
          <xsl:value-of select="$issue"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <code>
          <xsl:value-of select="$id"/>
        </code>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="date">
    <xsl:param name="iso"/>
    <xsl:value-of select="$iso"/>
  </xsl:template>
  <xsl:template name="user">
    <xsl:param name="id"/>
    <xsl:choose>
      <xsl:when test="$id">
        <a href="https://github.com/{$id}" title="GitHub user @{$id}">
          <xsl:text>@</xsl:text>
          <xsl:value-of select="$id"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>-</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
