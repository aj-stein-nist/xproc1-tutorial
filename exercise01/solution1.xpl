<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    
    <!--
        Invoke like this:
    
        $ ../mvn-xmlcalabash.sh solution1.xpl
    
    -->
    <!-- For any XSLT processes we have to designate how to bind parameters, if any. -->
    <p:input port="parameters" kind="parameter"/>
    
<!-- Everything in this version is hard-coded to
        read and parse from the file system using p:document
        write back to the file system using p:store
        
     We are relying on runtime configurations to see to it that ...
       documents are resolved (relative to the XProc)
       artifacts produced or written go to the right place
    -->

    <p:xslt>
        <p:input port="source">
            <p:document href="books.xml"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="lib-wrapper.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:store href="book-lib.xml"/>

    <!-- Parsing and loading that same document a second time -->
    <p:xslt>
        <p:input port="source">
            <p:document href="books.xml"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="json-mapper.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:store href="books.json" method="text"/>
    
</p:declare-step>