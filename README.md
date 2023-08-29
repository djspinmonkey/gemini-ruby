# Twinsies

This is a simple ruby implementation of a Gemini client and server, written mostly just for fun.

## Client

To begin with, the client will be only a simple `wget` style CLI script called `danny`. It accepts a single argument, which is the URL to be requested, and outputs the returned document on STDOUT. If a non-successful status is returned, it will output the status and associated META element (eg, the error message).

### Example

```
$ danny gemini://localhost/sample.gmni

This is a sample gemini document.

$ danny gemini://localhost/no_such_document.gmni

Status 51: Not Found
```

It will default to port 1965, and does not support textual user input or other fancier features. In the future, an interactive client may also be added to this repo.

## Server

The server is called `arnie`, and accepts a single argument, which is the path to the document root which the server should serve. It can optionally also accept a `-q` or `--quiet` argument to suppress output. If not in quiet mode, it will print a single log line to STDOUT for each incoming request. A log line will consist of the current time surrounded by square brackets, the URL requested, and the status code returned.

### Example

```
$ arnie /var/gemini_docs/
[2023-08-29 22:31:56.616191 UTC] /sample.gmni 20
[2023-08-29 22:31:57.123456 UTC] /no_such_document.gmni 51
```

## Library

There will additionally be a gemini library called `Twinsies`, which will contain most of the gemini-specific logic. This could be useful in the same way as an HTTP client library, to make gemini requests from other code bases.

### Example

```ruby
Twinsies.get "gemini://localhost/sample.gmni"            # returns "This is a sample gemini document."
Twinsies.get "gemini://localhost/no_such_document.gmni"  # returns "Status 51: Not Found"
Twinsies.get! "gemini://localhost/no_such_document.gmni" # raises a Twinsies::BadRequest exception
```
