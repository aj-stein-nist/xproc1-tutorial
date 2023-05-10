<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    
    <p:input port="parameters" kind="parameter"/>
    
    <p:xslt>
        <p:input port="source">
            <p:document href="books.xml"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="lib-wrapper.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:store href="book-lib.xml"/>
    
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