# Vouchers

<aside class="warning">The Voucher API is currently in private beta, and requires configuration to use. Please <a href="mailto:partners@uphold.com?subject=I am interested in the Voucher Program">contact us</a> to learn more.</aside>

Uphold Vouchers provide partners with the ability to generate and/or redeem remittances. Vouchers are unique in the Uphold network in that they enable members to send money to someone outside the Uphold network, without requiring the recipient to open an Uphold account to claim the money. 

To conduct a remittance, a voucher is first "issued" by a partner in the network. When a voucher is issued, a source of funds (an Uphold card), an amount, and information about the beneficiary is collected. The network then issues a voucher code, or an MTCN in Western Union parlance, that is sent to the beneficiary. The voucher code will be used by the beneficiary to claim the money sent to them.

Vouchers are claimed, or "redeemed," via an authorized partner who has also implemented the Voucher API. The beneficiary presents the voucher code to the partner, who then is responsible for verifying that the person claiming the money is also the intended beneficiary. If the remittance is valid, and the money is released to the partner to be paid out in accordance with the terms of their service.

## Voucher Setup

To begin, partners need to engage with their Uphold account executive to define and negotiate the parameters of their voucher program. Partners also need to provide us with the necessary assets (logo, service description, etc) to help our members discover and learn more about the partner’s service and voucher program. A voucher program can be customized using the following parameters (please see Voucher API documentation for authoritative list of all parameters).

Property | Description
-------- | -----------------------------------------------------------------------
prefix | (4 characters) Each voucher has a unique prefix that creates a recognizable namespace for the voucher and will be composed of alphabetic characters, with the exception of I (uppercase “i”), O (capital “o”), 0 (zero) and 1 (one) to avoid potential confusion.
name | (string) A display name for the voucher program that may appear to third parties. 
description | (string) A description for the voucher program that may appear to third parties. 
logo | (URL) The URL to an image (dimensions TBD) that can be displayed alongside a voucher inside the Uphold wallet. 
revert period | A duration of time during which you can revert a voucher upon it being redeemed. Upon a voucher being redeemed it will be placed in a state of “processing” until this time period has elapsed. While in a state of “processing” the voucher can be reversed, and no funds will change hands. Example values: “10 minutes,” “1 day,” “100 seconds” etc.
currency | ( USD | MXN | EUR | etc ) The currency the resulting voucher will be forcibly issued in. The default behavior, when left unspecified, is to defer to the runtime denomination. 
minimum | To help curb abuse, a minimum value can be required for all vouchers issued under this program. 
maximum | To help curb abuse, a maximum value can be enforced for all vouchers issued under this program. 
expiration | (duration in days) The duration for which a voucher issued in this program will be valid. Upon expiration, the voucher will be set to a state of “expired” and the funds returned to the sender along with all appropriate fees.
issuer commission | The fee that will be added to the cost of generating a voucher, and will be delivered to the partner issuing the voucher.
redeemer fee | Added to the cost of generating a voucher, and that will be delivered to the partner processing the Redemption of the voucher.
platform fee | Added to the cost of generating a voucher, and retained by Uphold. 

## Voucher Fees

Voucher programs are able to assess fees to three different parties. They are:

* **Issuers** - the partner responsible for generating the voucher. This fee provides the program manager with a way of creating incentives for third parties to issue vouchers. It can be thought of as a “commission.” 
* **Platform/Remitter** - Uphold may assess a platform fee for supporting vouchers within a program. This fee will be agreed upon by the program manager and Uphold. 
* **Redeemer** - the partner responsible for redeeming a voucher and/or paying out the value of the voucher to the beneficiary. This is typically the program manager. 

All fees are additive. Therefore, if a member issues a $100 voucher in which there is a $1 issuer, platform and redeemer fee, then the total cost assessed to the member generating the voucher will be $103. 

Upon redemption, the principal amount of $100 will be delivered to the redeemer immediately. Then within the first week of the next month, the fees that were collected will be delivered to the issuer and redeemer as appropriate.

## List Vouchers

