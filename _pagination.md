# Pagination

Collection endpoints with large dataset supports [Range Pagination Headers](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html), using the `Range` and `Content-Range` entity-headers.

## Request

You can provide the `Range` header in your request to specify how many items you want to retrieve.
The maximum number of items per page is 50. That is also the default value if you leave it unspecified.

> For example, here's how you'd fetch the five most recent transactions associated with the current user.
> Note that the items are indexed from zero:

```bash
curl https://api.uphold.com/v0/me/transactions \
  -H "Authorization: Bearer <token>" \
  -H "Range: items=0-4"
```

## Response

The endpoints that support pagination will return a `Content-Range` header.
For instance, if you make a request with the `Range: items=0-4` header, the response will contain the header `Content-Range: 0-4/*`, where `*` will be the total number of items available for listing.

If the `Range` header is malformed or if the range cannot be satisfied, you will receive a 412 error or a 416 error, respectively.
