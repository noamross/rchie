<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/ropensci/rchie.svg?branch=master)](https://travis-ci.org/ropensci/rchie) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropensci/rchie?branch=master&svg=true)](https://ci.appveyor.com/project/noamross/rchie) [![codecov.io](https://codecov.io/github/ropensci/rchie/coverage.svg?branch=master)](https://codecov.io/github/ropensci/rchie?branch=master)

An R parser for ArchieML
========================

This package is a wrapper for [archieml-js](https://github.com/newsdev/archieml-js), a parser for the New York Times' [ArchieML](http://archieml.org/) format. ArchieML is designed to include structured data in free-form documents.

Right now it just has one function, `from_archie`, which loads ArchieML data from a string, file, or URL.

archieml-js (included under `inst`, using `git subtree`) parses ArchieML to JSON. It is run using V8, and then the JSON data is imported via jsonlite.

Install
-------

Note that, because it uses the V8 package, rchie has a system requirement of libv8.

    library(devtools)
    install_github('ropensci/rchie')

Usage
-----

`from_archie` can read ArchieML from a string, file, or URL:

``` r
library(rchie)
data1 = "
  [arrayName]
  
  Jeremy spoke with her on Friday, follow-up scheduled for next week
  name: Amanda
  age: 26
  
  # Contact: 434-555-1234
  name: Tessa
  age: 30
  
  []
  "

from_archie(data1)          
#> $arrayName
#>     name age
#> 1 Amanda  26
#> 2  Tessa  30
from_archie('http://archieml.org/test/1.0/arrays.1.aml')
#> No encoding supplied: defaulting to UTF-8.
#> $test
#> [1] "[array] creates an empty array at array"
#> 
#> $result
#> [1] "{\"array\": []}"
#> 
#> $array
#> list()
```

Note that you can pass arguments through `from_archie` to `jsonlite::fromJSON` to determine how JSON is converted to R objects:

``` r
from_archie(data1, simplifyVector=FALSE)
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
```

See <http://archieml.org/> for more examples of ArchieML

[![ropensci\_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