```bash
curl "https://api.uphold.com/v0/vouchers" \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[
  {
    "amount": "<Amount>",
    "beneficiary": {
      "country": "<Country>",
      "lastName": "<LastName>",
      "firstName": "<FirstName>"
    },
    "code": "<VoucherCode>",
    "currency": "<Currency>",
    "id": "<VoucherID>",
    "receiver": {},
    "sender": {
      "state": "<SenderState>",
      "country": "<SenderCountry>",
      "lastName": "<SenderLastName>",
      "firstName": "<SenderFirstName>"
    },
    "status": "<Status>"
  }
]
```

### Request

`GET https://api.uphold.com/v0/vouchers`

Parameter | Description
--------- | ----------------------------------------------------------------------------------------------------
status    | Voucher status
from  | A start date by which to constrain the query. 
to  | An end date by which to constrain the query.

### Response

Returns an array of <a href="#voucher-object">Voucher Objects</a> that the partner has access to. 

## Lookup a Voucher

```bash
curl "https://api.uphold.com/v0/vouchers/UH123456789" \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "amount": "<Amount>",
  "beneficiary": {
    "country": "<Country>",
    "lastName": "<LastName>",
    "firstName": "<FirstName>"
  },
  "code": "<VoucherCode>",
  "currency": "<Currency>",
  "id": "<VoucherId>",
  "receiver": {},
  "sender": {
    "state": "<SenderState>",
    "country": "<SenderCountry>",
    "lastName": "<SenderLastName>",
    "firstName": "<SenderFisrtName>"
  },
  "status": "<VoucherStatus>"
}
```

### Request

`GET https://api.uphold.com/v0/vouchers/:voucher_code`

### Response 

Returns a single <a href="#voucher-object">Voucher Object</a> corresponding to the supplied voucher code if one could be found. 

## Redeem a Voucher

```bash
curl "https://api.uphold.com/v0/vouchers/UH123456789/redeem" \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "amount": "<Amount>",
  "beneficiary": {
    "country": "<Country>",
    "lastName": "<LastName>",
    "firstName": "<FirstName>"
  },
  "code": "<VoucherCode>",
  "currency": "<Currency>",
  "id": "<VoucherId>",
  "receiver": {
    "state": "<ReceiverState>",
    "country": "<ReceiverCountry>",
    "lastName": "<ReceiverLastName>",
    "firstName": "<ReceiverFisrtName>"
  },
  "sender": {
    "state": "<SenderState>",
    "country": "<SenderCountry>",
    "lastName": "<SenderLastName>",
    "firstName": "<SenderFisrtName>"
  },
  "status": "<VoucherStatus>"
}
```

### Request

`POST https://api.uphold.com/v0/vouchers/:voucher_code/redeem`

This endpoint redeems a voucher. If a destination parameter is set, then the value of the voucher will be deposited to the corresponding card ID.

Parameter | Description
--------- | ----------------------------------------------------------------------------------------------------
reference | A reference ID provided by the redeeming agent for internal correlation purposes.
destination | The Card ID to which the value of the voucher will be delivered.
receiver | Information about the actual recipient of the voucher. 

### Response 

Returns a single <a href="#voucher-object">Voucher Object</a> corresponding to the supplied voucher code.

## Revert a Voucher

```bash
curl "https://api.uphold.com/v0/vouchers/UH123456789/revert" \
  -H "Authorization: Bearer <token>"
```

### Request

`POST https://api.uphold.com/v0/vouchers/:voucher_code/revert`

This endpoint reverses a voucher back to ready status, so that it can be redeemed again.

### Response 

Returns a single <a href="#voucher-object">Voucher Object</a> corresponding to the supplied voucher code.

## Issue a Voucher

### Request

`POST https://api.uphold.com/v0/me/vouchers`

This endpoint creates a new voucher by specifying the beneficiary and currency. Upon creating a voucher, a <a href="#voucher-object">Voucher Object</a> will be returned with a newly-generated id and with a `status` set to `pending` and an `amount` of `0`.

