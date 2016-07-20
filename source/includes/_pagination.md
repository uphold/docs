# Pagination
Collection endpoints with large dataset supports [Range Pagination Headers](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html) using `Range` & `Content-Range` entity-headers.

## Request
You can provide the `Range` header specifying how many items you want to retrieve.

> Here is an example:

```bash
curl https://api.uphold.com/v0/me/transactions \
  -H "Authorization: Bearer <token>" \
  -H "Range: items=0-4"
```

> The above command will return the user's last five transactions.

## Response
The endpoints that support pagination returns a `Content-Range` header. For instance, if you make a request with `Range: items=0-4` header the response will contain the following header: `Content-Range: 0-4/*` where `*` will be the total number of items that this endpoint can return.

If the `Range` header is malformed or if the range cannot be satisfied you will receive a 412 error or a 416 error, respectively.
