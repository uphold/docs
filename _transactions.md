# Transactions
## Create &amp; Commit a Transaction
> Step 1: Create the Transaction

```bash
curl https://api.uphold.com/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "denomination": { "amount": 0.1, "currency": "USD" }, "destination": "foo@bar.com" }'
```

> The above command returns the following JSON:

```json
{
  "denomination": {
    "amount": "0.1",
    "currency": "BTC",
    "rate": "1.00",
    "pair": "BTCBTC"
  },
  "fees": [],
  "id": "7c377eba-cb1e-45a2-8c13-9807b4139bec",
  "normalized": [{
    "amount": "900.00",
    "commission": "0.00",
    "currency": "USD",
    "fee": "0.00",
    "rate": "900.00000"
  }],
  "params": {
    "currency": "BTC",
    "margin": "0.00",
    "pair": "BTCBTC",
    "rate": "1.00",
    "ttl": 7000,
    "type": "invite"
  },
  "status": "pending",
  "type": "transfer",
  "origin": {
    "amount": "0.1",
    "base": "0.1",
    "CardId": "66cf2c86-8247-4094-bbec-ca29cea8220f",
    "commission": "0.00",
    "currency": "BTC",
    "description": "John Doe",
    "fee": "0.00",
    "rate": "1.00",
    "sources": [],
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
}
```

> Step 2: Commit the Transaction

```bash
curl https://api.uphold.com/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions/d51b4e4e-9827-40fb-8763-e0ea2880085b/commit \
  -X POST \
  -H "Authorization: Bearer <token>"
```

