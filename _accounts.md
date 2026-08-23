# Accounts

Uphold allows users to deposit value into a specific card from an external source (ACH account, debit/credit card or wire transfer) or withdraw to an external source (ACH account or wire transfer).

Whenever a deposit is made into an Uphold card, it will be automatically converted into the value determined by the card's denomination.
Likewise, when a withdrawal is made, the currency will be converted to the currency of the destination account, thus minimizing fees and currency conversions.

Deposit and withdrawal support for the most common account types is as follows:

Account type | Deposits supported? | Withdrawals supported?
------------ | ------------------- | ----------------------
ach          | Yes                 | Yes
card         | Yes                 | No \*
sepa         | Yes                 | Yes

\* Push-to-card withdrawals via OCT settlement are available for eligible debit cards — see the [Approved cards](#approved-cards) section below.

Accounts of other types can also be returned by the API — namely `fps` bank accounts, `swift` and `wire` bank accounts, and `exchange` accounts.

Please refer to our FAQ for estimated [ACH transaction times](https://support.uphold.com/hc/en-us/articles/206762103-How-to-add-and-withdraw-funds-via-bank-transfer-U-S-), [SEPA transaction times](https://support.uphold.com/hc/en-us/articles/205803186-How-to-add-and-withdraw-funds-via-bank-transfer-Europe-), [fees and limits](https://support.uphold.com/hc/en-us/articles/360038404532).

## List Accounts

> The basic request to this endpoint lists all accounts for the current user:

```bash
curl https://api.uphold.com/v0/me/accounts \
  -H "Authorization: Bearer <token>"
```

> Example of filtering the list to show only accounts of the `sepa` or `card` types, and in the `ok` status:

```bash
curl 'https://api.uphold.com/v0/me/accounts?q=type:sepa,card%20status:ok' \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "bic": "CGDIPTPL",
  "billing": {},
  "currency": "EUR",
  "iban": "PT69003500001234567890112",
  "id": "18843b6d-5a43-480f-8e2b-73b27d726bf0",
  "label": "Checking Account",
  "provider": "uphold",
  "status": "ok",
  "type": "sepa"
},
{
  "billing": {
    "name": "Makenna Ortiz"
  },
  "brand": "visa",
  "cardNumberMasked": "1519",
  "currency": "USD",
  "expiryDate": "2027-12-31T23:59:59.999Z",
  "id": "0874745c-f0bf-4973-a3d9-9832aeaae087",
  "label": "Savings Account",
  "provider": "credit-card-gateway",
  "status": "ok",
  "type": "card"
}]
```

Retrieves a list of accounts for the current user.

### Request

`GET https://api.uphold.com/v0/me/accounts`

<aside class="notice">
  Requires the <code>accounts:read</code> scope for Uphold Connect applications.
</aside>

You can filter the list of returned accounts using the `q` query string parameter.
Supported filters are `status:` and `type:`, with either a single value or a comma-separated list.
Valid values for `status:` are `expired`, `failed`, `ok` and `pending`.
By default, only accounts with the `ok` status are returned.
Valid values for `type:` are `bank`, `card` and `exchange`, as well as the deprecated values `ach`, `fps` and `sepa`.
Note that `swift` and `wire` may appear as account types in responses, but are not valid values for the `type:` filter.
Multiple filters can be used together, separated with a space.
See the code to the right for an example.

### Response

Returns an array of the current user's accounts.

All accounts include the `provider` property.
Depending on the account type, additional properties are returned — e.g. `bic` and `iban` for `sepa` accounts, the masked account and routing numbers (`accountNumberMasked` and `routingNumberMasked`) for `ach` accounts, and `brand`, `cardNumberMasked` and `expiryDate` for `card` accounts.

## Get Account Details

```bash
curl https://api.uphold.com/v0/me/accounts/18843b6d-5a43-480f-8e2b-73b27d726bf0 \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "bic": "CGDIPTPL",
  "billing": {},
  "currency": "EUR",
  "iban": "PT69003500001234567890112",
  "id": "18843b6d-5a43-480f-8e2b-73b27d726bf0",
  "label": "Checking Account",
  "provider": "uphold",
  "status": "ok",
  "type": "sepa"
}
```

Retrieves the details about a specific account.

### Request

`GET https://api.uphold.com/v0/me/accounts/:id`

<aside class="notice">
  Requires the <code>accounts:read</code> scope for Uphold Connect applications.
</aside>
<aside class="notice">
  The account id must be owned by the user performing the API call.
</aside>

### Response

Returns a fully formed [Account Object](#account-object) representing the requested account.

## Adding credit/debit card accounts

The card details provided in this portion of the documentation are not real cards but specifically designed for Sandbox. These can be used to add card accounts to an Uphold wallet which will then allow for the testing of transactional flows.

<aside class="notice">
  Any value entered for <i>expiry date</i> and <i>CVV</i> will be accepted as valid when used in conjunction with the card data listed in this section.
</aside>

### Approved cards

The following is a list of valid card data that can be used to add a card account to an Uphold wallet for testing purposes.

<aside class="notice">
  Use of OCT settlement feature is only possible if the wallet account's country matches the card's country.
</aside>

Number           | Brand      | Type   | Country | OCT settlement |
---------------- | ---------- | ------ | ------- | -------------- |
4024007186645015 | visa       | credit | US      | N/A            |
4024764449971519 | visa       | debit  | US      | instant        |
4111111111111111 | visa       | debit  | PL      | N/A            |
4242424242424242 | visa       | credit | GB      | N/A            |
4243754271700719 | visa       | credit | US      | N/A            |
4447336775378848 | visa       | debit  | US      | N/A            |
4452927588210665 | visa       | credit | US      | N/A            |
4485040371536584 | visa       | credit | US      | N/A            |
4485597929486000 | visa       | credit | US      | N/A            |
4658584090000001 | visa       | debit  | GB      | N/A            |
4659105569051157 | visa       | debit  | GB      | instant        |
4659465888705671 | visa       | debit  | GB      | N/A            |
4757337282365488 | visa       | debit  | DE      | N/A            |
4921817844445119 | visa       | debit  | GB      | instant        |
5121073611487018 | mastercard | credit | US      | N/A            |
5259410220714099 | mastercard | credit | US      | N/A            |
5291144083573579 | mastercard | credit | US      | N/A            |
5318773012490080 | mastercard | debit  | US      | instant        |
5355223761921186 | mastercard | debit  | GB      | instant        |
5355224542121849 | mastercard | debit  | GB      | N/A            |
5385308360135181 | mastercard | credit | US      | N/A            |
5436031030606378 | mastercard | credit | MU      | N/A            |
5502514549870410 | mastercard | debit  | FR      | standard       |
5518832400606463 | mastercard | debit  | US      | N/A            |
5569757734785691 | mastercard | debit  | SG      | N/A            |
5573606426146833 | mastercard | debit  | GB      | instant        |
5574357535453624 | mastercard | debit  | GB      | N/A            |

### 3DS test cards

The following list contains data for 3DS-enabled cards and allows for forcing specific outcomes when testing both for the frictionless and the challenge flow.

Number           | Brand      | Type   | Country | 3DS flow            | Result                                    |
---------------- | ---------- | ------ | ------- | ------------------- | ----------------------------------------- |
5518832400606463 | mastercard | debit  | US      | 3DS2 challenge flow | authentication attempted                  |
5291144083573579 | mastercard | credit | US      | 3DS2 frictionless   | error message during scheme communication |
5121073611487018 | mastercard | credit | US      | 3DS2 frictionless   | no associated 3DS method url              |
5385308360135181 | mastercard | credit | US      | 3DS2 challenge flow | authentication successful                 |
5259410220714099 | mastercard | credit | US      | 3DS2 challenge flow | no associated 3DS method url              |
4242424242424242 | visa       | credit | GB      | 3DS2 challenge flow | authentication successful                 |
4485040371536584 | visa       | credit | US      | 3DS2 frictionless   | authentication successful                 |
4484070000035519 | visa       | credit | GB      | 3DS2 frictionless   | card not enrolled                         |
4556574722325580 | visa       | credit | PT      | 3DS2 frictionless   | authentication attempted                  |
4447336775378848 | visa       | debit  | US      | 3DS2 challenge flow | authentication could not be performed     |
4024007186645015 | visa       | credit | US      | 3DS2 frictionless   | authentication could not be performed     |
4452927588210665 | visa       | credit | US      | 3DS2 frictionless   | error message during scheme communication |
4243754271700719 | visa       | credit | US      | 3DS2 challenge flow | not authenticated                         |
4485597929486000 | visa       | credit | US      | 3DS2 challenge flow | no associated 3DS method url              |
