# Transactions

## Create &amp; Commit a Transaction

> Step 1: Create the Transaction

```bash
curl "https://api.bitreserve.org/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions" \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -d "denomination[currency]=BTC&denomination[amount]=0.1&destination=foo@bar.com"
```

> The above command returns the following JSON:

```json
{
  "id": "7c377eba-cb1e-45a2-8c13-9807b4139bec",
  "status": "pending",
  "type": "transfer",
  "denomination": {
    "amount": "0.1",
    "currency": "BTC",
    "pair": "BTCBTC",
    "rate": "1.00"
  },
  "origin": {
    "CardId": "66cf2c86-8247-4094-bbec-ca29cea8220f",
    "amount": "0.1",
    "base": "0.1",
    "commission": "0.00",
    "currency": "BTC",
    "description": "John Doe",
    "fee": "0.00",
    "rate": "1.00",
    "type": "card",
    "username": "johndoe"
  },
  "destination": {
    "amount": "0.1",
    "base": "0.1",
    "commission": "0.00",
    "currency": "BTC",
    "description": "foo@bar.com",
    "fee": "0.00",
    "rate": "1.00",
    "type": "email"
  },
  "params": {
    "currency": "BTC",
    "margin": "0.00",
    "pair": "BTCBTC",
    "rate": "1.00",
    "ttl": 30000,
    "type": "invite"
  }
}
```

> Step 2: Commit the Transaction

```bash
curl "https://api.bitreserve.org/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions/d51b4e4e-9827-40fb-8763-e0ea2880085b/commit" \
  -X POST \
  -H "Authorization: Bearer <token>"
```

