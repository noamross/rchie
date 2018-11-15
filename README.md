
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Build
Status](https://travis-ci.org/noamross/rchie.svg?branch=master)](https://travis-ci.org/noamross/rchie)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/noamross/rchie?branch=master&svg=true)](https://ci.appveyor.com/project/noamross/rchie)
[![codecov.io](https://codecov.io/github/noamross/rchie/coverage.svg?branch=master)](https://codecov.io/github/noamross/rchie?branch=master)

# An R parser for ArchieML

This package is a wrapper for
[archieml-js](https://github.com/newsdev/archieml-js), a parser for the
New York Times’ [ArchieML](http://archieml.org/) format. ArchieML is
designed to include structured data in free-form documents.

Right now it just has one function, `from_aml`, which loads ArchieML
data from a string, file, or URL.

archieml-js (included under `inst`, using `git subtree`) parses ArchieML
to JSON. It is run using V8, and then the JSON data is imported via
jsonlite.

## Install

Note that, because it uses the V8 package, rchie has a system
requirement of libv8.

    library(devtools)
    install_github('noamross/rchie')

## Usage

`from_aml` can read ArchieML from a string, file, or URL:

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
#> No encoding supplied: defaulting to UTF-8.
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

Note that you can pass arguments through `from_aml` to
`jsonlite::fromJSON` to determine how JSON is converted to R objects:

``` r
from_aml(data1, simplifyVector = FALSE)
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
```

See <http://archieml.org/> for more examples of ArchieML
