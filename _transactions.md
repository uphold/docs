# Transactions

## Create &amp; Commit a Transaction

> Step 1: Create the Transaction

```bash
curl https://api.uphold.com/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "denomination": { "amount": "0.1", "currency": "USD" }, "destination": "foo@bar.com" }'
```

> The above command returns the following JSON:

```json
{
  "application": null,
  "createdAt": "2018-08-01T09:53:47.020Z",
  "denomination": {
    "amount": "5.00",
    "currency": "GBP",
    "pair": "GBPUSD",
    "rate": "1.31"
  },
  "destination": {
    "CardId": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3",
    "amount": "5.57",
    "base": "5.61",
    "commission": "0.04",
    "currency": "EUR",
    "description": "Angel Rath",
    "fee": "0.00",
    "isMember": true,
    "node": {
      "id": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3",
      "type": "card",
      "user": {
        "id": "21e65c4d-55e4-41be-97a1-ff38d8f3d945"
      }
    },
    "rate": "0.85620",
    "type": "card"
  },
  "fees": [{
    "amount": "0.04",
    "currency": "EUR",
    "percentage": "0.65",
    "target": "destination",
    "type": "exchange"
  }],
  "id": "2c326b15-7106-48be-a326-06f19e69746b",
  "message": null,
  "network": "uphold",
  "normalized": [{
    "amount": "6.56",
    "commission": "0.05",
    "currency": "USD",
    "fee": "0.00",
    "rate": "1.00000",
    "target": "destination"
  }],
  "origin": {
    "CardId": "48ce2ac5-c038-4426-b2f8-a2bdbcc93053",
    "amount": "6.56",
    "base": "6.56",
    "commission": "0.00",
    "currency": "USD",
    "description": "Angel Rath",
    "fee": "0.00",
    "isMember": true,
    "node": {
      "id": "48ce2ac5-c038-4426-b2f8-a2bdbcc93053",
      "type": "card",
      "user": {
        "id": "21e65c4d-55e4-41be-97a1-ff38d8f3d945"
      }
    },
    "rate": "1.16795",
    "sources": [{
      "amount": "6.56",
      "id": "3db4ef24-c529-421f-8e8f-eb9da1b9a582"
    }],
    "type": "card"
  },
  "params": {
    "currency": "USD",
    "margin": "0.65",
    "pair": "EURUSD",
    "progress": "1",
    "rate": "1.16795",
    "ttl": 18000,
    "type": "transfer"
  },
  "priority": "normal",
  "reference": null,
  "status": "completed",
  "type": "transfer"
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

The first step is to prepare the transaction by specifying:

- The _currency_ to denominate the transaction by.
- The _amount_ of value to send in the denominated currency.
- The _origin_ of the transaction, which can be an account id in the case of a _deposit_.
- The _destination_ of the transaction, which can be in the form of a [crypto network address](#create-card-address), an email address, an account id, an application id, or a [card id](#card-object).
- An optional _message_, which is shown to the user to provide additional context.
- An optional _reference_ code, which can be used as a unique identifier of the transaction in an external system, or for similar purposes.
- An optional _priority_ for the transaction ("normal" or "fast", with the default being "normal"),
  to signal the intent to fast-track its completion in exchange for a higher fee.
  This is currently only supported for the Dash network.

The following table describes the types of transactions currently supported:

Type       | Origin                              | Destination
---------- | ----------------------------------- | --------------------------------------------------------
deposit    | ACH, credit card or SEPA account id | Uphold card id
withdrawal | Uphold card id                      | ACH or SEPA account id, or cryptocurrency address
transfer   | Uphold card id                      | Email address, Application id or Uphold card id

Upon preparing a transaction, a [Transaction Object](#transaction-object) will be returned with a newly-generated `id`, and a status of `pending`.

<aside class="notice">
  You may only send value from addresses that you own.
</aside>
<aside class="notice">
  Adding the query string parameter <code>?commit=true</code> to this request will create and commit the transaction in a single step.
</aside>
<aside class="notice">
  If the deposit origin is a <code>CARD</code> account ID and the query string parameter <code>?commit=true</code> is set, you need to send the credit card's <code>securityCode</code> in the request body.
</aside>
<aside class="notice">
  When creating a transaction to an email address destination, a <code>ContactId</code> field can be added to specify the ID of the associated <a href="#contact-object">contact</a>, if one already exists.
  This is entirely optional, and does <b>not</b> remove the need to provide the actual email address in the <code>destination</code> field.
</aside>

### Request

`POST https://api.uphold.com/v0/me/cards/:card/transactions`

