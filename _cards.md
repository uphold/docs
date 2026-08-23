# Cards

Uphold uses the concept of a "card" as a store of value.
Each card is denominated by a currency or store of value, and addresses to which value can be sent can be created on demand for a card via the [Create Card Address](#create-card-address) endpoint.
(Note that there can be multiple cards for the same currency.)

Whenever value flows into a card, Uphold automatically converts that value into the value determined by the card's denomination.
In the world of bitcoin, for example, this allows one to preserve the original value sent by the sender, and shields the recipient from any volatility they might be exposed to by holding bitcoin directly.
This also allows recipients of funds to normalize all incoming funds to a single store of value, regardless of how the value was originally sent.

## List Cards

> The basic request to this endpoint lists all cards for the current user:

```bash
curl https://api.uphold.com/v0/me/cards \
  -H "Authorization: Bearer <token>"
```

> Example of filtering the list to show only starred cards denominated in BTC or EUR:

```bash
curl 'https://api.uphold.com/v0/me/cards?q=currency:BTC,EUR%20settings.starred:true' \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "address": {
    "bitcoin": "mkZuBgFa4gAjJ2UckDA3Pms68rVBavAneF"
  },
  "available": "5.00",
  "balance": "5.00",
  "currency": "BTC",
  "id": "024e51fc-5513-4d82-882c-9b22024280cc",
  "label": "BTC card",
  "lastTransactionAt": "2018-08-01T09:53:44.617Z",
  "normalized": [{
    "available": "4500.00",
    "balance": "4500.00",
    "currency": "USD"
  }],
  "settings": {
    "position": 0,
    "protected": false,
    "starred": true
  }
},
{
  "address": {
    "bitcoin": "ms22VBPSahNTxHZNkYo2d4Rmw1Tgfx6ojr"
  },
  "available": "146.38",
  "balance": "146.38",
  "currency": "EUR",
  "id": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3",
  "label": "EUR card",
  "lastTransactionAt": "2018-08-01T09:53:51.258Z",
  "normalized": [{
    "available": "170.96",
    "balance": "170.96",
    "currency": "USD"
  }],
  "settings": {
    "position": 0,
    "protected": false,
    "starred": true
  }
}]
```

Retrieves a list of cards for the current user.

### Request

`GET https://api.uphold.com/v0/me/cards`

<aside class="notice">
  Requires the <code>cards:read</code> scope for Uphold Connect applications.
</aside>

You can filter the list of returned cards using the `q` query string parameter.
Supported filters are `currency:` (which accepts a comma-separated list of currencies), `id:` (which accepts a comma-separated list of card IDs) and `settings.starred:` (which accepts `true` or `false`).
Multiple filters can be used together, separated with a space.
See the code to the right for an example.

The list can also be sorted using the following query string parameters:

Parameter          | Description
------------------ | --------------------------------------------------------------------------------------------------------------------------------------
direction          | The sort direction. Possible values are `asc` and `desc`. Defaults to `asc`.
normalizedCurrency | The currency in which the `normalized` amounts are expressed. Defaults to the user's settings currency.
sort               | The field to sort the list by. Possible values are `createdAt`, `currency`, `normalized.available` and `normalized.balance`. Defaults to `currency`.

This endpoint supports [Pagination](#pagination).

### Response

Returns an array of the current user's cards.

## Get Card Details

```bash
curl https://api.uphold.com/v0/me/cards/bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3 \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "address": {
    "bitcoin": "ms22VBPSahNTxHZNkYo2d4Rmw1Tgfx6ojr"
  },
  "available": "146.38",
  "balance": "146.38",
  "currency": "EUR",
  "id": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3",
  "label": "EUR card",
  "lastTransactionAt": "2018-08-01T09:53:51.258Z",
  "normalized": [{
    "available": "170.96",
    "balance": "170.96",
    "currency": "USD"
  }],
  "settings": {
    "position": 0,
    "protected": false,
    "starred": true
  }
}
```

Retrieves the details about a specific card.

### Request

`GET https://api.uphold.com/v0/me/cards/:id`

<aside class="notice">
  Requires the <code>cards:read</code> scope for Uphold Connect applications.
</aside>
<aside class="notice">
  <code>:id</code> can either be the card ID or any of the card's crypto addresses (on any network), and it must be owned by the user making the call.
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

<aside class="notice">
  Requires the <code>cards:write</code> scope for Uphold Connect applications.
</aside>

Parameter | Required | Description
--------- | -------- | -------------------------------------------------------------------------------------------------------------
currency  | yes      | The [currency](#currencies) to denominate the value stored by the card, represented by its code (e.g. "USD").
label     | no       | The display name of the card. Max length: 140 characters. If omitted, a default label is derived from the asset's name (e.g. "Bitcoin account").
settings  | no       | This property contains the following keys:
|         |          | `starred`: Indicates whether the card is starred or not. Defaults to `false`.

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

<aside class="notice">
  Requires the <code>cards:write</code> scope for Uphold Connect applications.
</aside>

Parameter | Description
--------- | -----------------------------------------------------------------
label     | The display name of the card. Max length: 140 characters.
settings  | This property contains the following keys:
|         | `starred`: Indicates whether the card is starred or not.

<aside class="notice">
  The deprecated <code>settings.position</code> key is ignored if sent.
  Cards no longer have a position — the field is always returned as <code>0</code> for backward compatibility.
</aside>

### Response

Returns a fully formed [Card Object](#card-object) representing the updated card.

## Create Card Address

```bash
curl https://api.uphold.com/v0/me/cards/024e51fc-5513-4d82-882c-9b22024280cc/addresses \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "network": "ethereum" }'
```

> The above command returns the following JSON:

```json
{
  "id": "0x807A30A52180c4172ddCE90816bc951D004CF737",
  "network": "ethereum"
}
```

Generate an address for a card.

<aside class="notice">
  For tag-based networks — <code>stellar</code>, <code>ton</code> and <code>xrp-ledger</code> — the response also returns the <code>tag</code> property (e.g. the <code>Destination Tag</code> on the XRP Ledger), which must be included when sending funds to the address.
</aside>

> For an XRP Ledger address, the following JSON is returned:

```json
{
  "id": "rPjTZfLP3Qxwwd2xvXSALJzEFmmf7bEYgh",
  "network": "xrp-ledger",
  "tag": "1921241954"
}
```

### Request

`POST https://api.uphold.com/v0/me/cards/:id/addresses`

<aside class="notice">
  Requires the <code>cards:write</code> scope for Uphold Connect applications.
</aside>
<aside class="notice">
  Requires the user to have the deposits capability, otherwise a <code>403</code> error is returned.
  The card's currency must support buying, otherwise a <code>400</code> error is returned.
  Only one address can be created per network on each card.
</aside>

Parameter | Description
--------- | -----------------------------------------------------------------------------------------------------------------------------------------------------
network   | The address network. Possible values are the networks of the cryptocurrencies available to the user — for example `bitcoin`, `ethereum`, `litecoin`, `solana`, `ton`, `tron` and `xrp-ledger`, among many others.

### Response

Returns an object with the card address and the network.

## List Card Addresses

```bash
curl https://api.uphold.com/v0/me/cards/37e002a7-8508-4268-a18c-7335a6ddf24b/addresses \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json"
```

> The above command returns the following JSON:

```json
[{
  "formats": [{
    "format": "wrappedSegWit",
    "value": "3QJmV3qfvL9SuYo34YihAf3sRCW3qSinyC"
  }, {
    "format": "nativeSegWit",
    "value": "bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq"
  }],
  "type": "bitcoin"
},
{
  "formats": [{
    "format": "pubkeyhash",
    "value": "0x807A30A52180c4172ddCE90816bc951D004CF737"
  }],
  "type": "ethereum"
},
{
  "formats": [{
    "format": "pubkeyhash",
    "value": "rPjTZfLP3Qxwwd2xvXSALJzEFmmf7bEYgh"
  }],
  "tag": "1921241954",
  "type": "xrp-ledger"
}]
```

Retrieves a list of addresses for a specific card.

<aside class="notice">
  The <code>tag</code> property is returned for tag-based networks — <code>stellar</code>, <code>ton</code> and <code>xrp-ledger</code> — and identifies the card on the shared address (e.g. the <code>Destination Tag</code> on the XRP Ledger).
</aside>

### Request

`GET https://api.uphold.com/v0/me/cards/:id/addresses`

<aside class="notice">
  Requires the <code>cards:read</code> scope for Uphold Connect applications.
</aside>

### Response

Returns an array with the card addresses and their networks.
