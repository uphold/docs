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

> When the Travel Rule applies to a transaction created without `?commit=true`, the response also includes:

```json
{
  "requirements": [
    "user-subject-to-extended-travel-rule"
  ],
  "requirementsDetails": {
    "isAddressVerified": false,
    "isRequired": true,
    "requestForInformationId": "dbff3776-7528-450d-bc9f-e78ae3695949"
  }
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
- An optional denomination _target_ (`origin` or `destination`), determining which side of the transaction the denominated amount applies to:
  when set to `destination`, fees are added on top of the denominated amount, so that the destination receives that exact amount;
  when set to `origin`, fees are deducted from it instead.
  By default, the target is the `destination` when converting to a different currency while denominating in the destination currency, and the `origin` otherwise.
- The _origin_ of the transaction, which can be an account id in the case of a _deposit_.
- The _destination_ of the transaction, which can be in the form of a [crypto network address](#create-card-address), an email address, an account id, an application id, or a [card id](#card-object).
- An optional _message_, which is shown to the user to provide additional context.
- An optional _reference_ code, which can be used as a unique identifier of the transaction in an external system, or for similar purposes.
- An optional _priority_ for the transaction ("normal" or "fast", with the default being "normal"),
  to signal the intent to fast-track its completion in exchange for a higher fee.
  Notably, this enables instant withdrawals to US bank accounts via ACH; for withdrawals on the Dash network, it results in a higher network fee.

The following table describes the types of transactions currently supported:

Type       | Origin                                                                                            | Destination
---------- | ------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
deposit    | Bank account id (ACH, FPS or SEPA; SWIFT or WIRE for unlinked accounts) or credit card account id | Uphold card id
withdrawal | Uphold card id                                                                                    | Bank account id (ACH, FPS or SEPA; SWIFT or WIRE for unlinked accounts), credit/debit card account id, alternative payment method (e.g. Interac or Apple Pay), or cryptocurrency address
transfer   | Uphold card id                                                                                    | Email address, Application id or Uphold card id

Upon preparing a transaction, a [Transaction Object](#transaction-object) will be returned with a newly-generated `id`, and a status of `pending`.

<aside class="notice">
  You may only send value from addresses that you own.
</aside>
<aside class="notice">
  Adding the query string parameter <code>?commit=true</code> to this request will create and commit the transaction in a single step.
</aside>
<aside class="notice">
  If the deposit origin is a <code>CARD</code> account ID and the query string parameter <code>?commit=true</code> is set, the credit card's <code>securityCode</code> may be required in the request body.
  This API accepts it as an optional field, but the card gateway may still require it to process the deposit.
</aside>
<aside class="notice">
  <strong>Important Notice</strong>: In compliance with PCI standards, the Uphold Sandbox environment does not accept real credit/debit card data. For a list of accepted card data, please refer to the <a href="#adding-credit-debit-card-accounts">Adding credit/debit card accounts</a> section of the documentation.
</aside>

### Request

`POST https://api.uphold.com/v0/me/cards/:card/transactions`

<aside class="notice">
  Requires any of the following scopes: <code>transactions:transfer:application</code>, <code>transactions:transfer:others</code>, <code>transactions:transfer:self</code>, <code>transactions:withdraw</code> or <code>transactions:write</code> for Uphold Connect applications.
  If creating with the query string parameter <code>?commit=true</code>, the scope has to match the type of transaction being committed.
  Deposits additionally require the <code>transactions:deposit</code> scope, which is checked based on the type of transaction, after route authorization.
</aside>

### Response

