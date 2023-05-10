<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="3.0">
    <!-- No namespace declaration is given for unprefixed elements
         as the required output, like the input, is not in a namespace.  -->
    
    <!-- Cosmetic setting to format results when not overridden by the caller. -->
    <xsl:output indent="yes"/>
    
    <!-- One-liner in XSLT 3.0 provides for copying (not just visiting) in default traversal.  -->
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="/*">
        <!-- 'library' is expressed as a Literal Result Element (LRE) -->
        <library id="1">
            <!-- Next comes this handy instruction for match the same node again
                 - in this case, to copy through. -->
            <xsl:next-match/>
        </library>
    </xsl:template>
    
</xsl:stylesheet>