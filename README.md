# An R parser for ArchieML

This package is a wrapper for [archieml-js](https://github.com/newsdev/archieml-js),
a parser for the New York Times' [ArchieML](http://archieml.org/) format.

Right now it just has one function, `from_archie`, which loads ArchieML data from a string, file, or URL.

archieml-js parses ArchieML to JSON.  It is run using V8, and then the JSON data is imported via jsonlite.

## Install

```
library(devtools)
install_github('noamross/rchie')
```

## Usage

from_archie(