Returns a [Transaction Object](#transaction-object), with HTTP status code `202` when the transaction is created without the query string parameter `?commit=true`, or `200` when it is created and committed in a single step.

<aside class="notice">
  If the deposit origin is a <code>CARD</code> account ID and the query string parameter <code>?commit=true</code> is set,
  the transaction's <code>params</code> will include a <code>redirect</code> field with information of a redirect URI to be followed to complete the credit card deposit.
</aside>
<aside class="notice">
  If the withdrawal is subject to the Travel Rule and the transaction is created without the query string parameter <code>?commit=true</code>, the response will include a <code>requirements</code> array and a <code>requirementsDetails</code> object with the <code>isAddressVerified</code>, <code>isRequired</code> and <code>requestForInformationId</code> fields, along with an optional <code>reason</code> explaining why the requirement applies.
  The travel rule information must be submitted via the <a href="#submit-travel-rule-information">Submit Travel Rule Information</a> endpoint before <a href="#step-2-commit-transaction">committing the transaction</a>.
</aside>

### Step 2: Commit Transaction

Once a transaction has been created and a quote secured, commit the transaction using the previously returned `id`.
The optional parameters `beneficiary`, `message`, `purpose` and `reference` can also be sent, which will overwrite the values currently stored in the transaction.

Once the transaction is committed, its status will change to `processing`.

<aside class="notice">
  This must be done within the time window specified (in milliseconds) by the <a href="#parameters"><code>params.ttl</code></a> field of the transaction object.
  Attempting to commit a transaction past this timeframe results in a <a href="#errors">404 HTTP error</a>.
</aside>
<aside class="notice">
  If the <a href="#permissions"><code>transactions:commit:otp</code> permission</a> has been granted by the user, and an OTP is not provided with the request,
  you will get a <a href="#errors">401 HTTP error</a>, along with the HTTP header <code>OTP-Token: required</code>.
  In that case, re-send the request, including the OTP verification code like so:
  <code>OTP-Token: &lt;OTP-Token&gt;</code>.
  Note that this OTP challenge can also occur at the create step, when using the query string parameter <code>?commit=true</code>.
</aside>

### Request

`POST https://api.uphold.com/v0/me/cards/:card/transactions/:id/commit`

<aside class="notice">
  Requires any of the following scopes, based on the type of transaction being committed:
  <code>transactions:transfer:application</code>, <code>transactions:transfer:others</code>, <code>transactions:transfer:self</code>, <code>transactions:withdraw</code> or <code>transactions:write</code>
  for Uphold Connect applications.
  Deposits additionally require the <code>transactions:deposit</code> scope, which is checked based on the type of transaction, after route authorization.
</aside>
<aside class="notice">
  If the deposit origin is a <code>CARD</code> account ID, the credit card's <code>securityCode</code> may be required in the request body.
  This API accepts it as an optional field, but the card gateway may still require it to process the deposit.
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

> Example of creating a EUR to BTC transaction denominated in USD (i.e. buying 10 USD worth of BTC with a EUR card), by using the address of a EUR card as the `origin` in the URL parameter, and the address of a BTC card in the `destination` field, in the body of the request:

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
    "CardId": "e9225c6a-48b6-4e2e-ba36-beffdb5eb54e",
    "amount": "0.00075846",
    "base": "0.00076651",
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
    "CardId": "a6d35fcd-0ef3-41ed-acce-9c9d1dda6d57",
    "amount": "8.45",
    "base": "8.45",
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
For example, to convert 10 USD worth of EUR to BTC, one could create a transaction from a EUR card to a BTC card, and denominate it in USD. An example is shown to the side.

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

For cryptocurrency withdrawals, the originator and beneficiary information is collected via the [Get Travel Rule Details](#get-travel-rule-details) and [Submit Travel Rule Information](#submit-travel-rule-information) endpoints.
Independently of that process, the following complementary fields can be sent when [creating](#step-1-create-transaction) or [committing](#step-2-commit-transaction) a transaction:

> Example of a transaction creation payload including `beneficiary` and `purpose` fields:

```json
{
  "beneficiary": {
    "relationship": "child"
  },
  "denomination": {
    "amount": "3000",
    "currency": "USD"
  },
  "destination": "1c857998-6ddf-4236-986b-71db03711bc9",
  "purpose": "donations"
}
```

Parameter   | Required | Description
----------- | -------- | -----------
beneficiary | no       | The transaction beneficiary information. See [Beneficiary](#beneficiary).
purpose     | no       | The reason for the transaction. It is ignored when the beneficiary `relationship` is set to `myself`.<br><br>For business relationships, the possible values are: `business_expenses`, `business_travel`, `consultancy_expenses`, `education_expenses`, `family_expenses`, `funding_investments`, `gift_or_donations`, `invoice_payment`, `loan_payment`, `personal_expenses`, `salary_payments`, `sale_of_nfts_or_return_of_credits`, and `technology_expenses`.<br><br>For personal relationships, the possible values are: `bill_payments`, `donations`, `expenses`, `gift`, `living_expenses`, `payment_for_goods_or_services`, and `supporting_family_internationally`.

### Beneficiary

This beneficiary field has the following properties:

Parameter    | Required    | Description
------------ | ----------- | -----------
email        | yes/no      | The beneficiary's email address. <br><br> <b>Required</b> for Interac withdrawals only.
name         | yes/no      | The beneficiary's full name. <br><br> <b>Required</b> for Interac withdrawals only; it is not stored for any other type of transaction.
relationship | yes         | Reflects the beneficiary's relationship to the transaction originator, as a free-form string of 1 to 255 characters. <br><br> Common values are `business`, `child`, `co_worker`, `friend`, `myself`, `parent`, `sibling`.

<aside class="notice">
  The beneficiary's <code>name</code> and <code>address</code> are not persisted with the transaction: only the <code>relationship</code> is kept. For Interac withdrawals, the <code>email</code> and <code>name</code> are kept instead.
  ACH withdrawals always record the beneficiary with <code>relationship</code> set to <code>myself</code>: we only support personal bank accounts, therefore the beneficiary (ACH account holder) is assumed to be the Uphold user who added that account.
</aside>

### Validating a Transaction

To validate a transaction without committing it, use the `?validate=true` query string parameter when [creating](#step-1-create-transaction) it.
This runs the generic quote validation, along with the scope and OTP checks that would otherwise be performed when committing the transaction, based on its type.

> Example of validating a quote with beneficiary information, using the `?validate=true` query string parameter:

```bash
curl 'https://api-sandbox.uphold.com/v0/me/cards/<card-id>/transactions?validate=true' \
  -H 'Authorization: Bearer <bearer-token>' \
  -H 'Content-Type: application/json' \
  -d '{
    "beneficiary": {
      "relationship": "child"
    },
    "denomination": {
      "amount": "3000",
      "currency": "USD"
    },
    "destination": "1c857998-6ddf-4236-986b-71db03711bc9",
    "purpose": "donations"
  }'
```

> Example of adding the beneficiary information when committing a quote:

```bash
curl 'https://api-sandbox.uphold.com/v0/me/cards/<card-id>/transactions/<transaction-id>/commit' \
  -H 'Authorization: Bearer <bearer-token>' \
  -H 'Content-Type: application/json' \
  -H 'OTP-Token: <OTP-Token>' \
  -d '{
    "beneficiary": {
      "relationship": "child"
    },
    "purpose": "donations"
  }'
```

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

You can filter the list of returned transactions using the `q` query string parameter. Supported filters are:

- `createdAt:`, which accepts the comparison operators `>`, `>=`, `<` and `<=` (e.g. `createdAt:>=2024-01-01`), as well as date ranges (e.g. `createdAt:2024-01-01..2024-03-31`).
- `origin.CardId:` and `destination.CardId:`, which accept a single card id or a comma-separated list of card ids.

Multiple filters can be used together, separated with a space.
The `origin.CardId:` and `destination.CardId:` filters can also be combined with the `OR` keyword, e.g. `origin.CardId:"<card-id>" OR destination.CardId:"<card-id>"`.

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
curl -X GET "https://api.uphold.com/v0/reserve/transactions" \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON (truncated for brevity):

```json
[{
  "application": null,
  "createdAt": "2014-09-25T19:19:51.201Z",
  "denomination": {
    "amount": "25.00",
    "currency": "USD"
  },
  "destination": {
    "amount": "0.02777777",
    "base": "0.02777777",
    "commission": "0.00",
    "currency": "BTC",
    "fee": "0.00",
    "rate": "0.00111111"
  },
  "fees": [{
    "amount": "0.00",
    "currency": "BTC",
    "percentage": "0.00",
    "target": "destination",
    "type": "exchange"
  }],
  "id": "63dc7ccb-0e57-400d-8ea7-7d903753801c",
  "origin": {
    "amount": "25.00",
    "base": "25.00",
    "commission": "0.00",
    "currency": "USD",
    "fee": "0.00",
    "rate": "900.00000",
    "sources": [{
      "amount": "25.00",
      "id": "4586e3f6-5fff-473f-b479-4e7ce2ba14cf"
    }]
  },
  "params": {
    "currency": "USD",
    "margin": "0.00",
    "pair": "BTCUSD",
    "rate": "900.00000"
  },
  "priority": "normal",
  "status": "completed",
  "type": "transfer"
},
{
  "application": null,
  "createdAt": "2016-01-19T12:07:01.611Z",
  "denomination": {
    "amount": "0.01",
    "currency": "BTC"
  },
  "destination": {
    "address": "n2eMqTT929pb1RDNuqEnxdaLau1rxy3efi",
    "amount": "0.01",
    "base": "0.01",
    "commission": "0.00",
    "currency": "BTC",
    "fee": "0.00",
    "rate": "1.00"
  },
  "fees": [{
    "amount": "0.0002",
    "currency": "BTC",
    "target": "origin",
    "type": "network"
  }, {
    "amount": "0.00",
    "currency": "BTC",
    "percentage": "0.5",
    "target": "origin",
    "type": "withdrawal"
  }],
  "id": "99191bf6-52d8-4f29-92e8-676b68c9a85b",
  "origin": {
    "amount": "0.0102",
    "base": "0.01",
    "commission": "0.00",
    "currency": "BTC",
    "fee": "0.0002",
    "rate": "1.00",
    "sources": [{
      "amount": "0.0102",
      "id": "390ed0ab-c014-43f3-868a-8ea3ea56025e"
    }]
  },
  "params": {
    "currency": "BTC",
    "margin": "0.00",
    "pair": "BTCBTC",
    "rate": "1.00"
  },
  "priority": "normal",
  "status": "completed",
  "type": "withdrawal"
}]
```

See also: [Transparency: Reservechain](#the-reservechain)

Requests the public view of all transactions in the reserve.

To access this endpoint, an OAuth access token obtained by a client with the `authorization_code` grant is required.

### Request

`GET https://api.uphold.com/v0/reserve/transactions`

<aside class="notice">
  Requires the <code>reserve:read</code> scope for Uphold Connect applications.
</aside>

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
    "currency": "USD"
  },
  "destination": {
    "amount": "1.00",
    "base": "1.00",
    "commission": "0.00",
    "currency": "USD",
    "fee": "0.00",
    "rate": "1.00"
  },
  "fees": [],
  "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634",
  "origin": {
    "amount": "1.00",
    "base": "1.00",
    "commission": "0.00",
    "currency": "USD",
    "fee": "0.00",
    "rate": "1.00",
    "sources": [{
      "amount": "1",
      "id": "35325c99-edeb-4625-9cd8-f56d4783c352"
    }]
  },
  "params": {
    "currency": "USD",
    "margin": "0.00",
    "pair": "USDUSD",
    "rate": "1.00"
  },
  "status": "cancelled",
  "type": "transfer"
}
```

See also: [Transparency: Reservechain](#the-reservechain)

Requests the public view of a specific transaction.

Unlike [Get All Transactions (Public)](#get-all-transactions-public), this endpoint requires no authentication.

### Request

`GET https://api.uphold.com/v0/reserve/transactions/:id`

### Response

Returns a [Transaction Object](#transaction-object).

<aside class="notice">
  Note that only committed transactions can be retrieved through this endpoint.
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
            "args": {
              "threshold": "25"
            },
            "code": "less_than_or_equal_to",
            "message": "This value should be less than or equal to 25"
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
