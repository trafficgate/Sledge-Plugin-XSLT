<?xml version="1.0" encoding="euc-jp" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
<xsl:for-each select="frameworks/software">
<xsl:value-of select="name"/>,<xsl:value-of select="version"/>,<xsl:value-of select="url"/>
<br/>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>