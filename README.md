
<!-- README.md is generated from README.Rmd. Please edit that file -->

⛔️ ARCHIVED - No longer supported or maintained ⛔️

# rchie: An R parser for ArchieML <img src="man/figures/logo.png" align="right" />

[![Project Status: Unsupported – The project has reached a stable, usable state but the author(s) have ceased all work on it. A new maintainer may be desired.](https://www.repostatus.org/badges/latest/unsupported.svg)](https://www.repostatus.org/#unsupported)
[![CRAN
version](http://www.r-pkg.org/badges/version/rchie)](https://cran.r-project.org/package=rchie)
[![Build
Status](https://travis-ci.org/noamross/rchie.svg?branch=master)](https://travis-ci.org/noamross/rchie)
[![Build
status](https://ci.appveyor.com/api/projects/status/osig88jvixel2taa/branch/master?svg=true)](https://ci.appveyor.com/project/NoamRoss/rchie/branch/master)
[![codecov.io](https://codecov.io/github/noamross/rchie/coverage.svg?branch=master)](https://codecov.io/github/noamross/rchie?branch=master)

*“Structured text, for an unstructured world.”*

This package is a wrapper for
[archieml-js](https://github.com/newsdev/archieml-js), a parser for the
New York Times’ ArchieML markup format. ArchieML is designed for
non-coders writing documents that need to include some structured data,
especially writers producing structured text that will be rendered on
website or interactive graphics. Learn more about ArchieML’s syntax and
use cases at <http://archieml.org/>, and see examples of its use
[here](https://awards.journalists.org/entries/archieml/).

## Installation

Install **rchie** from CRAN with:

    install.packages("rchie")

Install the development version of **rchie** from GitHub using
**remotes**, **devtools**, or my zero-dependency preference:

    source("https://install-github.me/noamross/rchie")

Note that, because **rchie** uses the V8 package, it has a system
requirement of `libv8`. See the [V8
README](https://github.com/jeroen/V8#v8) for instructions.

## Usage

`from_aml` can read ArchieML from a string, file, URL, or connection. It
returns an R list:

``` r
library(rchie)
data1 <- "
  [arrayName]
  
  Jeremy spoke with her on Friday, follow-up scheduled for next week
  name: Amanda
  age: 26
  
  # Contact: 434-555-1234
  name: Tessa
  age: 30
  
  []
  "
from_aml(data1)
#> $arrayName
#> $arrayName[[1]]
#> $arrayName[[1]]$name
#> [1] "Amanda"
#> 
#> $arrayName[[1]]$age
#> [1] "26"
#> 
#> 
#> $arrayName[[2]]
#> $arrayName[[2]]$name
#> [1] "Tessa"
#> 
#> $arrayName[[2]]$age
#> [1] "30"
#> 
#> 
#> 
#> attr(,"class")
#> [1] "list"     "from_aml"
from_aml("http://archieml.org/test/1.0/arrays.1.aml")
#> $test
#> [1] "[array] creates an empty array at array"
#> 
#> $result
#> [1] "{\"array\": []}"
#> 
#> $array
#> list()
#> 
#> attr(,"class")
#> [1] "list"     "from_aml"
```

If you want the raw JSON produced by the `archieml-js` parser, use
`aml_to_json()`.

``` r
aml_to_json(data1, pretty = TRUE)
#> {
#>     "arrayName": [
#>         {
#>             "name": "Amanda",
#>             "age": "26"
#>         },
#>         {
#>             "name": "Tessa",
#>             "age": "30"
#>         }
#>     ]
#> }
#> 
```

### Using Google Docs

Since a common use-case for ArchieML is reading semi-structured text
written in Google Docs, **rchie** includes optional methods to read
items from Google Drive. To use them, you must have the
[**googledrive**](https://googledrive.tidyverse.org/) package installed
and pass a `drive_id` object to `from_aml()`. Here we pull data from
[this Google
Doc](https://drive.google.com/open?id=1oYHXxvzscBBSBhd6xg5ckUEZo3tLytk9zY0VV_Y7SGs):

``` r
library(googledrive)
gdata <- from_aml(as_id("1pXCkhOsFtLUD8Gr6PIkWlEM1NYXXOW5V"))
head(gdata)
#> $key
#> [1] "value"
#> 
#> $`google-link`
#> [1] "This is a link."
#> 
#> $`google-link-standalone`
#> [1] "http://www.nytimes.com/2016/04/03/us/politics/donald-trump-general-election.html?q=1#1"
#> 
#> $`google-link-standalone-raw`
#> [1] "http://www.nytimes.com/2016/04/03/us/politics/donald-trump-general-election.html?q=1#1"
#> 
#> $`smart-quotes`
#> [1] "<a href=“http://www.nytimes.com”>nytimes.com</a>"
#> 
#> $array
#> $array[[1]]
#> [1] "1"
#> 
#> $array[[2]]
#> [1] "2"
```

If you are using Google Docs to input ArchieML regularly, the [ArchieML
Google Docs
plugin](https://chrome.google.com/webstore/detail/archieml/jelifjgbakgjapbobohocpbpdoiljokp)
is quite helpful for previewing parsed data as you type.

## Contributing

I’d love you to contribute to **rchie**\! I’d especially like some
examples of use-cases - R Markdown documents, Shiny Apps, etc. - that I
can feature in the documentation. Please take a look the the
[contributing guidelines](CONTRIBUTING.md).

Note that **rchie** is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree
to abide by its terms.
