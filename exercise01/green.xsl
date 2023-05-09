<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/2005/xpath-functions" version="3.0">

    <!-- Unprefixed elements will be assigned to the 'xpath-functions' namespace required by xml-to-json() function. -->
    
    <!-- An output method is sometimes designated by the calling application, in which case this one is ignored. -->
    <!-- To convert all the way to JSON syntax, use method="text"; when debugging, to see its XML form, use method="xml" -->
    <xsl:output method="text"/>

    <!-- Setting a variable for serialization parameters. -->
    <xsl:variable name="indenting" select="map {'indent': true()}"/>
    
    <!-- This template matches the root node, binds the results of processing the document tree
         to a variable, $me, and then processes this by calling a function, xml-to-json($me)
         to produce a (JSON) serialized result. -->
    <xsl:template match="/">
        <xsl:variable name="me">
            <!-- Single element ensures results are all in one. -->
            <map>
                <xsl:apply-templates/>
            </map>
        </xsl:variable>
        <!-- xsl:try helps with debugging - the fail safe is to write the outputs as XML, allowing inspection. -->
        <!-- See https://www.w3.org/TR/xslt-30/#element-try -->
        <xsl:try>
            <xsl:sequence select="xml-to-json($me, $indenting)"/>
            <xsl:catch expand-text="true" xmlns:err="http://www.w3.org/2005/xqt-errors">
                <xsl:message>FAILURE WRITING JSON SYNTAX {$err:code}: {$err:description
                    } reported at line {$err:line-number}, col {$err:column-number}</xsl:message>
                <xsl:message>{ serialize($me, $indenting) }</xsl:message>
            </xsl:catch>
        </xsl:try>
    </xsl:template>

    <xsl:template match="books">
        <array key="books">
            <xsl:apply-templates/>
        </array>
    </xsl:template>

    <xsl:template match="book">
        <!-- Note: no @key comes on the map since it will be an array member. -->
        <!-- An assumption is being made that the structure of the source data is stable enough to warrant this. -->
        <map>
            <xsl:apply-templates/>
        </map>
    </xsl:template>

    <!-- The template matching *both* author *and* title (so, either) -->
    <!-- "author | title" is short for "child::author union child::title"-->
    <xsl:template match="author | title">
        <!-- Curly braces in attributes in LREs are Attribute Value Templates (AVTs). -->
        <string key="{ local-name() }">
            <xsl:apply-templates/>
        </string>
    </xsl:template>

</xsl:stylesheet>