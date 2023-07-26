# Accounts

Uphold allows users to deposit value into a specific card from an external source (ACH account, debit/credit card or wire transfer) or withdraw to an external source (ACH account or wire transfer).

Whenever a deposit is made into an Uphold card, it will be automatically converted into the value determined by the card's denomination.
Likewise, when a withdrawal is made, the currency will be converted to the currency of the destination account, thus minimizing fees and currency conversions.

We support the following account types:

Account type | Deposits supported? | Withdrawals supported?
------------ | ------------------- | ----------------------
ach          | Yes                 | Yes
card         | Yes                 | No
sepa         | Yes                 | Yes

Please refer to our FAQ for estimated [ACH transaction times](https://support.uphold.com/hc/en-us/articles/206762103-How-to-add-and-withdraw-funds-via-bank-transfer-U-S-), [SEPA transaction times](https://support.uphold.com/hc/en-us/articles/205803186-How-to-add-and-withdraw-funds-via-bank-transfer-Europe-), [fees and limits](https://support.uphold.com/hc/en-us/articles/206118653-Transaction-Trading-Limits).

## List Accounts

> The basic request to this endpoint lists all accounts for the current user:

```bash
curl https://api.uphold.com/v0/me/accounts \
  -H "Authorization: Bearer <token>"
```

> Example of filtering the list to show only accounts of the `sepa` or `card` types, and in the `ok` status:

```bash
curl 'https://api.uphold.com/v0/me/accounts?q=type:sepa,card%20status:ok'
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "billing": {},
  "currency": "EUR",
  "id": "18843b6d-5a43-480f-8e2b-73b27d726bf0",
  "label": "Checking Account",
  "status": "ok",
  "type": "sepa"
},
{
  "billing": {
    "name": "Makenna Ortiz"
  },
  "brand": "visa",
  "currency": "USD",
  "id": "0874745c-f0bf-4973-a3d9-9832aeaae087",
  "label": "Savings Account",
  "status": "ok",
  "type": "card"
}]
```

Retrieves a list of accounts for the current user.

### Request

`GET https://api.uphold.com/v0/me/accounts`

<aside class="notice">
  Requires the <code>accounts:read</code> scope for Uphold Connect applications.
</aside>

You can filter the list of returned accounts using query string parameters.
Supported filters are `status:` and `type:`, with either a single value or a comma-separated list.
For a list of valid values for these parameters, refer to the [Account Object](#account-object) documentation.
Multiple filters can be used together, separated with a space.
See the code to the right for an example.

### Response

Returns an array of the current user's accounts.

## Get Account Details

```bash
curl https://api.uphold.com/v0/me/accounts/18843b6d-5a43-480f-8e2b-73b27d726bf0 \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "billing": {},
  "currency": "EUR",
  "id": "18843b6d-5a43-480f-8e2b-73b27d726bf0",
  "label": "Checking Account",
  "status": "ok",
  "type": "sepa"
}
```

Retrieves the details about a specific account.

### Request

`GET https://api.uphold.com/v0/me/accounts/:id`

<aside class="notice">
  Requires the <code>accounts:read</code> scope for Uphold Connect applications.
</aside>
<aside class="notice">
  The account id must be owned by the user performing the API call.
</aside>

### Response

Returns a fully formed [Account Object](#account-object) representing the requested account.

## Remove Account

```bash
curl https://api.uphold.com/v0/me/accounts/18843b6d-5a43-480f-8e2b-73b27d726bf0 \
  -X DELETE
  -H "Authorization: Bearer <token>"
```

> The above command returns a response with no body, and HTTP status code `204`
([No Content](https://datatracker.ietf.org/doc/html/rfc7231#section-6.3.5)).

Deletes a specific account.

### Request

`DELETE https://api.uphold.com/v0/me/accounts/:id`

<aside class="notice">
  Requires the <code>accounts:write</code> scope for Uphold Connect applications.
</aside>
<aside class="notice">
  The account id must be owned by the user performing the API call.
</aside>

### Response

In case of success, returns a response with no body and an HTTP status code of `204`
([No Content](https://datatracker.ietf.org/doc/html/rfc7231#section-6.3.5)).

If the account doesn't exist under the authorization-granting user, returns a <a href="#errors">404 HTTP error</a>.

If the token lacks the `accounts:write` scope, returns a <a href="#errors">404 HTTP error</a>
with the JSON body `{ "error": "invalid_scope" }`.
