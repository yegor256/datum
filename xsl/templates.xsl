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
  <xsl:param name="today" select="'2000-01-01T12:00:00Z'"/>
  <xsl:template name="job">
    <xsl:param name="id"/>
    <xsl:choose>
      <xsl:when test="starts-with($id, 'gh:')">
        <xsl:variable name="issue" select="substring-after($id, '#')"/>
        <xsl:variable name="repo" select="substring-before(substring-after($id, 'gh:'), '#')"/>
        <a title="Issue #{$issue} in {$repo} GitHub repository" href="https://github.com/{$repo}/issues/{$issue}">
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
  <xsl:template name="minutes">
    <xsl:param name="iso"/>
    <xsl:variable name="year" select="number(substring($iso, 0, 5))"/>
    <xsl:variable name="month" select="number(substring($iso, 6, 2))"/>
    <xsl:variable name="day" select="number(substring($iso, 9, 2))"/>
    <xsl:variable name="hour" select="number(substring($iso, 12, 2))"/>
    <xsl:variable name="minute" select="number(substring($iso, 15, 2))"/>
    <xsl:value-of select="$minute + $hour * 60 + $day * 60 * 24 + $month * 60 * 24 * 30 + $year * 60 * 24 * 365"/>
  </xsl:template>
  <xsl:template name="date">
    <xsl:param name="iso"/>
    <xsl:variable name="then">
      <xsl:call-template name="minutes">
        <xsl:with-param name="iso" select="$iso"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="now">
      <xsl:call-template name="minutes">
        <xsl:with-param name="iso" select="$today"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="diff" select="$now - $then"/>
    <span title="{$iso}">
      <xsl:choose>
        <xsl:when test="$diff &lt; 60">
          <xsl:value-of select="$diff"/>
          <xsl:text> mins</xsl:text>
        </xsl:when>
        <xsl:when test="$diff &lt; 60 * 24">
          <xsl:value-of select="format-number($diff div 60, '0')"/>
          <xsl:text> hours</xsl:text>
        </xsl:when>
        <xsl:when test="$diff &lt; 60 * 24 * 30">
          <xsl:value-of select="format-number($diff div (60 * 24), '0')"/>
          <xsl:text> days</xsl:text>
        </xsl:when>
        <xsl:when test="$diff &lt; 60 * 24 * 365">
          <xsl:value-of select="format-number($diff div (60 * 24 * 30), '0.#')"/>
          <xsl:text> months</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="format-number($diff div (60 * 24 * 365), '0.#')"/>
          <xsl:text> years</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text> ago</xsl:text>
    </span>
  </xsl:template>
  <xsl:template name="user">
    <xsl:param name="id"/>
    <xsl:choose>
      <xsl:when test="$id">
        <a href="https://www.0crat.com/u/{$id}" title="@{$id}">
          <xsl:text>@</xsl:text>
          <xsl:value-of select="$id"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>-</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="project">
    <xsl:param name="id"/>
    <code>
      <a href="https://www.0crat.com/p/{$id}" title="Project {$id}">
        <xsl:value-of select="$id"/>
      </a>
    </code>
  </xsl:template>
  <xsl:template name="role">
    <xsl:param name="role"/>
    <code>
      <xsl:value-of select="$role"/>
    </code>
  </xsl:template>
  <xsl:template name="par">
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
