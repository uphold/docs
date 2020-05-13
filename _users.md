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
  "settings": {
    "currency": "USD",
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
    "otp": {
      "login": {
        "enabled": true
      },
      "transactions": {
        "transfer": {
          "enabled": false
        },
        "send": {
          "enabled": true
        },
        "withdraw": {
          "crypto": {
            "enabled": true
          }
        }
      }
    },
    "theme": "vintage"
  },
  "memberAt": "2015-07-10T15:36:20.288Z",
  "state": "WA",
  "status": "ok",
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
  }
}
```

### Request

`GET https://api.uphold.com/v0/me`
<aside class="notice">Requires the `user:read` scope for Uphold Connect applications.</aside>

### Response

Returns the details associated the current user.
<aside class="notice">Be advised that this method has the potential to return a great deal of data.</aside>

### Cards

The `cards` property will be removed from the response. To access the cards of a given user please refer to the appropriate specific [endpoint](#list-cards).

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
