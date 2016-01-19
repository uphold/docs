# Errors
Uphold API uses the following error codes:

Code | Meaning
---- | ---------------------------------------------------------------------------------------------------
400  | Bad Request -- Validation failed.
401  | Unauthorized -- Bad credentials.
403  | Forbidden -- Access forbidden.
404  | Not Found -- Object not found.
412  | Precondition Failed
416  | Requested Range Not Satisfiable
429  | Too Many Requests -- Rate limit exceeded.
500  | Internal Server Error -- Something went wrong in our server.
503  | Service Unavailable -- We're temporarily offline for maintenance. Please try again in a little bit.