<aside class="notice">Vouchers in this status don't show up in voucher lookups and can't be redeemed yet.</aside>

<aside class="notice">Requires the `vouchers:write` scope for Uphold Connect applications.</aside>

Parameter | Description
--------- | ----------------------------------------------------------------------------------------------------
VoucherProgramID | The ID of the voucher program through which this remittance will be redeemed. Each redemption agent has a unique voucher program ID. 
beneficiary | The intended beneficiary of the voucher, which should specify the country, state, first name and last name.
currency | The currency of the voucher.

## Fund a Voucher

```bash
curl "https://api.uphold.com/v0/me/cards/:card/transactions" \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "application": {
    "name": "<ApplicationName>"
  },
  "createdAt": "<DateCreatedAt>",
  "denomination": {
    "pair": "<CurrencyPair>",
    "rate": "<Rate>",
    "amount": "<Amount>",
    "currency": "<Currency>"
  },
  "fees": [],
  "id": "<VoucherId>",
  "message": null,
  "network": "uphold",
  "normalized": [
    {
      "amount": "<NormalizedAmount>",
      "commission": "<Comission>",
      "currency": "USD",
      "fee": "<Fee>",
      "rate": "<Rate>",
      "target": "origin"
    }
  ],
  "params": {
    "currency": "<Currency>",
    "margin": "<Margin>",
    "pair": "<CurrencyPair>",
    "progress": "<Progress>",
    "rate": "<Rate>",
    "ttl": 7000,
    "type": "transfer"
  },
  "status": "completed",
  "type": "transfer",
  "origin": {
    "amount": "<OriginAmount>",
    "base": "<OriginBaseAmount>",
    "CardId": "<OriginCardId>",
    "commission": "<Comission>",
    "currency": "<OriginCardCurrency>",
    "description": "<Description>",
    "fee": "<Fee>",
    "isMember": true,
    "rate": "<Rate>",
    "sources": [
      {
        "id": "<TransactionId>",
        "amount": "<Amount>"
      }
    ],
    "type": "<Type>",
    "username": "<Username>"
  },
  "destination": {
    "amount": "<DestinationAmount>",
    "base": "<DestinationBaseAmount>",
    "commission": "<DestinationComission>",
    "currency": "<DestinationCurrency>",
    "description": "<Description>",
    "fee": "<Fee>",
    "rate": "<Rate>",
    "type": "voucher"
  }
}
```

### Request

`GET https://api.uphold.com/v0/me/cards/:card_id/transactions`

Once a voucher has been created, fund it by creating and committing a transaction from one of your cards to the voucher, using the Voucher id returned after the Voucher creation. Please refer to Create & Commit a Transaction for further details on how to create and commit transactions.

Once the transaction to to the voucher has been committed, the voucher changes its `status` to `ready` and its `amount` to the specified in the transaction, denominated in the currency of the voucher. Vouchers with `status` "ready" will show up in Voucher Lookups and can be redeemed.

<aside class="notice">Requires any of the following scopes, based on the type of transaction being committed: transactions:deposit, transactions:transfer:application, transactions:transfer:others, transactions:transfer:self or transactions:withdraw for Uphold Connect applications.</aside>

<aside class="notice">
  Adding the query string parameter `?commit=true` to this request will create and commit the transaction in a single step.
</aside>

Parameter | Description
--------- | ----------------------------------------------------------------------------------------------------
denomination | The amount and currency to be funded into the voucher.
destination | The Voucher Id that was generated when you created the voucher.

### Response 

Returns a [Transaction Object](#transaction-object).

## Cancel a Voucher

```bash
curl "https://api.uphold.com/v0/me/cards/:card/transactions" \
  -H "Authorization: Bearer <token>"
```

### Request

`POST https://api.uphold.com/v0/me/vouchers/:voucher_code/cancel`

This endpoint cancels a voucher and set the status to ‘cancelled’ and the funds are returned to the card of the currency that the voucher was issued.

### Response 

Returns a single <a href="#voucher-object">Voucher Object</a> corresponding to the supplied voucher code.
