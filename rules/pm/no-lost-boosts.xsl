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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="xml"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="/">
    <errors>
      <xsl:apply-templates select="document('boosts.xml')/boosts/boost"/>
    </errors>
  </xsl:template>
  <xsl:template match="boost">
    <xsl:variable name="job" select="@id"/>
    <xsl:if test="not(document('wbs.xml')/wbs/job[@id=$job])">
      <error>
        <xsl:text>The boost for job "</xsl:text>
        <xsl:value-of select="$job"/>
        <xsl:text>" exists in boosts.xml, but the job is absent in the WBS among </xsl:text>
        <xsl:value-of select="count(document('wbs.xml')/wbs/job)"/>
        <xsl:text> jobs.</xsl:text>
      </error>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
