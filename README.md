
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rchie: An R parser for ArchieML

<img align="right" width="180"  src="https://raw.githubusercontent.com/noamross/rchie/master/inst/archieml-tri-grey.png">

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
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
New York Times’ [ArchieML](http://archieml.org/) format. ArchieML is
designed for non-coders writing documents that need to include some
structured data.

## Install

Note that, because it uses the V8 package, rchie has a system
requirement of `libv8`. See the [V8
README](https://github.com/jeroen/V8#v8) for installation instructions.

    library(devtools)
    install_github('noamross/rchie')

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

See <http://archieml.org/> for more examples and use cases of ArchieML.

Please note that **rchie** is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree
to abide by its terms.
