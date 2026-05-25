# Travel Rule

The Travel Rule is a regulatory requirement that mandates Virtual Asset Service Providers (VASPs) to collect and transmit originator and beneficiary information for cryptocurrency transfers above a certain threshold.
When a deposit or a withdrawal triggers this requirement, Uphold issues a request for information that must be fulfilled before the transfer can proceed.

There are two ways to retrieve the details of a travel rule request, depending on the context:

- **Deposits**: the transaction is already present and may have a pending travel rule request associated with it. Use [Get Travel Rule Details for a Transaction](#get-travel-rule-details-for-a-transaction) with the `transactionId` to retrieve those details.
- **Withdrawals**: when [creating a quote](#step-1-create-transaction), the transaction response may include a `requirementsDetails.requestForInformationId` if the Travel Rule applies. Use [Get Travel Rule Details](#get-travel-rule-details) with that ID to retrieve the details, then [Submit Travel Rule Information](#submit-travel-rule-information) before [committing the quote](#step-2-commit-transaction).

## Get Travel Rule Details for a Transaction

```bash
curl https://api.uphold.com/v0/me/travel-rule/transactions/2c326b15-7106-48be-a326-06f19e69746b/request \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "amount": "1500.00",
  "currency": "USDT",
  "formSchema": {
    "properties": {
      "beneficiaryAccountNumber": {
        "title": "Beneficiary account number",
        "type": "string"
      },
      "beneficiaryAddress": {
        "title": "Beneficiary address",
        "type": "string"
      },
      "beneficiaryCountry": {
        "title": "Beneficiary country",
        "type": "string"
      },
      "beneficiaryName": {
        "title": "Beneficiary name",
        "type": "string"
      }
    },
    "required": [
      "beneficiaryName",
      "beneficiaryAddress",
      "beneficiaryCountry",
      "beneficiaryAccountNumber"
    ],
    "type": "object"
  },
  "threshold": "1000.00"
}
```

Retrieves the details of the pending travel rule request associated with a deposit transaction, including the transaction amount, the applicable regulatory threshold, and the form schema describing the information that must be submitted.

### Request

`GET https://api.uphold.com/v0/me/travel-rule/transactions/:transactionId/request`

<aside class="notice">
  Requires the <code>transactions:read</code> scope for Uphold Connect applications. Returns a <a href="#errors">401 HTTP error</a> if the token is missing or invalid, or a <a href="#errors">403 HTTP error</a> if the required scope is not present.
</aside>
<aside class="notice">
  Returns a <a href="#errors">404 HTTP error</a> if no pending travel rule request is associated with the given transaction.
</aside>

### Response

Returns an object with the following properties:

Property      | Description
------------- | -----------
amount        | The transaction amount that triggered the travel rule requirement.
currency      | The currency of the transaction.
formSchema    | A JSON Schema object describing the fields the user must provide via the [Submit Travel Rule Information](#submit-travel-rule-information) endpoint.
threshold     | The regulatory threshold above which the travel rule applies, in the same currency as `amount`.

## Get Travel Rule Details

```bash
curl https://api.uphold.com/v0/me/travel-rule/requests/a4e5e6f7-1234-5678-abcd-ef0123456789 \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "amount": "1500.00",
  "currency": "USDT",
  "formSchema": {
    "properties": {
      "beneficiaryAccountNumber": {
        "title": "Beneficiary account number",
        "type": "string"
      },
      "beneficiaryAddress": {
        "title": "Beneficiary address",
        "type": "string"
      },
      "beneficiaryCountry": {
        "title": "Beneficiary country",
        "type": "string"
      },
      "beneficiaryName": {
        "title": "Beneficiary name",
        "type": "string"
      }
    },
    "required": [
      "beneficiaryName",
      "beneficiaryAddress",
      "beneficiaryCountry",
      "beneficiaryAccountNumber"
    ],
    "type": "object"
  },
  "threshold": "1000.00"
}
```

Retrieves the details of a pending travel rule request for a withdrawal, using the `requestForInformationId` returned as part of the quote response.

### Request

`GET https://api.uphold.com/v0/me/travel-rule/requests/:requestForInformationId`

<aside class="notice">
  Requires the <code>transactions:read</code> scope for Uphold Connect applications. Returns a <a href="#errors">401 HTTP error</a> if the token is missing or invalid, or a <a href="#errors">403 HTTP error</a> if the required scope is not present.
</aside>
<aside class="notice">
  The <code>:requestForInformationId</code> must be owned by the authenticated user. A <a href="#errors">404 HTTP error</a> is returned otherwise.
</aside>

### Response

Returns an object with the following properties:

Property      | Description
------------- | -----------
amount        | The transaction amount that triggered the travel rule requirement.
currency      | The currency of the transaction.
formSchema    | A JSON Schema object describing the fields the user must provide via the [Submit Travel Rule Information](#submit-travel-rule-information) endpoint.
threshold     | The regulatory threshold above which the travel rule applies, in the same currency as `amount`.

## Submit Travel Rule Information

```bash
curl https://api.uphold.com/v0/me/travel-rule/requests/a4e5e6f7-1234-5678-abcd-ef0123456789 \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "beneficiaryAccountNumber": "0x1234abcd", "beneficiaryAddress": "123 Main St", "beneficiaryCountry": "US", "beneficiaryName": "Jane Doe" }'
```

Submits the originator or beneficiary information required to fulfill a pending travel rule request.
The fields in the request body must conform to the `formSchema` returned by the [Get Travel Rule Details for a Transaction](#get-travel-rule-details-for-a-transaction) or [Get Travel Rule Details](#get-travel-rule-details) endpoints.
For withdrawals, this must be submitted before [committing the quote](#step-2-commit-transaction).

### Request

`POST https://api.uphold.com/v0/me/travel-rule/requests/:requestForInformationId`

<aside class="notice">
  Requires the <code>transactions:withdraw</code> scope for Uphold Connect applications. Returns a <a href="#errors">401 HTTP error</a> if the token is missing or invalid, or a <a href="#errors">403 HTTP error</a> if the required scope is not present.
</aside>
<aside class="notice">
  The <code>:requestForInformationId</code> must be owned by the authenticated user. A <a href="#errors">404 HTTP error</a> is returned otherwise.
</aside>

The request body must be a valid JSON object whose properties satisfy the `formSchema` associated with the given `requestForInformationId`.
A <a href="#errors">400 HTTP error</a> is returned if the request body is not a valid JSON object.

### Response

Returns HTTP status code `204` with an empty body upon success.
