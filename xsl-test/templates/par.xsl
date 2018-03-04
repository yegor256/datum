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
  <xsl:include href="../assertions.xsl"/>
  <xsl:include href="../../xsl/templates.xsl"/>
  <xsl:template match="/">
    <xsl:call-template name="assert-that">
      <!--
      @todo #314:30min This test is ignored because template PAR is not
      implemented properly. Let's implement it using recursion and enable
      this test by removing the line after this puzzle.
      -->
      <xsl:with-param name="ignore" select="'true'"/>
      <xsl:with-param name="message" select="'Fails to format project name'"/>
      <xsl:with-param name="expected">
        <span>
          <xsl:text>See </xsl:text>
          <a href="http://www.zerocracy.com/policy.html#13">
            <xsl:text>§13</xsl:text>
          </a>
          <xsl:text> and </xsl:text>
          <a href="http://www.zerocracy.com/policy.html#2">
            <xsl:text>§2</xsl:text>
          </a>
          <xsl:text>.</xsl:text>
        </span>
      </xsl:with-param>
      <xsl:with-param name="actual">
        <span>
          <xsl:call-template name="par">
            <xsl:with-param name="text" select="'See §13 and §2.'"/>
          </xsl:call-template>
        </span>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
