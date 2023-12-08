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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
  <xsl:include href="../assertions.xsl"/>
  <xsl:include href="../../xsl/templates.xsl"/>
  <xsl:template match="/">
    <xsl:call-template name="assert-that">
      <xsl:with-param name="message" select="'Fails to format user name'"/>
      <xsl:with-param name="expected">
        <span>
          <a href="https://www.0crat.com/u/yegor256" title="@yegor256">
            <xsl:text>@yegor256</xsl:text>
          </a>
        </span>
      </xsl:with-param>
      <xsl:with-param name="actual">
        <span>
          <xsl:call-template name="user">
            <xsl:with-param name="id" select="'yegor256'"/>
          </xsl:call-template>
        </span>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
