<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    
    <!--
        
    Invoke like this (designating books2.xml as the source):
    
    $ ../mvn-xmlcalabash.sh solution2.xpl -olibrary=newlibrary.xml -ojsonized=newjson.json -ibooks=books2.xml
    
    Or when using another tool, provide 'books' input and 'library' and 'jsonized' output bindings 
    
    -->
    
    <!-- For any XSLT processes we have to designate how to bind parameters, if any. -->
    <p:input port="parameters" kind="parameter"/>
    
    <p:input port="books">
        <p:document href="books.xml"/>
    </p:input>
    
    <p:output port="library">
        <p:pipe port="result" step="tagged-library"/>
    </p:output>
    
    <p:serialization port="jsonized" method="text"/>
    <p:output port="jsonized">
        <p:pipe port="result" step="json-convert"/>
    </p:output>
    
    <!-- +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+  +#+ -->
    <!-- Ports are set up, main pipeline starts here   -->
    
    <!-- A spare p:identity gives us an easy way to point back to the primary input. -->
    <p:identity name="source-books"/>
    
    <!-- We give a step a name so we can reference it.  -->
    <!--<p:xslt name="make-library">
        <p:input port="stylesheet">
            <p:document href="lib-wrapper.xsl"/>
        </p:input>
    </p:xslt>-->
    
<!-- The XProc 'wrap' step can do some ad-hoc matching and wrapping - as it happens,
     here is to the effect we want. The p:wrap-sequence step, which instead of matching
     simply wraps a sequence of documents into one, is another possibility here.-->
    
<!-- A subtle but important difference between '/books' and 'books' here   -->
    <p:wrap name="make-library" match="/books" wrapper="library"/>
    
    <p:add-attribute match="library" attribute-name="id" attribute-value="1"/>
    
    <p:identity name="tagged-library"/>
    
    <p:xslt name="json-convert">
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet version="3.0" xmlns="http://www.w3.org/2005/xpath-functions">
                    <!-- Within this context, unprefixed elements will be assigned to the 'xpath-functions' namespace
                         required by xml-to-json() function. -->

                    <xsl:variable name="indenting" select="map {'indent': true()}"/>

                    <xsl:template match="*">
                        <null key="{ local-name() }"/>
                    </xsl:template>
                    
                    <xsl:template match="/">
                        <xsl:variable name="json-xml">
                            <map>
                                <xsl:apply-templates/>
                            </map>
                        </xsl:variable>
                        <json xmlns:err="http://www.w3.org/2005/xqt-errors">
                            <xsl:try>
                                <xsl:sequence select="xml-to-json($json-xml, $indenting)"/>
                                <xsl:catch expand-text="true">
                                    <err:message>FAILURE WRITING JSON SYNTAX {$err:code}: {
                                        $err:description }</err:message>
                                    <err:message>{ serialize($json-xml, $indenting) }</err:message>
                                </xsl:catch>
                            </xsl:try>
                        </json>
                    </xsl:template>

                    <xsl:template match="/library">
                        <xsl:apply-templates/>
                    </xsl:template>
                    
                    <xsl:template match="books">
                        <array key="books">
                            <xsl:apply-templates/>
                        </array>
                    </xsl:template>

                    <xsl:template match="book">
                        <map>
                            <xsl:apply-templates/>
                        </map>
                    </xsl:template>

                    <xsl:template match="author | title">
                        <string key="{ local-name() }">
                            <xsl:apply-templates/>
                        </string>
                    </xsl:template>

                </xsl:stylesheet>
            </p:inline>
        </p:input>
    </p:xslt>
    
</p:declare-step>