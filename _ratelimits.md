# Rate Limits

The API applies rate limits based on the number of requests per a predefined interval (i.e. a time-window).
We currently do not differentiate between authenticated and unauthenticated requests.
The global rate limit takes into account the remote client IP only.

We plan on changing this policy in the future to one that limits on an account-by-account basis.
For now, please be advised that those operating from corporate networks may hit their limit faster,
given that everyone may present the same IP address to our network.

Some endpoints have stricter rules as it relates to rate limits.
These endpoints may additionally take into consideration the user's account or email address.
For example, there can be 5 requests per 60 minute time period per IP to the `/password/forgot` endpoint;
but multiple IPs can only make 5 requests per 60 minute time period per user account (e.g. `foo@bar.com`).

The following table indicates the current rate limits:

Endpoint                                                | Requests (per IP) / window | Requests (per user) / window
------------------------------------------------------- | -------------------------: | ---------------------------:
*Global*                                                |         500 / 5-min window |                          N/A
POST /me/authentication_methods/:id/request_challenge   |                        N/A |            1 / 45-sec window
POST /me/cards/:card/transactions *(email destination)* |                        N/A |            5 / 60-min window
POST /me/confirm                                        |         10 / 10-min window |                          N/A
POST /me/reports/:type                                  |         10 / 10-min window |           10 / 10-min window
POST /oauth2/token                                      |          50 / 5-min window |            50 / 5-min window
POST /password/change                                   |          5 / 60-min window |            5 / 60-min window
POST /password/forgot                                   |          5 / 60-min window |            5 / 60-min window

For unauthenticated endpoints such as `POST /oauth2/token` and `POST /password/forgot`, the per-user dimension is keyed on the username or email address provided in the request.

<aside class="notice">
  <strong>Important Notice</strong>: When performing a considerable volume of transactions, please refer to the <a href="https://support.uphold.com/hc/en-us/articles/360038404532">Transaction and Trading Limits FAQ</a> to know more about Trading Power.
</aside>

## Response Headers

The standard HTTP `Retry-After` header field will be appended when the rate limit is exhausted,
and indicates, in delta-seconds, how long until the rate limit window is reset.

> Example request:

```bash
curl -I -X GET "https://api.uphold.com/v0/ticker"
```

When the API limit is reached, a [429 HTTP error](#errors) is returned with the aforementioned `Retry-After` header:

> Example response for a rate limited request:

```
HTTP/1.1 429 Too Many Requests
Retry-After: 85
```

In this example, the request could be retried in 1 minute and 25 seconds.

The response body carries the error code `too_many_requests`.

If you think you have a legitimate use-case for increased rate limits, please [contact us](/#support).
