# Cards

Uphold uses the concept of a "card" as a store of value. Each card is denominated by a currency or store of value, and every card is automatically provisioned one or more addresses to which value can be sent. Whenever value flows into a card, Uphold automatically converts that value into the value determined by the card's denomination. In the world of bitcoin for example, this allows one to preserve the original value sent by the sender and shields the recipient from any volatility they might be exposed to by holding bitcoin directly. This also allows recipients of funds to normalize all incoming funds to a single store of value regardless of how the value was originally sent.

## List Cards

```bash
curl https://api.uphold.com/v0/me/cards \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "id": "ade869d8-7913-4f67-bb4d-72719f0a2be0",
  "address": {
    "bitcoin": "1GpBtJXXa1NdG94cYPGZTc3DfRY2P7EwzH"
  },
  "label": "USD card",
  "currency": "USD",
  "balance": "897.29",
  "available": "897.29",
  "lastTransactionAt": "2014-09-24T18:11:53.561Z",
  "addresses": [{
    "id": "1GpBtJXXa1NdG94cYPGZTc3DfRY2P7EwzH",
    "network": "bitcoin"
  }],
  "settings": {
    "position": 1,
    "starred": true
  }
}, {
  "id": "91380a1f-c6f1-4d81-a204-8b40538c1f0d",
  "address": {
    "bitcoin": "1KHpy2xrscep4RiXPiM3jyjee82iBMyMan"
  },
  "label": "BTC Card #2",
  "currency": "BTC",
  "balance": "0.00",
  "available": "0.00",
  "lastTransactionAt": "2014-07-07T05:40:46.624Z",
  "addresses": [{
    "id": "1KHpy2xrscep4RiXPiM3jyjee82iBMyMan",
    "network": "bitcoin"
  }, {
    "id": "18yFebPW8USkoBtYXeV6quwgnPGEVyvpKi",
    "network": "bitcoin"
  }],
  "settings": {
    "position": 7,
    "starred": true
  }
}]
```

Retrieves a list of cards for the current user.

### Request

`GET https://api.uphold.com/v0/me/cards`

<aside class="notice">Requires the <code>cards:read</code> scope for Uphold Connect applications.</aside>

### Response

Returns an array of the current user's cards.

## Get Card Details

```bash
curl https://api.uphold.com/v0/me/cards/37e002a7-8508-4268-a18c-7335a6ddf24b \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "id": "2b2eb351-b1cc-48f7-a3d0-cb4f1721f3a3",
  "address": {
    "bitcoin": "145ZeN94MAtTmEgvhXEch3rRgrs7BdD2cY"
  },
  "label": "CNY card",
  "currency": "CNY",
  "balance": "42.82",
  "available": "42.82",
  "lastTransactionAt": "2014-06-16T20:46:51.002Z",
  "addresses": [{
    "id": "145ZeN94MAtTmEgvhXEch3rRgrs7BdD2cY",
    "network": "bitcoin"
  }],
  "settings": {
    "position": 5,
    "starred": true
  }
}
```

Retrieves the details about a specific card.

### Request

`GET https://api.uphold.com/v0/me/cards/:id`

<aside class="notice">Requires the <code>cards:read</code> scope for Uphold Connect applications.</aside>

<aside class="notice"><code>:id</code> can either be the card ID or its bitcoin address and it must be owned by the user making the call.
</aside>

### Response

Returns the details associated with the card ID provided.

## Create Card

```bash
curl https://api.uphold.com/v0/me/cards \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "label": "My New Card", "currency": "USD" }'
```

### Request

`POST https://api.uphold.com/v0/me/cards`

<aside class="notice">Requires the <code>cards:write</code> scope for Uphold Connect applications.</aside>

Parameter | Description
--------- | ----------------------------------------------------------------------------------------------------
label     | The display name of the card. Max length: 140 characters.
currency  | The currency to denominate value stored by the card, represented as a three character currency code.

### Response

Returns a fully formed [Card Object](#card-object) representing the card created.

## Update Card

```bash
curl https://api.uphold.com/v0/me/cards/37e002a7-8508-4268-a18c-7335a6ddf24b \
  -X PATCH \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "label": "My Updated Card" }'
```

### Request

`PATCH https://api.uphold.com/v0/me/cards/:id`

<aside class="notice">Requires the <code>cards:write</code> scope for Uphold Connect applications.</aside>

Parameter | Description
--------- | -----------------------------------------------------------------
label     | The display name of the card. Max length: 140 characters.
settings  | An object with the card's `position` and whether it is `starred`.

### Response

Returns a fully formed [Card Object](#card-object) representing the updated card.

## Create Card Crypto Address

```bash
curl https://api.uphold.com/v0/me/cards/37e002a7-8508-4268-a18c-7335a6ddf24b/addresses \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "network": "bitcoin" }'
```

> The above command returns the following JSON:

```json
{
  "id":"145ZeN94MAtTmEgvhXEch3rRgrs7BdD2cY",
  "network":"bitcoin"
}
```

Generate a crypto address for a card.

### Request

`POST https://api.uphold.com/v0/me/cards/:id/addresses`

<aside class="notice">Requires the <code>cards:write</code> scope for Uphold Connect applications.</aside>

Parameter | Description
--------- | ----------------------------------------------------------------------------------------------
network   | The type of crypto address. Possible values are: `bitcoin`, `ethereum`, `litecoin` or `voxel`.

### Response

Returns an object with the card address and the network.

## List Card Crypto Addresses

```bash
curl https://api.uphold.com/v0/me/cards/37e002a7-8508-4268-a18c-7335a6ddf24b/addresses \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json"
```

> The above command returns the following JSON:

```json
[
  {
    "id":"145ZeN94MAtTmEgvhXEch3rRgrs7BdD2cY",
    "network":"bitcoin"
  }
]
```

Retrieves a list of crypto addresses for a specific card.

### Request

`GET https://api.uphold.com/v0/me/cards/:id/addresses`

<aside class="notice">Requires the <code>cards:read</code> scope for Uphold Connect applications.</aside>

### Response

Returns an array with the card's crypto addresses and their networks.
