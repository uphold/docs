# Errors

Uphold API uses the following error codes:

Code | Meaning
---- | --------------------------------------------------------------------------
400  | [Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)
401  | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)
403  | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)
404  | [Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)
409  | [Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)
410  | [Gone](https://tools.ietf.org/html/rfc7231#section-6.5.9)
412  | [Precondition Failed](https://tools.ietf.org/html/rfc7232#section-4.2)
416  | [Range Not Satisfiable](https://tools.ietf.org/html/rfc7233#section-4.4)
422  | [Unprocessable Entity](https://tools.ietf.org/html/rfc4918#section-11.2)
423  | [Locked](https://tools.ietf.org/html/rfc4918#section-11.3)
429  | [Too Many Requests](http://tools.ietf.org/html/rfc6585#section-4)
500  | [Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)
503  | [Service Unavailable](https://tools.ietf.org/html/rfc7231#section-6.6.4)

Errors are returned with a JSON body describing the problem.
For HTTP errors, the body contains a `code` with the snake-cased status name, along with a human-readable `message`.

> Example of an HTTP error response body:

```json
{
  "code": "not_found",
  "message": "Not Found"
}
```

Validation errors return the `validation_failed` code and an `errors` object keyed by field, where each field holds a list of errors, each with its own `code` and `message`.
For nested body fields, a field's value may instead be another `validation_failed` object with its own `errors`, mirroring the structure of the request body.

> Example of a validation error response body:

```json
{
  "code": "validation_failed",
  "errors": {
    "email": [
      {
        "code": "not_blank",
        "message": "This value should not be blank"
      }
    ]
  }
}
```
