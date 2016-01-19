# Users
## Get User

```bash
curl "https://api.uphold.com/v0/me" \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "address": {
    "city": "New Valentinstad",
    "line1": "80236 Ivy Loaf",
    "line2": "Apt. 366",
    "zipCode": "53059"
  },
  "birthdate": "2014-08-27",
  "country": "US",
  "currencies": [
    "BTC"
  ],
  "email": "luke.skywalker@uphold.com",
  "firstName": "Luke",
  "lastName": "Skywalker",
  "name": "Luke Skywalker",
  "phones": [{
    "e164Masked": "+XXXXXXXXX06",
    "id": "7eb106e5-65c0-461a-8c1d-b6e1f44a7bc7",
    "internationalMasked": "+X XXX-XXX-XX06",
    "nationalMasked": "(XXX) XXX-XX06",
    "primary": true,
    "verified": true
  }],
  "settings": {
    "currency": "USD",
    "hasOtpEnabled": true,
    "intl": {
      "dateTimeFormat": {
        "locale": "en-US"
      },
      "language": {
        "locale": "en-US"
      },
      "numberFormat": {
        "locale": "en-US"
      }
    },
    "theme": "vintage"
  },
  "memberAt": "2015-07-10T15:36:20.288Z",
  "state": "WA",
  "status": "ok",
  "username": "skywalker",
  "verifications": {},
  "balances": {
    "total": "90.00",
    "currencies": {
      "BTC": {
        "amount": "90.00",
        "balance": "0.1",
        "currency": "USD",
        "rate": "900.00000"
      }
    }
  },
  "cards": [{
    "address": {
      "bitcoin": "mwvGZzRfgco7AVKajLkByGom5BTp6EMng7"
    },
    "available": "0.1",
    "balance": "0.1",
    "currency": "BTC",
    "id": "b152a105-c47d-4a8f-8904-9838a3fed608",
    "label": "BTC card",
    "lastTransactionAt": "2015-07-01T19:43:58.824Z",
    "settings": {
      "position": 1,
      "starred": true
    },
    "addresses": [{
      "id": "mwvGZzRfgco7AVKajLkByGom5BTp6EMng7",
      "network": "bitcoin"
    }],
    "normalized": [{
      "available": "90.00",
      "balance": "90.00",
      "currency": "USD"
    }]
  }]
}
```

### Request
`GET https://api.uphold.com/v0/me`
<aside class="notice">Requires the `user:read` scope for Uphold Connect applications.</aside>

### Response
Returns the details associated the current user.
<aside class="notice">Be advised that this method has the potential to return a great deal of data.</aside>

## Get User Phone Numbers

```bash
curl "https://api.uphold.com/v0/me/phones" \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "id": "1d78aeb5-43ac-4ee8-8d28-1291b5d8355c",
  "verified": "true",
  "primary": "true",
  "e164Masked": "+XXXXXXXXX04",
  "nationalMasked": "(XXX) XXX-XX04",
  "internationalMasked": "+X XXX-XXX-XX04"
}]
```

### Request
`GET https://api.uphold.com/v0/me/phones`

### Response
Returns an array of all the phone numbers associated with the current user.
