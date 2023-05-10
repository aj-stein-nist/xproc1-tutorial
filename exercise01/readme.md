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

### Components

#### `lib-wrapper` XSLT Producing XML

[lib-wrapper.xsl](lib-wrapper.xsl) will copy XML provided to it and wrap it in a new `library` element. None of the XML elements (in or out) are assigned to a namespace. It is XSLT 3.0 because of the nice support for a *modified identity transformation* such as this one.

See the XSLT for explanation of how it works.

Applying this XSLT to the input [lib-wrapper.xsl](lib-wrapper.xsl) should show results like those expected (shown above).

If not clear on how to test this, please ask!

A discussion on implementation strategy and choices in view of (possible) process requirements is also left aside.

#### `json-mapper` XSLT producing JSON

An XSLT file is available as [json-mapper.xsl](json-mapper.xsl). It is XSLT 3.0, as needed to use the function to produce JSON syntax.

It works following a pattern you will see any time XProc/XSLT are put to work with other formats, namely isolating the *mapping* and the *serialization* ("writing") of the target format into separate processes. The target format will be represented by an XML transposition, reducing the mapping to a cast from one XML to another. Then the "JSON XML" (in this case) can be serialized into JSON using a commodity utility or reusable step. (XSLT is good for writing serializers for arcane formats.) A Markdown cast also works this way. Here the mapping is accomplished by XSLT templates that produce an XML object to be serialized using the standard `xml-to-json` function.

This same pattern can be implemented in XSLT, in XProc using XSLT for its steps (subpipelines), and in XProc without XSLT.

Like `lib-wrapper.xsl`, the XSLT has explanatory comments, but please ask.

As a bonus, it also includes an XSLT try/catch to defend against unmarked dead-ends resulting in opaque or silent failures.

### Solution 1: XProc 1.0 combining phases 1 and 2

See how [solution1.xpl](solution1.xpl) combines the transformations  'lib-wrapper' and 'json-mapper' into one runtime, using `p:document` to read XML and `p:store` to save results. This basically a glorified batch processor.

In [solution1a.xpl](solution1a.xpl) the same approach is taken, except that the source is read only once, not once for each process.

### Solution 2: Using ports instead of hard-coded end points

We could parameterize file names for `solution1` but XProc offers a much better approach, namely its input and output *ports*, as shown in [solution2.xpl](solution2.xpl).

Invoke the bash script like this:

> $ ../mvn-xmlcalabash.sh solution2.xpl -olibrary=newlibrary.xml -ojsonized=newjson.json -ibooks=books2.xml

This XProc has ports designated `books` (an XML file listing the books) input, and for output, two ports, `library` for the XML, and `jsonized` for the JSON version.

These are declared at the top of the XProc using `p:input` and `p:output`. Note how there needs to be a bit of finessing to convince XProc to emit raw JSON results. (Keeping serialization settings next to the output port to which they apply is a design decision.) Also, whitespace and formatting in the outputs may not yet be ideal -- another topic (there being ways to ameliorate this).

### Solution 3: Combining the phases in sequence instead of in parallel

This is neater and arguably more efficient. It takes advantage of the fact that the first process doesn't actually modify anything, so the second process might as well accept its results as inputs.

Of course whether this is actually better or worse depends on the situation. Given how XProc can define ports for any intermediate results as well as final results, executing a simple pipeline in sequence, while capturing any or all results along the way, is a natural design.

Note also: the fact that this works with the `json-mapper.xsl` as given is *incidental* and a feature of its design. A different `json-mapper.xsl` might not work the same way and might give bad or broken outputs when presented with different inputs.

### Solution 4: A non-XProc approach

XSLT 3.0 has everything we need to do this without XProc.

This Solution is left as an exercise for the reader.

<details><summary>Hints</summary>

At least two different ways to do this:

- Integrate logic with modes and pipeline processes internally - so a single/discrete XSLT transformation includes **reduce** along with **filter** and **map** operations
- Use XPath 3.0 `transform()` to invoke and apply external XSLTs as discrete function calls

The tradeoffs between these approaches are similar to the XProc tradeoffs.

Method 1 basically amounts to treating XSLT as a general-purpose functional language (which it can be), and solving the problem there. Method 2 amounts to reverse engineering XProc or the functional equivalent (subset) in XSLT and using that. To a large degree the tradeoffs here have to do with transparency as well as both process and resource (especially XSLT resource) maintenance and reuse. XSLT for these applications can be both elegant and performant -- but as it grows in complexity eventually it turn into its own variant XProc-alike 4GL, so why not just implement XProc? etc.

</details>

### Solution 5: An all-XProc approach

XSLT can be embedded in XProc, and 'blue' can be replaced with XProc steps other than `p:xslt`. So we can make standalone XProc with no external XSLTs or other dependencies.

Additionally to providing some interesting and useful syntax, the XSLT in this  example differs in a couple of important respects from [json-mapper.xsl](json-mapper.xsl) - it has been "hardened" so as not to be as tolerant of 'garbage' (or more generally, unexpected and unspecified) inputs. Compare and test by probing and running the code.

### Solution 6: XProc 3.0

XProc 3.0 offers more compact syntax.

Embedded XSLT works well in this scenario.

Also it would be interesting to see multiple XProcs (for reuse), as for example the JSON conversion could make a discrete step.
