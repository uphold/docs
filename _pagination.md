# Pagination

Collection endpoints with large datasets support [Range Pagination Headers](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html), using the `Range` and `Content-Range` entity-headers.

## Request

You can provide the `Range` header in your request to specify how many items you want to retrieve.
For most endpoints, the maximum number of items per page is 50, which is also the default value if you leave it unspecified.
Some endpoints allow larger pages — for example, the [list of assets](#currencies) supports up to 150 items per page.

> For example, here's how you'd fetch the five most recent transactions associated with the current user.
> Note that the items are indexed from zero:

```bash
curl https://api.uphold.com/v0/me/transactions \
  -H "Authorization: Bearer <token>" \
  -H "Range: items=0-4"
```

## Response

Successful paginated responses use the `206 Partial Content` HTTP status and include an `Accept-Ranges: items` header, indicating that ranges are expressed in number of items.

The endpoints that support pagination will also return a `Content-Range` header.
For instance, if you make a request with the `Range: items=0-4` header, the response will contain the header `Content-Range: items 0-4/<total>`, where `<total>` will be the total number of items available for listing.

If the `Range` header is malformed or if the range cannot be satisfied, you will receive a [412 HTTP error](#errors) or a [416 HTTP error](#errors), respectively.