> Returns a [Transaction Object](#transaction-object).

### Step 1: Create Transaction

In step one, one prepares the transaction by specifying:

* The currency to denominate the transaction by.
* The amount of value to send in the denominated currency.
* The destination of the transaction, which can be in the form of a bitcoin address, an email address, or a Bitreserve username.

Upon preparing a transaction, a [Transaction Object](#transaction-object) will be returned with a newly-generated `id`.

<aside class="notice">
You may only send value from addresses that you own.
</aside>

### Request

`POST https://api.bitreserve.org/v0/me/cards/:card/transactions`

### Response

Returns a [Transaction Object](#transaction-object).


### Step 2: Commit Transaction

Once a transaction has been created and a quote secured, commit the transaction using the previously returned `id`. An optional parameter
`message` can also be sent which will overwrite the value currently stored in the transaction.

### Request

`POST https://api.bitreserve.org/v0/me/cards/:card/transactions/:id/commit`

### Response

Returns a [Transaction Object](#transaction-object).

## Cancel a Transaction

```bash
curl "https://api.bitreserve.org/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions/d51b4e4e-9827-40fb-8763-e0ea2880085b/cancel" \
  -X POST \
  -H "Authorization: Bearer <token>"
```

> Returns a [Transaction Object](#transaction-object).

Cancels a transaction that has not yet been redeemed.

### Request

`POST https://api.bitreserve.org/v0/me/cards/:card/transactions/:id/cancel`

### Response

Returns a [Transaction Object](#transaction-object).

<aside class="notice">Only transactions with status `waiting` can be cancelled.</aside>

## Resend a Transaction

```bash
curl "https://api.bitreserve.org/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions/d51b4e4e-9827-40fb-8763-e0ea2880085b/resend" \
  -X POST \
  -H "Authorization: Bearer <token>"
```

> Returns a [Transaction Object](#transaction-object).

Triggers a reminder for a transaction that hasn't been redeemed yet.

### Request

`POST https://api.bitreserve.org/v0/me/cards/:card/transactions/:id/resend`

### Response

Returns a [Transaction Object](#transaction-object).

<aside class="notice">Only transactions with status `waiting` can be resent.</aside>

## List User Transactions

```bash
curl "https://api.bitreserve.org/v0/me/transactions" \
  -X GET \
  -H "Authorization: Bearer <token>"
```
> The above command returns the following JSON:

```json
[
  {
    "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634",
    "message":null,
    "status": "waiting",
    "RefundedById":null,
    "createdAt": "2014-08-27T00:01:11.616Z",
    "denomination": {
      "rate": "1.00",
      "amount": "1.00",
      "currency": "USD"
    },
    "origin": "<excluded for brevity>",
    "destination": "<excluded for brevity>",
    "params": "<excluded for brevity>"
  },
  {
    "id": "b97bb994-6e24-4a89-b653-e0a6d0bcf635",
    "message":null,
    "status": "waiting",
    "RefundedById":null,
    "createdAt": "2014-08-27T00:01:12.616Z",
    "denomination": {
      "rate": "1.00",
      "amount": "1.00",
      "currency": "USD"
    },
    "origin": "<excluded for brevity>",
    "destination": "<excluded for brevity>",
    "params": "<excluded for brevity>"
  }
]
```

Requests a list of transactions associated with the current user.

### Request

`GET https://api.bitreserve.org/v0/me/transactions`

This endpoint supports [Pagination](#pagination).

### Response

Returns an array of [Transaction Objects](#transaction-object).

## List Card Transactions

```bash
curl "https://api.bitreserve.org/v0/me/cards/2b2eb351-b1cc-48f7-a3d0-cb4f1721f3a3/transactions" \
  -X GET \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[
  {
    "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634",
    "message":null,
    "status": "waiting",
    "RefundedById":null,
    "createdAt": "2014-08-27T00:01:11.616Z",
    "denomination": {
      "rate": "1.00",
      "amount": "1.00",
      "currency": "USD"
    },
    "origin": "<excluded for brevity>",
    "destination": "<excluded for brevity>",
    "params": "<excluded for brevity>"
  },
  {
    "id": "b97bb994-6e24-4a89-b653-e0a6d0bcf635",
    "message":null,
    "status": "waiting",
    "RefundedById":null,
    "createdAt": "2014-08-27T00:01:12.616Z",
    "denomination": {
      "rate": "1.00",
      "amount": "1.00",
      "currency": "USD"
    },
    "origin": "<excluded for brevity>",
    "destination": "<excluded for brevity>",
    "params": "<excluded for brevity>"
  }
]
```

Requests a list of transactions associated with a specific card.

### Request

`GET https://api.bitreserve.org/v0/me/cards/:card/transactions`

This endpoint supports [Pagination](#pagination).

### Response

Returns an array of [Transaction Objects](#transaction-object).

## Get All Transactions (Public)

```bash
curl -X GET "https://api.bitreserve.org/v0/reserve/transactions"
```

> The above command returns the following JSON, truncated for brevity:

```json
[
  {
    "id": "63dc7ccb-0e57-400d-8ea7-7d903753801c",
    "params": {
      "margin": "0.45",
      "pair": "BTCUSD",
      "type": "transfer"
    },
    "denomination": {
      "amount": "25.00",
      "currency": "USD"
    },
    "origin": {
      "amount": "25.00",
      "base": "25.00",
      "commission": "0.00",
      "currency": "USD",
      "fee": "0.00",
      "rate": "408.19000"
    },
    "destination": {
      "amount": "0.06087161",
      "base": "0.06124598",
      "commission": "0.00027437",
      "currency": "BTC",
      "fee": "0.0001",
      "rate": "0.00244983"
    },
    "status": "completed",
    "quotedAt": "2014-09-25T19:19:36.052Z",
    "createdAt": "2014-09-25T19:19:51.201Z"
  },
  {
    "id": "fc4263a8-5df0-493d-bd26-517a218c7089",
    "params": {
      "margin": "0.00",
      "pair": "BTCBTC",
      "type": "external/out"
    },
    "denomination": {
      "amount": "0.45",
      "currency": "BTC"
    },
    "origin": {
      "amount": "0.4501",
      "base": "0.45",
      "commission": "0.00",
      "currency": "BTC",
      "fee": "0.0001",
      "rate": "1.00"
    },
    "destination": {
      "amount": "0.45",
      "base": "0.45",
      "commission": "0.00",
      "currency": "BTC",
      "fee": "0.00",
      "rate": "1.00"
    },
    "status": "completed",
    "quotedAt": "2014-09-25T18:11:42.300Z",
    "createdAt": "2014-09-25T18:11:50.182Z"
  }
]
```

See also: [Transparency: Reservechain](#the-reservechain)

Requests the public view of all transactions in the reserve.

### Request

`GET https://api.bitreserve.org/v0/reserve/transactions`

This endpoint supports [Pagination](#pagination).

### Response

Returns an array of [Transaction Objects](#transaction-object).

<aside class="notice">Be advised that this method has the potential to return a great deal of data.</aside>

## Get Transaction (Public)

```bash
curl -X GET "https://api.bitreserve.org/v0/reserve/transactions/a97bb994-6e24-4a89-b653-e0a6d0bcf634"
```

> The above command returns the following JSON:

```json
{
  "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634",
  "params": {
    "type": "invite",
    "pair": "USDUSD"
  },
  "origin": {
    "base": "1.00",
    "amount": "1.00",
    "commission": "0.00",
    "fee": "0.00",
    "currency": "USD"
  },
  "destination": {
    "base": "1.00",
    "amount": "1.00",
    "commission": "0.00",
    "fee": "0.00",
    "currency": "USD"
  },
  "status": "waiting"
}
```

See also: [Transparency: Reservechain](#the-reservechain)

Requests the public view of a specific transaction.

### Request

`GET https://api.bitreserve.org/v0/reserve/transactions/:id`

### Response

Returns a [Transaction Object](#transaction-object).

<aside class="notice">Note that you will only receive the list of committed transactions.</aside>
