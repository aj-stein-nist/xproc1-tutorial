# xproc1-tutorial

This site offers tutorials in XProc 1.0, the W3C-standard XML pipelining technology.

It is also conceived as a learning platform for related and alternative technologies such as XSLT 3.1 (i.e., XSLT 3.0 with XPath 3.1) and XProc 3.0.

In all cases, attention will be paid not only to XProc 1.0 solutions, but also to potential alternatives including XProc 3.0.

## Pipelining

XProc is an *XML pipelining technology*. This is a generic name for any XML technology or application that relies on multiple phases of data processing, in which single or  multiple resources are marshalled, arranged and processed to produce single or multiple results (outputs). It is the *multiple* phases that make the difference here, although a pipeline with a single process is of course possible and normal. The ends of pipelines may *either* be related to the processing environment, as endpoints for reading or writing data, *or* they may be connected to other pipelines into larger pipelines that are similarly both *connectable* and *composable*.

Thus pipelines -- both conceptually, and in many implementations -- are made of pipelines -- just as build processes are made of build processes. This theoretical observation (which predates XML) is reflected in the design of the XML stack[^xmlstack] including XSLT as a functional, side-effect free language, designed specifically (among other requirements) to serve the needs of this kind of technology, both in itself and as a component of a larger system. Although XSLT can indeed arrange, orchestrate and implement pipeline-based logic internally, using XProc instead, managing the processing phases from a higher-level view, provides a number of distinct advantages:

- Relative transparency - easier to see how everything fits
- Easier debugging - processes are more easily isolated, with benefits in SOC including reusability
- Additional functionalities not supported by XSLT natively (or only with external libraries), such as XSD, RNG, Schematron or JSON Schema validation
- Standard interfaces for I/O - XProc is designed for multiplicative I/O and supports the range of file and format types better than unassisted XSLT - these standard interfaces help ease integration
- Scalability - as supported by its higher-level abstraction, XProc should provide XSLT with enhanced scalability both horizontally and vertically - working with both large and small datasets and addressing both complex and relatively simple processing requirements

[^xmlstack]: Broadly including XML, XSD, W3C DOM, XDM/XPath, XQuery, XSLT, and associated and ancillary public specifications (<q>standards</q>) supported by available tools.

## XProc Background

- [XProc 1.0 Specification at W3C](https://www.w3.org/TR/xproc/) (May 2010)
- How-to and starter guides for XProc 1.0
  - tutorial and reference at https://www.data2type.de/en/xml-xslt-xslfo/xproc
  - http://dh.obdurodon.org/xproc-tutorial.xhtml
  - https://ehennum.wordpress.com/2010/09/10/starting-xproc/
- [Requirements document for XProc beyond capabilities of XProc 1.0]( https://www.w3.org/XML/XProc/docs/langreq-v2.html) (2012)
- XProc.org links on [Learning XProc 3.0](https://xproc.org/learning.html)
- [XProc 3.0 and Related Specifications (links)](https://xproc.org/specifications.html)
- [XProc 3.0 Test suite](https://xproc.org/test-suite.html) includes many examples

## Non-XProc Pipelining Solutions

Pipelining as a generalized approach to data processing is much older than XProc, and there have been and are many ways of achieving pipelining on current systems, that are not dependent on XProc, offering different feature sets and (more importantly) being suited to different environments and use cases.

In the following, the term *step* is used in the XProc sense, as a discrete operation serviceable as a 'black box', to be combined with other steps in sequences reflecting logical dependencies.

- Reading and writing steps to the file system using scripts
- Reading and writing steps to the file system using `make` or other build utility
- Apache Ant (XML-based build utility for Java)
- Pipelining XML parse event streams e.g. Apache Cocoon (server-side XML processing framework)
- Building and processing document models e.g. DOM-based pipelining (XSLT 1.0)
- IDEs such as oXygen (transformation scenarios)
- Pure XSLT, either internally (via temporary trees) or using XPath 3.0 `transform()` function (Saxon)

Others? what have we not mentioned?


## XProc 3.0 Background

One significant limitation of XProc 1.0 stems from an early design decision that the language it would attempt only XML processing, and that other forms of processing (that did not presuppose XML or an XML data model) would be out of scope and unsupported, except as extensions.

This is an easy decision to understand and appreciate, and had many positives in that first generation. Unfortunately the proportion of XML-based processes that *never* have to work with formats other than XML (be they text-based or 'blobs'), is low: probably only a minority and possibly a small minority of XML applications are all-XML all the time. The constraint turned out to be too strict for use in the field.

XProc 3.0 also introduces many syntactic improvements making it easier to write and work with.

The [Requirements document for XProc beyond capabilities of XProc 1.0]( https://www.w3.org/XML/XProc/docs/langreq-v2.html) was published in 2012, only two years after the 1.0 technology was released as a Recommendation. XProc 3.0 exists for the same reasons as all 3.0 (or even 2.0) technologies exist - namely, in part, as a reflection of the limitations of XProc 1.0. Knowing these limitations is key to understanding both technologies. The requirements document offers a fair and comprehensive summary of the capabilities that were thought needed - significantly including those that XProc 1.0 did not offer.

## Xproc Implementations

Even apart from other approaches to pipelining, there have been many implementations of XProc and its predecessor technologies. We list only the ones we know of and use - please notify us if there is a *currently used and supported* processor that should be added to the list (even if only partially complete or conformant), or *if you know of any other such lists we should know about*.

### XProc 1.0

#### XML Calabash

### XProc 3.0

#### Morgana XProc


