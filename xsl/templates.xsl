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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/1999/xhtml" version="2.0">
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
      <xsl:when test="$id = 'none'">
        <xsl:text>—</xsl:text>
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
    <xsl:variable name="monthdays" select="28"/>
    <xsl:choose>
      <xsl:when test="$month = 1 or $month = 3 or $month = 5 or $month = 7 or $month = 8 or $month = 10 or $month = 12">
        <xsl:variable name="monthdays" select="31"/>
      </xsl:when>
      <xsl:when test="$month = 4 or $month = 6 or $month = 9 or $month = 11">
        <xsl:variable name="monthdays" select="30"/>
      </xsl:when>
      <xsl:when test="$month = 2 and ($year mod 4 = 0 and $year mod 100 != 0) or $year mod 400">
        <xsl:variable name="monthdays" select="29"/>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="$minute + $hour * 60 + $day * 60 * 24 + $month * 60 * 24 * $monthdays + $year * 60 * 24 * 365"/>
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
    <xsl:variable name="ago">
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
    </xsl:variable>
    <span title="${ago} ago at {$iso}">
      <xsl:value-of select="$ago"/>
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
      <xsl:attribute name="style">
        <xsl:text>background-color:</xsl:text>
        <xsl:choose>
          <xsl:when test="$id = 'PMO'">
            <xsl:text>lightcoral</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>#daf1e0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>;</xsl:text>
      </xsl:attribute>
      <a href="https://www.0crat.com/p/{$id}" title="Project {$id}">
        <xsl:value-of select="$id"/>
      </a>
    </code>
  </xsl:template>
  <xsl:template name="points">
    <xsl:param name="sum"/>
    <span>
      <xsl:attribute name="style">
        <xsl:text>color:</xsl:text>
        <xsl:choose>
          <xsl:when test="$sum &gt; 256">
            <xsl:text>darkgreen</xsl:text>
          </xsl:when>
          <xsl:when test="$sum &gt; 0">
            <xsl:text>orange</xsl:text>
          </xsl:when>
          <xsl:when test="$sum &lt; 0">
            <xsl:text>darkred</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>inherit</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>;</xsl:text>
      </xsl:attribute>
      <xsl:if test="$sum &gt; 0">
        <xsl:text>+</xsl:text>
      </xsl:if>
      <xsl:value-of select="$sum"/>
    </span>
  </xsl:template>
  <xsl:template name="role">
    <xsl:param name="role"/>
    <code>
      <xsl:attribute name="style">
        <xsl:text>background-color:</xsl:text>
        <xsl:choose>
          <xsl:when test="$role = 'REV'">
            <xsl:text>lightsalmon</xsl:text>
          </xsl:when>
          <xsl:when test="$role = 'QA'">
            <xsl:text>lightseagreen</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>#daf1e0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>;</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="$role"/>
    </code>
  </xsl:template>
  <xsl:template name="par">
    <xsl:param name="text" />
    <xsl:analyze-string select="$text" regex="(§[0-9]*)">
      <xsl:matching-substring>
        <xsl:variable select="regex-group(1)" name="paragraph" />
        <a href="{concat('https://www.zerocracy.com/policy.html#', substring-after($paragraph,'§'))}">
          <xsl:value-of select="$paragraph" />
        </a>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>
  <xsl:template name="stackoverflow">
    <xsl:param name="id"/>
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:value-of select="concat('https://stackoverflow.com/users/', $id)"/>
      </xsl:attribute>
      <xsl:value-of select="$id"/>
    </xsl:element>
  </xsl:template>
  <xsl:template name="telegram">
    <xsl:param name="id"/>
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:value-of select="concat('https://t.me/', $id)"/>
      </xsl:attribute>
      <xsl:value-of select="concat('@', $id)"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
