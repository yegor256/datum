<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2016-2023 Zerocracy

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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/1999/xhtml" version="2.0" exclude-result-prefixes="xs">
  <xsl:template name="assert-that">
    <xsl:param name="ignore" select="'false'"/>
    <xsl:param name="message"/>
    <xsl:param name="expected"/>
    <xsl:param name="actual"/>
    <xsl:if test="$ignore = 'false'">
      <xsl:if test="not(deep-equal($expected, $actual))">
        <xsl:message terminate="yes">
          <xsl:text>FAILURE: </xsl:text>
          <xsl:value-of select="$message"/>
          <xsl:text> (actual "</xsl:text>
          <xsl:copy-of select="$actual"/>
          <xsl:text>" is not equal to expected "</xsl:text>
          <xsl:copy-of select="$expected"/>
          <xsl:text>")</xsl:text>
        </xsl:message>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
