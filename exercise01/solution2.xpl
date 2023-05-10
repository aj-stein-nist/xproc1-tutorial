<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    
    <!--
        
    Invoke like this (designating books2.xml as the source):
    
    $ ../mvn-xmlcalabash.sh solution2.xpl -olibrary=newlibrary.xml -ojsonized=newjson.json -ibooks=books2.xml
    
    Or when using another tool, provide 'books' input and 'library' and 'jsonized' output bindings 
    
    -->
    <!-- For any XSLT processes we have to designate how to bind parameters, if any. -->
    <p:input port="parameters" kind="parameter"/>
    
    <p:input port="books">
        <!-- call to p:document here provides a default, but a binding to an exposed port can be overridden -->
        <p:document href="books.xml"/>
    </p:input>
    
    <p:output port="library">
        <p:pipe port="result" step="make-library"/>
    </p:output>
    
    <!-- We need to set this output port to write plain text unless told otherwise -
         this is a JSON literal in a simple XML wrapper. -->
    <p:serialization port="jsonized" method="text"/>
    <p:output port="jsonized">
        <p:pipe port="result" step="json-convert"/>
    </p:output>
    
    <!-- Ports are set up, main pipeline starts here   -->
    
    <!-- A spare p:identity gives us an easy way to point back to the primary input. -->
    <p:identity name="source-books"/>
    
    <!-- We give a step a name so we can reference it.  -->
    <p:xslt name="make-library">
        <p:input port="stylesheet">
            <p:document href="lib-wrapper.xsl"/>
        </p:input>
    </p:xslt>
    
    <!-- Since the results are now bound to a port we don't have to write them. -->
    <!-- <p:store href="book-lib.xml"/> -->
    
    <!-- Instead, we p:sink, since the step after does not pick up here but from earlier. -->
    <p:sink/>

    <p:xslt name="json-convert">
        <p:input port="source">
            <p:pipe port="result" step="source-books"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="json-mapper.xsl"/>
        </p:input>
    </p:xslt>
    
    <!-- Again, with results being bound to the 'jsonized' output port, we don't need to write anything here. -->
    <!-- <p:store href="books.json" method="text"/> -->
    
    
</p:declare-step>