<aside class="notice">
  Requires any of the following scopes: <code>transactions:deposit</code>, <code>transactions:transfer:application</code>, <code>transactions:transfer:others</code>, <code>transactions:transfer:self</code> or <code>transactions:withdraw</code> for Uphold Connect applications.
  If creating with the query string parameter <code>?commit=true</code>, the scope has to match the type of transaction being committed.
</aside>

### Response

Returns a [Transaction Object](#transaction-object).

<aside class="notice">
  If the deposit origin is a <code>CARD</code> account ID and the query string parameter <code>?commit=true</code> is set,
  the transaction's <code>params</code> will include a <code>redirect</code> field with information of a redirect URI to be followed to complete the credit card deposit.
</aside>

### Step 2: Commit Transaction

Once a transaction has been created and a quote secured, commit the transaction using the previously returned `id`.
An optional parameter `message` can also be sent which will overwrite the value currently stored in the transaction.

Once the transaction is committed, its status will change to `processing`.

<aside class="notice">
  This must be done within the time window specified (in miliseconds) by the <a href="#parameters"><code>params.ttl</code></a> field of the transaction object.
  Attempting to commit a transaction past this timeframe results in a <a href="#errors">404 HTTP error</a>.
</aside>
<aside class="notice">
  If the <a href="#permissions"><code>transactions:commit:otp</code> permission</a> has been granted by the user, and an OTP is not provided with the request,
  you will get a <a href="#errors">401 HTTP error</a>, along with the HTTP header <code>OTP-Token: Required</code> and/or <code>OTP-Method-Id: Required</code>.
  In that case, re-send the request, including the OTP verification code and method id as headers, like so:
  <code>OTP-Token: &lt;OTP-Token&gt;</code> and <code>OTP-Method-Id: &lt;OTP-Method-Id&gt;</code>.
</aside>

### Request

`POST https://api.uphold.com/v0/me/cards/:card/transactions/:id/commit`

<aside class="notice">
  Requires any of the following scopes, based on the type of transaction being committed:
  <code>transactions:deposit</code>, <code>transactions:transfer:application</code>, <code>transactions:transfer:others</code>, <code>transactions:transfer:self</code> or <code>transactions:withdraw</code>
  for Uphold Connect applications.
</aside>
<aside class="notice">
  If the deposit origin is a <code>CARD</code> account ID, you need to send the credit card's <code>securityCode</code> in the request body.
</aside>
<aside class="notice">
  If the user has recently changed their password, they may be in a cool-down period where outbound transactions are not allowed, for security reasons.
  This results in a <a href="#errors">400 HTTP error</a>, with code <code>password_reset_restriction</code>.
  Your application must be prepared to handle this failure scenario.
</aside>

### Response

Returns a [Transaction Object](#transaction-object).

<aside class="notice">
  If the deposit origin is a <code>CARD</code> account ID, the transaction's <code>params</code> will include a <code>redirect</code> field with information of a redirect URI to be followed to complete the credit card deposit.
</aside>

## Specify destination currency

> Example of creating a EUR to BTC transaction denominated in USD (i.e. buying 10 USD worth of BTC with and EUR card), by using the address of a EUR card as the `origin` in the URL parameter, and the address of an BTC card in the `destination` field, in the body of the request:

```bash
curl https://api.uphold.com/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "denomination": { "amount": "10", "currency": "USD" }, "destination": "e9225c6a-48b6-4e2e-ba36-beffdb5eb54e" }'
```

> The response to the above request would look like the following JSON (truncated for conciseness):

```json
{
  "denomination": {
    "amount": "10.00",
    "currency": "USD",
    "pair": "USDEUR",
    "rate": "0.84452"
  },
  "destination": {
    "amount": "0.00075846",
    "base": "0.00076651",
    "CardId": "e9225c6a-48b6-4e2e-ba36-beffdb5eb54e",
    "commission": "0.00000805",
    "currency": "BTC",
    "fee": "0.00",
    "isMember": true,
    "node": {
      "id": "e9225c6a-48b6-4e2e-ba36-beffdb5eb54e",
      "type": "card",
      "user": {
        "id": "5a5bc3a3-d945-47ce-8984-a569dff282af"
      }
    },
    "rate": "0.00009071",
    "type": "card"
  },
  "origin": {
    "amount": "8.45",
    "base": "8.45",
    "CardId": "a6d35fcd-0ef3-41ed-acce-9c9d1dda6d57",
    "commission": "0.00",
    "currency": "EUR",
    "fee": "0.00",
    "isMember": true,
    "node": {
      "id": "a6d35fcd-0ef3-41ed-acce-9c9d1dda6d57",
      "type": "card",
      "user": {
        "id": "5a5bc3a3-d945-47ce-8984-a569dff282af"
      }
    },
    "rate": "11023.87858",
    "sources": [],
    "type": "card"
  }
}
```

By using a [card](#card-object) id as the destination of a transaction, it is possible to determine the destination currency, independently from the denomination.
For example, to convert 10 USD worth of EUR to BTC, one could create a transaction from an EUR card to a BTC card, and denominate it in USD. An example is shown to the side.

## Confirm a Credit Card Deposit

> Example of `redirect` found in `transaction.params` for credit card deposit responses:

```bash
"redirect":{
  "url":"https://test.ppipe.net/connectors/demo/simulator.link?ndcid=8a8294175d602369015d73bf009f1808_7cbc8f0f400b421ab5bab3a8570a3fdf&REMOTEADDRESS=10.71.36.31",
  "parameters":[
    {
      "name":"TermUrl",
      "value":"https://test.ppipe.net/connectors/asyncresponse_simulator;jsessionid=89C6327A4B2FE425A8C375CF1C474521.uat01-vm-con04?asyncsource=THREEDSECURE&ndcid=8a8294175d602369015d73bf009f1808_7cbc8f0f400b421ab5bab3a8570a3fdf"
    },
    {
      "name":"PaReq",
      "value":"IT8ubu+5z4YupUCOEHKsbiPep8UzIAcPKJEjpwGlzD8#KioqKioqKioqKioqMDAwMCMxMi41MCBFVVIj"
    },
    {
      "name":"connector",
      "value":"THREEDSECURE"
    },
    {
      "name":"MD",
      "value":"8ac7a49f6a268259016a26953eca1b87"
    }
  ]
}
```

> Example of a request for 3DSecure confirmation using the given `redirect` details:

```bash
-X POST 'https://test.ppipe.net/connectors/demo/simulator.link?ndcid=8a8294175d602369015d73bf009f1808_7cbc8f0f400b421ab5bab3a8570a3fdf&REMOTEADDRESS=10.71.36.31' \
-d 'MD=8ac7a49f6a268259016a26953eca1b87' \
-d 'TermUrl=https://test.ppipe.net/connectors/asyncresponse_simulator;jsessionid=89C6327A4B2FE425A8C375CF1C474521.uat01-vm-con04?asyncsource=THREEDSECURE&ndcid=8a8294175d602369015d73bf009f1808_7cbc8f0f400b421ab5bab3a8570a3fdf' \
-d 'PaReq=IT8ubu+5z4YupUCOEHKsbiPep8UzIAcPKJEjpwGlzD8#KioqKioqKioqKioqMDAwMCMxMi41MCBFVVIj' \
-d 'connector=THREEDSECURE'
```

When committing a transaction from a `CARD` account ID, the transaction's `params` will include a `redirect` field with information to be used to accept with 3DSecure and complete the credit card deposit.

The following table describes the data included in the returned `redirect` field:

Property   | Description
---------- | -----------------------------------------------------------------------------------------------------
parameters | List of objects with `name` and `value` properties to send to the 3DSecure confirmation request body.
url        | The URL of the 3DSecure confirmation request.

<aside class="notice">
  This feature requires approval from Uphold's compliance team.
  Partners using this feature must not store the provided <code>securityCode</code>, in compliance with PCI DSS standards.
</aside>

### Request

`POST <transaction.params.redirect.url>`

<aside class="notice">
  Requires passing in the request body the parameters found in <code>transaction.params.redirect.parameters</code> in the format <code>name=value</code>.
</aside>

### Response

A webpage for 3DSecure confirmation for the user to interact with.

## Beneficiary Information

As the cryptocurrency market grows and starts interacting more and more with the traditional finance world new rules are applied to the FinTech sector.
As such, under the regulatory action of The Financial Action Task Force [FATF](https://www.fatf-gafi.org/), we are required to comply with the [travel rule](https://www.fatf-gafi.org/media/fatf/documents/recommendations/RBA-VA-VASPs.pdf) which requires us to "obtain, hold, and transmit required originator and beneficiary information in order to identify and report suspicious transactions, monitor the availability of information, take freezing actions, and prohibit transactions with designated persons and entities."

> Example of a transaction creation payload including `beneficiary` and `purpose` fields:

```json
{
  "beneficiary": {
    "address": {
      "city": "Ryleighfort",
      "country": "US",
      "line1": "32167 Mohr Land",
      "state": "US-CA",
      "zipCode": "47890"
    },
    "name": "Han Solo",
    "relationship": "child"
  },
  "denomination": {
    "amount": "3000",
    "currency": "USD"
  },
  "destination": "invite-user@mail.com",
  "purpose": "donations"
}
```

Parameter | Required | Description
--------- | -------- | -----------
beneficiary | yes/no | The transaction beneficiary information. See [Beneficiary](#beneficiary). <br><br> <b>Required</b> for transfers to other users (invites included) and withdrawals above _$3000 USD_ (or _$1000 USD_, if the origin user is from Arizona, United States). <br><br>   <b>Note:</b> ACH withdrawals do <b>not require</b> the beneficiary information to be sent. We only support personal bank accounts therefore the beneficiary (ACH account holder) is assumed to be the Uphold user who added that account.
purpose | yes/no | The reason for the transaction. <br><br> <b>Required</b> for transactions in which the relationship is not set to `myself`.

### Beneficiary

This beneficiary field has the following properties:

Parameter | Required | Description
--------- | ----------- | -----------
address | yes/no | The transaction beneficiary address information. See [Address](#address). <br><br> <b>Required</b> for invites and external beneficiaries.
name | yes/no | The beneficiary full name. <br><br> <b>Required</b> for invites and external beneficiaries.
relationship | yes | Reflects the beneficiary's relationship to the transaction originator. <br><br> Possible values are `business`, `child`, `co_worker`, `friend`, `myself`, `parent`, `sibling`.

### Address

Property | Required | Description
-------- |--------- | -----------
city | yes | The beneficiary address city.
country | yes | The beneficiary address country.
line1 | yes | The beneficiary address line 1.
line2 | no | The beneficiary address line 2.
state | yes | The beneficiary address state.
zipCode | yes | The beneficiary address zip code.

### Beneficiary Requirements

To obtain the transaction beneficiary requirements (or validate the `beneficiary` object) use the `?validate=true` query parameter when creating the quote. This will generate a validation error if any required beneficiary information is missing. Otherwise, the transaction will fail at the commit step with a similar error message.

<aside class="notice">
  Please note that at this moment, even with the <code>validate=true</code> parameter, the validation is only performed if a <code>beneficiary</code> object is passed.
</aside>

> Example of including the beneficiary information when creating a quote, alongside the remaining transaction data:

```bash
curl 'https://api-sandbox.uphold.com/v0/me/cards/<card-id>/transactions' \
  -H 'Authorization: Bearer <bearer-token>' \
  -H 'Content-Type: application/json' \
  -d '{
    "beneficiary": {
      "address": {
        "city": "Ryleighfort",
        "country": "US",
        "line1": "32167 Mohr Land",
        "state": "US-CA",
        "zipCode": "47890"
      },
      "name": "Han Solo",
      "relationship": "child"
    },
    "denomination": {
      "amount": "3000",
      "currency": "USD"
    },
    "destination": "invite-user@mail.com",
    "purpose": "donations"
  }'
```

> Example of adding the beneficiary information when committing a quote:

```bash
curl 'https://api-sandbox.uphold.com/v0/me/cards/<card-id>/transactions/<transaction-id>/commit' \
  -H 'Authorization: Bearer <bearer-token>' \
  -H 'Content-Type: application/json' \
  -H 'OTP-Method-Id: <Method-Id>' \
  -H 'OTP-Token: <OTP-Token>' \
  -d '{
    "beneficiary": {
      "address": {
        "city": "Ryleighfort",
        "country": "US",
        "line1": "32167 Mohr Land",
        "state": "US-CA",
        "zipCode": "47890"
      },
      "name": "Han Solo",
      "relationship": "child"
    },
    "purpose": "donations"
  }'
```

> In both cases, incomplete beneficiary information will be reported in a format similar to this:

```json
{
  "code": "validation_failed",
  "errors": {
    "beneficiary": {
      "code": "validation_failed",
      "errors": {
        "name": [
          {
            "code": "required",
            "message": "This value is required"
          }
        ]
      }
    }
  }
}
```

> Invalid beneficiary information will be reported like this:

```json
{
  "code": "validation_failed",
  "errors": {
    "beneficiary": {
      "code": "validation_failed",
      "errors": {
        "name": [
          {
            "code": "invalid_beneficiary",
            "message": "The provided beneficiary is invalid"
          }
        ]
      }
    }
  }
}
```

<aside class="notice">
  For regulatory compliance reasons, the beneficiary name is checked by a sanctions screening process, and is expected to consist entirely of characters in the Latin, Cyrillic, Greek or Georgian alphabets, along with a limited set of special characters. These validations may result in an <code>invalid_beneficiary</code> error.
</aside>

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

<aside class="notice">
  Requires the <code>transactions:transfer:others</code> scope for Uphold Connect applications.
</aside>

### Response

Returns a [Transaction Object](#transaction-object).

<aside class="notice">
  Only transactions with status <code>waiting</code> can be cancelled.
</aside>

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

<aside class="notice">
  Requires the <code>transactions:transfer:others</code> scope for Uphold Connect applications.
</aside>

### Response

Returns a [Transaction Object](#transaction-object).

<aside class="notice">
  Only transactions with status <code>waiting</code> can be resent.
</aside>

## List User Transactions

```bash
curl https://api.uphold.com/v0/me/transactions \
  -X GET \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "application": null,
  "createdAt": "2018-08-01T09:53:47.020Z",
  "denomination": {
    "amount": "5.00",
    "currency": "GBP",
    "pair": "GBPUSD",
    "rate": "1.31"
  },
  "destination": {
    "CardId": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3",
    "amount": "5.57",
    "base": "5.61",
    "commission": "0.04",
    "currency": "EUR",
    "description": "Angel Rath",
    "fee": "0.00",
    "isMember": true,
    "node": {
      "id": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3",
      "type": "card",
      "user": {
        "id": "21e65c4d-55e4-41be-97a1-ff38d8f3d945"
      }
    },
    "rate": "0.85620",
    "type": "card"
  },
  "fees": [{
    "amount": "0.04",
    "currency": "EUR",
    "percentage": "0.65",
    "target": "destination",
    "type": "exchange"
  }],
  "id": "2c326b15-7106-48be-a326-06f19e69746b",
  "message": null,
  "network": "uphold",
  "normalized": [{
    "amount": "6.56",
    "commission": "0.05",
    "currency": "USD",
    "fee": "0.00",
    "rate": "1.00000",
    "target": "destination"
  }],
  "origin": {
    "CardId": "48ce2ac5-c038-4426-b2f8-a2bdbcc93053",
    "amount": "6.56",
    "base": "6.56",
    "commission": "0.00",
    "currency": "USD",
    "description": "Angel Rath",
    "fee": "0.00",
    "isMember": true,
    "node": {
      "id": "48ce2ac5-c038-4426-b2f8-a2bdbcc93053",
      "type": "card",
      "user": {
        "id": "21e65c4d-55e4-41be-97a1-ff38d8f3d945"
      }
    },
    "rate": "1.16795",
    "sources": [{
      "amount": "6.56",
      "id": "3db4ef24-c529-421f-8e8f-eb9da1b9a582"
    }],
    "type": "card"
  },
  "params": {
    "currency": "USD",
    "margin": "0.65",
    "pair": "EURUSD",
    "progress": "1",
    "rate": "1.16795",
    "ttl": 18000,
    "type": "transfer"
  },
  "priority": "normal",
  "reference": null,
  "status": "completed",
  "type": "transfer"
}]
```

Requests a list of committed transactions associated with the current user.

### Request

`GET https://api.uphold.com/v0/me/transactions`

<aside class="notice">
  Requires the <code>transactions:read</code> scope for Uphold Connect applications.
</aside>

This endpoint supports [Pagination](#pagination).

### Response

Returns an array of [Transaction Objects](#transaction-object).

## List Card Transactions

```bash
curl https://api.uphold.com/v0/me/cards/48ce2ac5-c038-4426-b2f8-a2bdbcc93053/transactions \
  -X GET \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "application": null,
  "createdAt": "2018-08-01T09:53:47.020Z",
  "denomination": {
    "amount": "5.00",
    "currency": "GBP",
    "pair": "GBPUSD",
    "rate": "1.31"
  },
  "destination": {
    "CardId": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3",
    "amount": "5.57",
    "base": "5.61",
    "commission": "0.04",
    "currency": "EUR",
    "description": "Angel Rath",
    "fee": "0.00",
    "isMember": true,
    "node": {
      "id": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3",
      "type": "card",
      "user": {
        "id": "21e65c4d-55e4-41be-97a1-ff38d8f3d945"
      }
    },
    "rate": "0.85620",
    "type": "card"
  },
  "fees": [{
    "amount": "0.04",
    "currency": "EUR",
    "percentage": "0.65",
    "target": "destination",
    "type": "exchange"
  }],
  "id": "2c326b15-7106-48be-a326-06f19e69746b",
  "message": null,
  "network": "uphold",
  "normalized": [{
    "amount": "6.56",
    "commission": "0.05",
    "currency": "USD",
    "fee": "0.00",
    "rate": "1.00000",
    "target": "destination"
  }],
  "origin": {
    "CardId": "48ce2ac5-c038-4426-b2f8-a2bdbcc93053",
    "amount": "6.56",
    "base": "6.56",
    "commission": "0.00",
    "currency": "USD",
    "description": "Angel Rath",
    "fee": "0.00",
    "isMember": true,
    "node": {
      "id": "48ce2ac5-c038-4426-b2f8-a2bdbcc93053",
      "type": "card",
      "user": {
        "id": "21e65c4d-55e4-41be-97a1-ff38d8f3d945"
      }
    },
    "rate": "1.16795",
    "sources": [{
      "amount": "6.56",
      "id": "3db4ef24-c529-421f-8e8f-eb9da1b9a582"
    }],
    "type": "card"
  },
  "params": {
    "currency": "USD",
    "margin": "0.65",
    "pair": "EURUSD",
    "progress": "1",
    "rate": "1.16795",
    "ttl": 18000,
    "type": "transfer"
  },
  "priority": "normal",
  "reference": null,
  "status": "completed",
  "type": "transfer"
}]
```

Retrieves a list of committed transactions associated with a specific card.

### Request

`GET https://api.uphold.com/v0/me/cards/:card/transactions`

<aside class="notice">
  Requires the <code>transactions:read</code> scope for Uphold Connect applications.
</aside>

This endpoint supports [Pagination](#pagination).

### Response

Returns an array of [Transaction Objects](#transaction-object).

## Get All Transactions (Public)

```bash
curl -X GET "https://api.uphold.com/v0/reserve/transactions"
```

> The above command returns the following JSON (truncated for brevity):

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
    "type": "card"
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
    "type": "card"
  }
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
    "type": "card"
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

To access this endpoint, an API key is required.

### Request

`GET https://api.uphold.com/v0/reserve/transactions`

This endpoint supports [Pagination](#pagination).

### Response

Returns an array of [Transaction Objects](#transaction-object).

<aside class="notice">
  Be advised that this method can potentially return a large amount of data.
</aside>

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

<aside class="notice">
  Note that you will only receive the list of committed transactions.
</aside>

## Transaction Limit Errors

> Example of a transaction that fails due to insufficient funds in the origin card:

```bash
curl 'https://api.uphold.com/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions?commit=true' \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "denomination": { "amount": "1000", "currency": "EUR" }, "destination": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3" }'
```

> The above command returns the following JSON:

```json
{
  "code": "validation_failed",
  "errors": {
    "denomination": {
      "code": "validation_failed",
      "errors": {
        "amount": [
          {
            "code": "sufficient_funds",
            "message": "Not enough funds for the specified amount"
          }
        ]
      }
    }
  }
}
```

> Example of a transaction that hits the maximum amount for the currency of the destination card:

```bash
curl 'https://api.uphold.com/v0/me/cards/a6d35fcd-xxxx-9c9d1dda6d57/transactions?commit=true' \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "denomination": { "amount": "1000", "currency": "BTC" }, "destination": "bc9b3911-4bc1-4c6d-ac05-0ae87dcfc9b3" }'
```

> The above command returns the following JSON (truncated for brevity):

```json
{
  "code": "validation_failed",
  "errors": {
    "destination": {
      "code": "validation_failed",
      "errors": {
        "amount": [
          {
            "code": "less_than_or_equal_to",
            "message": "This value should be less than or equal to 25",
            "args": {
              "threshold": "25"
            }
          }
        ]
      }
    }
  }
}
```

When committing a transaction you may bump into various limits, such as the minimum or maximum amount for a given currency, maximum cumulative daily/weekly amount, etc.
These are expressed as different errors, depending on the triggering conditions, as shown in the examples to the side;
but in general, in such cases you will get a [400 HTTP error](#errors), and the response will have the code `validation_failed` and an `errors` field with the details.

For an overview of the current limits for transactions, refer to
[this article in our FAQ](https://support.uphold.com/hc/en-us/articles/206118653-Account-funding-withdrawal-costs-and-limits).
Following the table in that page will allow you to validate transaction values on your side, before making API requests.
Besides the limits listed there, it's also recommended to preemptively [check a card's available balance](#get-card-details) to avoid hitting the "insufficient funds" error.

<aside class="notice">
  We currently do not expose an endpoint that lists all the limits that would apply for a given transaction.
  Your application should be prepared to handle these limit errors and forward the relevant information to the user so they can adjust the transaction properties accordingly.
</aside>
