# Exercise 1

## Problem statement

I am new to the team and have very limited experience with OSCAL. Other team members have explained that I need to turn this XML file below into two separate files. The source file is below.

```xml
<books>
  <book>
    <author>John Smith</author>
    <title>A Brilliant Work</title>
  </book>
</books>
```

As developers we have specific requirements: we need to make a unique XSLT file to transform the source file above into a different version of XML like below.

```xml
<library id="1">
  <books>
    <book>
      <author>John Smith</author>
      <title>A Brilliant Work</title>
    </book>
  </books>
</library>
```

The other file must be transformed with a unique XSLT into JSON that looks like this:

```json
{
  "books":
    [
      { "author": "John Smith", "title": "A Brilliant Work" }
    ]
}     
```

So the other devs say I can use XProc 1.0 to operate the two transforms from the same source file and make the resulting files below. It will make them testable and repeatable. How do I do that?

## Solutions

Goal: Engineer and run an XProc 1.0 pipeline, processing a single XML file to produce two (2) results, an XML and a JSON.

Subordinate goals:

1. See some XSLT in action - transforming XML multiple ways

2. Learn about XProc
  - Why XProc 1.0?
  - What about XProc 3.0?
  - Alternatives to XProc
    - pure XSLT
    - others

3. Exposure to some necessary 'ceremony' and arcana relating to XML, XProc, XSLT and JSON

In the following exercise, we refer to the first XSLT transformation as 'blue' (inserting the XML into a `library`), while the second one is 'green' (converting the XML to some JSON).

### Process 'Blue': XSLT Producing XML

[blue.xsl](blue.xsl) will copy XML provided to it and wrap it in a new `library` element. None of the XML elements (in or out) are assigned to a namespace. It is XSLT 3.0 because of the nice support for a *modified identity transformation* such as this one.

See the XSLT for explanation of how it works.

Applying this XSLT to the input [blue.xsl](blue.xsl) should show results like those expected (shown above).

If not clear on how to test this, please ask!

A discussion on implementation strategy and choices in view of (possible) process requirements is also left aside.

### Process 'Green': XSLT producing JSON

An XSLT file is available as [green.xsl](green.xsl). It is XSLT 3.0, as needed to use the function to produce JSON syntax.

Like `blue.xsl`, the XSLT has explanatory comments, but please ask.

## Solution 1, phase 3: XProc 1.0 combining phases 1 and 2

## Solution 2: Using ports instead of hard-coded end points

## Solution 3: Combining the phases in sequence instead of in parallel

## Solution 4: A non-XProc Solution (XSLT 3.0)

## Solution 5: An all-XProc Solution

XSLT can be embedded in XProc, and 'blue' can be replaced with XProc steps other than `p:xslt`. So we can make standalone XProc.
