# An R parser for ArchieML

This package is a wrapper for [archieml-js](https://github.com/newsdev/archieml-js),
a parser for the New York Times' [ArchieML](http://archieml.org/) format.  ArchieML is designed
to include structured data in free-form documents.

Right now it just has one function, `from_archie`, which loads ArchieML data from a string, file, or URL.

archieml-js parses ArchieML to JSON.  It is run using V8, and then the JSON data is imported via jsonlite.

## Install

```
library(devtools)
install_github('noamross/rchie')
```

## Usage

```
data1 = from_archie("
	[arrayName]
	
	Jeremy spoke with her on Friday, follow-up scheduled for next week
	name: Amanda
	age: 26
	
	# Contact: 434-555-1234
	name: Tessa
	age: 30
	
	[]
	")
									
data2 = from_archie("
	{colors}
	red: #f00;
	green: #0f0;
	blue: #00f;
	
	{numbers}
	one: 1
	ten: 10
	one-hundred: 100
	{}

	key:")
	
str(data1)
data1
str(data)
data2
```

See http://archieml.org/ for more examples of ArchieML

