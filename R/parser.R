#' Parse ArchieML into a list
#'
#' @param input ArchieML input as a vector of lines
#' @param comments skip comments?
#'
#' @return a list of data
#' @export
#'
#' @examples
#' @noRd
parse_aml <- function(input, comments = FALSE) {

  whitespacePattern = '\u0009\u000A\u000B\u000C\u000D\u0020\u00A0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200A\u200B\u2028\u2029\u202F\u205F\u3000\uFEFF' # note null (\u0000) not included
  slugBlacklist = paste(whitespacePattern, '\u005B\u005C\u005D\u007B\u007D\u003')
  nextLine = '.*((\r|\n)+)'
  startKey = paste0('^\\s*([^', slugBlacklist, ']+)[ \t\r]*:[ \t\r]*(.*(?:\n|\r|$))')
  commandKey = '^\\s*:[ \t\r]*(endskip|ignore|skip|end).*?(\n|\r|$)' #note must ignore case
  arrayElement = '^\\s*\\*[ \t\r]*(.*(?:\n|\r|$))'
  scopePattern = paste0('^\\s*(\\[|\\{)[ \t\r]*([\\+\\.]*)[ \t\r]*([^', slugBlacklist, ']*)[ \t\r]*(?:\\]|\\}).*?(\n|\r|$)')

  data = list()
  scope = data

  stack = character(0)
  stackScope = NULL

  bufferScope = NULL
  bufferKey = NULL
  bufferString = ''

  isSkipping = FALSE

  for (line in input) {
    match <- character(1)

    if (grepl(commandKey, line, ignore.case = TRUE)) {
      match = regmatches(line, regexec(commandKey, line, ignore.case = TRUE))
      parseCommandKey(tolower(match[[1]][2]))
    }

  }


  return(data)
}

parseCommandKey <- function(command) {
  # if isSkipping, don't parse any command unless :endskip

  if (isSkipping && !(command == "endskip" || command == "ignore")) return(flushBuffer())

  switch(command,
         # When we get to an end key, save whatever was in the buffer to the last
         # active key.
         end = if (bufferKey) flushBufferInto(bufferKey, replace = FALSE);
         # When ":ignore" is reached, stop parsing immediately
         ignore = line <<- '',
         skip = {isSkipping <<- TRUE},
         endskip = {isSkipping <<- FALSE}
}

flushBuffer <- function() {
  result = paste0(bufferString + '')
  bufferString <<- ''
  bufferKey <<- NULL;
  return(result)
}

flushBufferInto <- function(key, replace = FALSE) {
  existingBufferKey = bufferKey
  value = flushBuffer()

  if (replace) {
    value = formatValue(value, 'replace').replace(new RegExp('^\\s*'), '');
    bufferString <<- (new RegExp('\\s*$')).exec(value)[0];
    bufferKey <<- existingBufferKey
  } else {
    value = formatValue(value, 'append');
  }

  if (typeof key === 'object') {
    // key is an array
    if (options.replace) key[key.length - 1] = '';

    key[key.length - 1] += value.replace(new RegExp('\\s*$'), '');

  } else {
    var keyBits = key.split('.');
    bufferScope = scope;

    for (var i=0; i<keyBits.length - 1; i++) {
      if (typeof bufferScope[keyBits[i]] === 'string') bufferScope[keyBits[i]] = {};
      bufferScope = bufferScope[keyBits[i]] = bufferScope[keyBits[i]] || {};
    }

    if (options.replace) bufferScope[keyBits[keyBits.length - 1]] = '';

    bufferScope[keyBits[keyBits.length - 1]] += value.replace(new RegExp('\\s*$'), '');
  }
}

flushBuffer();
return data;
}

#parse_aml(readLines("tests/testthat/arrays_complex.1.aml"))
