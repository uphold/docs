# Accounts
Uphold allows users to deposit value into a specific card from an external source (ACH account, debit/credit card or wire transfer) or withdraw to an external source (ACH account or wire transfer).

Whenever a deposit is made into an Uphold card, it will be automatically converted into the value determined by the card's denomination. Likewise, when a withdrawal is made, the currency will be converted to the currency of the destination account, thus minimizing fees and currency conversions.

We support the following account types:

Account type | Deposits supported? | Withdrawals supported?
------------ | ------------------- | ----------------------
ach          | Yes                 | Yes
card         | Yes                 | No
sepa         | Yes                 | Yes

Please refer to our FAQ for estimated [ACH transaction times](https://support.uphold.com/hc/en-us/articles/206762103-How-to-add-and-withdraw-funds-via-bank-transfer-U-S-), [SEPA transaction times](https://support.uphold.com/hc/en-us/articles/205803186-How-to-add-and-withdraw-funds-via-bank-transfer-Europe-), [fees and limits](https://support.uphold.com/hc/en-us/articles/206118653-Transaction-Trading-Limits).

## List Accounts

```bash
curl https://api.uphold.com/v0/me/accounts \
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
<aside class="notice">Requires the `accounts:read` scope for Uphold Connect applications.</aside>

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
<aside class="notice">Requires the `accounts:read` scope for Uphold Connect applications.</aside>
<aside class="notice">The account id must be owned by the user performing the API call.</aside>

### Response
Returns a fully formed [Account Object](#account-object) representing the requested account.
