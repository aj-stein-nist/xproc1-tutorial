<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    
    <!--
        Invoke like this:
    
        $ ../mvn-xmlcalabash.sh solution1a.xpl
    
    -->
    <!-- For any XSLT processes we have to designate how to bind parameters, if any. -->
    <p:input port="parameters" kind="parameter"/>
    
    <!-- This is the same as solution1.xsl except it loads the source only once,
         not once again for every XSLT. -->
    
    <!-- p:load is simply a call to read and parse an XML document into the pipeline.   -->
    <p:load name="books-in" href="books.xml"/>

    <p:xslt>
        <p:input port="stylesheet">
            <p:document href="lib-wrapper.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:store href="book-lib.xml"/>

    <!-- Instead of parsing again we can go back to the 'books-in' step. -->
    <p:xslt>
        <p:input port="source">
            <p:pipe port="result" step="books-in"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="json-mapper.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:store href="books.json" method="text"/>
    
</p:declare-step>