> Returns a [Transaction Object](#transaction-object).

### Step 1: Create Transaction
In step one, one prepares the transaction by specifying:

- The _currency_ to denominate the transaction by.
- The _amount_ of value to send in the denominated currency.
- The _origin_ of the transaction can be an account id in the case of a _deposit_.
- The _destination_ of the transaction, which can be in the form of a bitcoin address, an email address, an account id, an application id or an Uphold username.

The following table describes the types of transactions currently supported:

Type       | Origin                     | Destination
---------- | -------------------------- | -------------------------------------------------------
deposit    | _ACH_ or _SEPA_ account id | Uphold card id
withdrawal | Uphold card id             | _ACH_, _SEPA_ or _Bitcoin_ address
transfer   | Uphold card id             | An email address, an application id, an Uphold username or an Uphold card id

Upon preparing a transaction, a [Transaction Object](#transaction-object) will be returned with a newly-generated `id`.
<aside class="notice">
  You may only send value from addresses that you own.
</aside>

<aside class="notice">
  Adding the query string parameter `?commit=true` to this request will create and commit the transaction in a single step.
</aside>

### Request
`POST https://api.uphold.com/v0/me/cards/:card/transactions`
<aside class="notice">Requires any of the following scopes: `transactions:deposit`, `transactions:transfer:application`, `transactions:transfer:others`, `transactions:transfer:self` or `transactions:withdraw` for Uphold Connect applications. If creating with the query string parameter `?commit=true`, the scope has to match the type of transaction being committed.</aside>

### Response
Returns a [Transaction Object](#transaction-object).

### Step 2: Commit Transaction
Once a transaction has been created and a quote secured, commit the transaction using the previously returned `id`. An optional parameter `message` can also be sent which will overwrite the value currently stored in the transaction.

### Request
`POST https://api.uphold.com/v0/me/cards/:card/transactions/:id/commit`
<aside class="notice">Requires any of the following scopes, based on the type of transaction being committed: `transactions:deposit`, `transactions:transfer:application`, `transactions:transfer:others`, `transactions:transfer:self` or `transactions:withdraw` for Uphold Connect applications.</aside>

### Response
Returns a [Transaction Object](#transaction-object).

## Cancel a Transaction

```bash
curl https://api.uphold.com/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions/d51b4e4e-9827-40fb-8763-e0ea2880085b/cancel \
  -X POST \
  -H "Authorization: Bearer <token>"
```

> Returns a [Transaction Object](#transaction-object).

Cancels a transaction that has not yet been redeemed.

### Request
`POST https://api.uphold.com/v0/me/cards/:card/transactions/:id/cancel`
<aside class="notice">Requires the `transactions:transfer:others` scope for Uphold Connect applications.</aside>

### Response
Returns a [Transaction Object](#transaction-object).
<aside class="notice">Only transactions with status `waiting` can be cancelled.</aside>

## Resend a Transaction

```bash
curl https://api.uphold.com/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions/d51b4e4e-9827-40fb-8763-e0ea2880085b/resend \
  -X POST \
  -H "Authorization: Bearer <token>"
```

> Returns a [Transaction Object](#transaction-object).

Triggers a reminder for a transaction that hasn't been redeemed yet.

### Request
`POST https://api.uphold.com/v0/me/cards/:card/transactions/:id/resend`
<aside class="notice">Requires the `transactions:transfer:others` scope for Uphold Connect applications.</aside>

### Response
Returns a [Transaction Object](#transaction-object).
<aside class="notice">Only transactions with status `waiting` can be resent.</aside>

## List User Transactions

```bash
curl https://api.uphold.com/v0/me/transactions \
  -X GET \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[
  {
    "createdAt": "2014-08-27T00:01:11.616Z",
    "denomination": {
      "amount": "1.00",
      "currency": "USD",
      "rate": "1.00",
      "pair": "USDUSD"
    },
    "fees": [],
    "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634",
    "message": null,
    "params": "<excluded for brevity>",
    "status": "waiting",
    "type": "transfer",
    "origin": "<excluded for brevity>",
    "destination": "<excluded for brevity>",
    "RefundedById": null
  },
  {
    "createdAt": "2014-08-27T00:01:12.616Z",
    "denomination": {
      "amount": "1.00",
      "currency": "USD",
      "rate": "1.00",
      "pair": "USDUSD"
    },
    "fees": [],
    "id": "b97bb994-6e24-4a89-b653-e0a6d0bcf635",
    "message": null,
    "params": "<excluded for brevity>",
    "status": "waiting",
    "type": "transfer",
    "origin": "<excluded for brevity>",
    "destination": "<excluded for brevity>",
    "RefundedById": null
  }
]
```

Requests a list of transactions associated with the current user.

### Request
`GET https://api.uphold.com/v0/me/transactions`
<aside class="notice">Requires the `transactions:read` scope for Uphold Connect applications.</aside>

This endpoint supports [Pagination](#pagination).

### Response
Returns an array of [Transaction Objects](#transaction-object).

## List Card Transactions

```bash
curl https://api.uphold.com/v0/me/cards/2b2eb351-b1cc-48f7-a3d0-cb4f1721f3a3/transactions \
  -X GET \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[
  {
    "createdAt": "2014-08-27T00:01:11.616Z",
    "denomination": {
      "amount": "1.00",
      "currency": "USD",
      "rate": "1.00",
      "pair": "USDUSD"
    },
    "fees": [],
    "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634",
    "message": null,
    "params": "<excluded for brevity>",
    "status": "waiting",
    "type": "transfer",
    "origin": "<excluded for brevity>",
    "destination": "<excluded for brevity>",
    "RefundedById": null
  },
  {
    "createdAt": "2014-08-27T00:01:12.616Z",
    "denomination": {
      "amount": "1.00",
      "currency": "USD",
      "rate": "1.00",
      "pair": "USDUSD"
    },
    "fees": [],
    "id": "b97bb994-6e24-4a89-b653-e0a6d0bcf635",
    "message": null,
    "params": "<excluded for brevity>",
    "status": "waiting",
    "type": "transfer",
    "origin": "<excluded for brevity>",
    "destination": "<excluded for brevity>",
    "RefundedById": null
  }
]
```

Requests a list of transactions associated with a specific card.

### Request
`GET https://api.uphold.com/v0/me/cards/:card/transactions`
<aside class="notice">Requires the `transactions:read` scope for Uphold Connect applications.</aside>

This endpoint supports [Pagination](#pagination).

### Response
Returns an array of [Transaction Objects](#transaction-object).

## Get All Transactions (Public)

```bash
curl -X GET "https://api.uphold.com/v0/reserve/transactions"
```

> The above command returns the following JSON, truncated for brevity:

```json
[{
  "createdAt": "2014-09-25T19:19:51.201Z",
  "denomination": {
    "amount": "25.00",
    "currency": "USD",
    "rate": "1.00",
    "pair": "USDUSD"
  },
  "fees": [{
    "type": "exchange",
    "amount": "0.00",
    "target": "destination",
    "currency": "BTC",
    "percentage": "0.00"
  }],
  "id": "63dc7ccb-0e57-400d-8ea7-7d903753801c",
  "message": null,
  "params": {
    "currency": "USD",
    "margin": "0.00",
    "pair": "BTCUSD",
    "progress": "1",
    "rate": "900.00000",
    "ttl": 7000,
    "type": "transfer"
  },
  "status": "completed",
  "type": "transfer",
  "normalized": [{
    "fee": "0.00",
    "rate": "0.91759",
    "amount": "22.94",
    "currency": "EUR",
    "commission": "0.00"
  }],
  "origin": {
    "amount": "25.00",
    "base": "25.00",
    "CardId": "f4dbc023-61bb-43e9-9ce6-7f34efd9e688",
    "commission": "0.00",
    "currency": "USD",
    "description": "Nuno Sousa",
    "fee": "0.00",
    "rate": "900.00000",
    "sources": [{
      "id": "4586e3f6-5fff-473f-b479-4e7ce2ba14cf",
      "amount": "25.00"
    }],
    "type": "card",
    "username": "johndoe"
  },
  "destination": {
    "amount": "0.02777777",
    "base": "0.02777777",
    "CardId": "d42999c4-30c9-4a61-889c-62a4050bce88",
    "commission": "0.00",
    "currency": "BTC",
    "description": "Nuno Sousa",
    "fee": "0.00",
    "rate": "0.00111111",
    "type": "card",
    "username": "johndoe"
  },
},
{
  "createdAt": "2016-01-19T12:07:01.611Z",
  "denomination": {
    "amount": "0.01",
    "currency": "BTC",
    "rate": "1.00",
    "pair": "BTCBTC"
  },
  "fees": [{
    "type": "network",
    "amount": "0.0002",
    "target": "origin",
    "currency": "BTC"
  }, {
    "type": "withdrawal",
    "amount": "0.00",
    "target": "origin",
    "currency": "BTC",
    "percentage": "0.5"
  }],
  "id": "99191bf6-52d8-4f29-92e8-676b68c9a85b",
  "message": null,
  "network": "bitcoin",
  "normalized": [{
    "amount": "9.18",
    "commission": "0.00",
    "currency": "USD",
    "fee": "0.18",
    "rate": "900.00000"
  }],
  "params": {
    "currency": "BTC",
    "margin": "0.00",
    "pair": "BTCBTC",
    "progress": "1",
    "rate": "1.00",
    "ttl": 7000,
    "type": "external/out"
  },
  "status": "completed",
  "type": "withdrawal",
  "origin": {
    "amount": "0.0102",
    "base": "0.01",
    "CardId": "d42999c4-30c9-4a61-889c-62a4050bce88",
    "commission": "0.00",
    "currency": "BTC",
    "description": "Nuno Sousa",
    "fee": "0.0002",
    "rate": "1.00",
    "sources": [{
      "id": "390ed0ab-c014-43f3-868a-8ea3ea56025e",
      "amount": "0.0102"
    }],
    "type": "card",
    "username": "johndoe"
  },
  "destination": {
    "address": "n2eMqTT929pb1RDNuqEnxdaLau1rxy3efi",
    "amount": "0.01",
    "base": "0.01",
    "commission": "0.00",
    "currency": "BTC",
    "description": "n2eMqTT929pb1RDNuqEnxdaLau1rxy3efi",
    "fee": "0.00",
    "rate": "1.00",
    "type": "external"
  }
}]
```

See also: [Transparency: Reservechain](#the-reservechain)

Requests the public view of all transactions in the reserve.

### Request
`GET https://api.uphold.com/v0/reserve/transactions`

This endpoint supports [Pagination](#pagination).

### Response
Returns an array of [Transaction Objects](#transaction-object).
<aside class="notice">Be advised that this method has the potential to return a great deal of data.</aside>

## Get Transaction (Public)

```bash
curl -X GET "https://api.uphold.com/v0/reserve/transactions/a97bb994-6e24-4a89-b653-e0a6d0bcf634"
```

> The above command returns the following JSON:

```json
{
  "application": null,
  "createdAt": "2014-08-27T00:01:11.616Z",
  "denomination": {
    "amount": "1.00",
    "currency": "USD",
    "rate": "1.00",
    "pair": "USDUSD"
  },
  "fees": [],
  "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634",
  "params": {
    "currency": "USD",
    "margin": "0.00",
    "pair": "USDUSD",
    "rate": "1.00"
  },
  "status": "cancelled",
  "type": "transfer",
  "origin": {
    "amount": "1.00",
    "base": "1.00",
    "commission": "0.00",
    "currency": "USD",
    "fee": "0.00",
    "rate": "1.00",
    "sources": [{
      "id": "35325c99-edeb-4625-9cd8-f56d4783c352",
      "amount": "1"
    }]
  },
  "destination": {
    "amount": "1.00",
    "base": "1.00",
    "commission": "0.00",
    "currency": "USD",
    "fee": "0.00",
    "rate": "1.00"
  }
}
```

See also: [Transparency: Reservechain](#the-reservechain)

Requests the public view of a specific transaction.

### Request
`GET https://api.uphold.com/v0/reserve/transactions/:id`

### Response
Returns a [Transaction Object](#transaction-object).
<aside class="notice">Note that you will only receive the list of committed transactions.</aside>
