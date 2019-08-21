# Rate Limits
The API applies rate limits based on the number of requests per a predefined interval (i.e. a time-window). We currently do not differentiate between authenticated and unauthenticated requests. The global rate limit takes into account the remote client IP only.

We plan on changing this policy in the future to one that limits on an account-by-account basis. For now, please be advised that those operating from corporate networks may hit their limit faster given that everyone may present the same IP address to our network.

Some endpoints have stricter rules as it relates to rate limits. These endpoints may additionally take into consideration the user's account or email address. For example, there can be 10 requests per 10 minute time period per IP to the `/password/forgot` endpoint; but multiple IPs can only make 3 requests per 5 minute time period per user account (e.g. `foo@bar.com`).

The following table indicates the current rate limits:

Endpoint                                  | Requests (per IP) / window | Requests (per user) / window
----------------------------------------- | -------------------------: | ---------------------------:
*Global*                                  |         500 / 5-min window |                          N/A
POST /cards/:card/transactions            |         300 / 5-min window |                          N/A
POST /cards/:card/transactions/:id/commit |         300 / 5-min window |                          N/A
POST /password/forgot                     |         10 / 10-min window |             3 / 5-min window
POST /users                               |         10 / 10-min window |                          N/A

<aside class="notice">
  <strong>Important Notice</strong>: When performing a considerable volume of transactions, please refer to the <a href="https://support.uphold.com/hc/en-us/articles/206118653-Transaction-Trading-Limits">Transaction and Trading Limits FAQ</a> to know more about Trading Power.
</aside>

## Response Headers
The current rate limit in effect is explained via custom HTTP headers as described in the table below. Additionally, the standard HTTP `Retry-After` header field will be appended when the rate limit is exhausted and indicates, in delta-seconds, how long until the rate limit window is reset.

Header               | Description
-------------------- | ----------------------------------------------------------------------------------------------------------------------
Rate-Limit-Total     | The total number of requests possible in the current window duration
Rate-Limit-Remaining | The number of requests remaining in the current window duration
Rate-Limit-Reset     | The time, in UTC [epoch seconds](http://en.wikipedia.org/wiki/Unix_time), until the end of the current window duration
Retry-After          | The time, in seconds, until the end of the current window duration

> Example request:

```bash
curl -I -X GET "https://api.uphold.com/v0/ticker"
```

> Rate limit details on response headers:

```
Rate-Limit-Total: 500
Rate-Limit-Remaining: 499
Rate-Limit-Reset: 1422288284
```

When the API limit is reached, a status code of [429 Too Many Requests](http://tools.ietf.org/html/rfc6585#section-4) is returned with the aforementioned `Retry-After` header:

> Example response for a rate limited request:

```
HTTP/1.1 429 Too Many Requests

Rate-Limit-Total: 300
Rate-Limit-Remaining: 0
Rate-Limit-Reset: 1422288284
Retry-After: 85
```

In this this example, the request could be retried in 1 minute and 25 seconds.

Alternatively, the `Rate-Limit-Reset` header could also be used to calculate when to retry the request:

> Parsing _Rate-Limit-Reset_:

```js
console.log(new Date(1422288199 * 1000));

// Mon Jan 26 2015 16:30:11 GMT+0000 (WET)
```

If you think you have a legitimate use-case for increased rate limits, please [contact us](/#support).
