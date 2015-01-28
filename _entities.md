# Entities

## Card Object

> An example currency pair encoded in JSON looks like this:

```
{
  "id": "91380a1f-c6f1-4d81-a204-8b40538c1f0d",
  "address": {
    "bitcoin": "1KHpy2xrscep4RiXPiM3jyjee82iBMyMan"
  },
  "label": "BTC Card #2",
  "currency": "BTC",
  "balance": "0.00",
  "available": "0.00",
  "lastTransactionAt": "2014-07-07T05:40:46.624Z",
  "position": 7,
  "addresses": [
    {
      "id": "1KHpy2xrscep4RiXPiM3jyjee82iBMyMan",
      "network": "bitcoin"
    },
    {
      "id": "18yFebPW8USkoBtYXeV6quwgnPGEVyvpKi",
      "network": "bitcoin"
    }
  ]
}
```

Property | Description
--------- | -----------
id | A unique ID associated with the card.
address | A key/value pair representing the primary address for the card.
addresses | An associative array of all the known addresses associated with the card, including the primary card.
label | The display name of the card as chosen by the user.
currency | The currency by which the card is denominated.
balance | The total balance of the card, including all pending transactions.
available | The balance available for withdrawal/usage.
lastTransactionAt | A timestamp of the last time a transaction on this card was conducted.
position | The member’s preferred sort order for the card.

## Contact Object

> An example contact encoded in JSON looks like this:

```
{
  "id": "9fae84eb-712d-4b6a-9b2c-764bdde4c079",
  "firstName": "Han",
  "lastName": "Solo",
  "company": "Independent",
  "emails": [
    "han.solo@rebelalliance.org"
  ],
  "addresses": [],
  "name": "Han Solo"
}
```

Property | Description
--------- | -----------
id | A unique ID in the Bitreserve network identifying the contact.
firstName | The first name of this contact provided by the user.
lastName | The last name of this contact provided by the user.
company | The company of this contact provided by the user.
emails | An array of known email addresses associated with this contact.
address | An array of known addresses associated with this contact.
name | The display name of the contact created by joining the first and last names.

## Currency Pair Object

> An example currency pair encoded in JSON looks like this:

```
"BTCUSD": {
  "bid": "599.23",
  "ask": "600.99"
}
```

A currency pair is the combination of two currencies, encoded as two currency codes, e.g. USD, GBP, EUR, concatenated together to represent the current status of converting the first currency into the second. For example, the currency pair "BTCUSD" represents moving from bitcoin to US dollars.

Each currency pair has three properties:

Property | Description
--------- | -----------
bid | The current bid price, or the price we quote when buying the asset.
ask | The current ask price, or the price we quote when selling the asset.

## User Object

> An example user encoded in JSON looks like this:

```
{
  "username": "byrnereese",
  "email": "byrne@bitreserve.org",
  "firstName": "Byrne",
  "lastName": "Reese",
  "name": "Byrne Reese",
  "country": "US",
  "state": "CA",
  "currencies": [
    "BTC",
    "USD",
    "EUR",
    "GBP",
    "CNY",
    "JPY",
    "XAU"
  ],
  "status": {
    "email": "ok",
    "phone": "pending",
    "review": "pending",
    "volume": "ok",
    "identity": "pending",
    "overview": "pending",
    "screening": "pending",
    "registration": "running"
  },
  "settings": {
    "theme": "minimalistic",
    "currency": "USD",
    "hasNewsSubscription": "true",
    "intl": {
      "language": {
        "locale": "en-US"
      },
      "dateTimeFormat": {
        "locale": "en-US"
      },
      "numberFormat": {
        "locale": "en-US"
      }
    },
    "hasOtpEnabled": "false"
  },
  "phones":[
    {
      "id": "1d78aeb5-43ac-4ee8-8d28-1291b5d8355c",
      "verified": "true",
      "primary": "true",
      "e164Masked": "+XXXXXXXXX04",
      "nationalMasked": "(XXX) XXX-XX04",
      "internationalMasked": "+X XXX-XXX-XX04"
    }
  ],
  "balances": {
    "total": "1083.77",
    "currencies": {
      "CNY": {
        "amount": "6.98",
        "balance": "42.82",
        "currency": "USD",
        "rate": "6.13880"
      },
      "EUR": {
        "amount": "75.01",
        "balance": "58.05",
        "currency": "USD",
        "rate": "1.29220"
      }
    }
  },
  "cards": <snip>,
  "transactions": <snip>
}
```

The ```user``` object contains all information we have on record relating to the currently logged in user.

<aside class="notice">
Privacy Notice: Users are only permitted to access information about themselves. Our API does not allow accessing information about other users.
</aside>

### User Status

We communicate a number of different user states through our API. At a high-level accounts can be in one of four states:

* **pending** - This state is present while the user is creating an account
* **restricted** - When a user is in this state they are allowed to login to the application and receive money, but they are not permitted to initiate transactions. This states exists to allow members to satisfy additional data requirements.
* **blocked** - This state is present when a user has violated our terms of service. In this state users are unable to login or access the product.
* **ok** - Everything is ay-ok.

When members are in restricted or blocked state, the `flags` field can help communicate the reasons for account suspension. These flags, and their permissible values are:

Flag | Permissible Values | Description
-------- | ----------- | ---------
email | pending, ok | The status of email verification.
registration | pending, running, ok | Where a user is in the registration process.
phone | pending, running, ok | The status of phone number verification.
ofac | pending, ready, running, ok, failed | The status of whether a user has cleared [OFAC](http://en.wikipedia.org/wiki/Office_of_Foreign_Assets_Control) screening.
identity | pending, ready, running, ok, failed | The status of identity verification during membership application process.
verification | pending, ready, ok, failed | The status of user data verification.

## Transaction Object

> An example transaction encoded in JSON looks like this:

```
{
  "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634",
  "message": "",
  "type": "invite",
  "status": "waiting",
  "RefundedById": null,
  "createdAt": "2014-08-27T00:01:11.616Z",
  "denomination": {
    "rate": "1.00",
    "amount": "1.00",
    "currency": "USD"
  },
  "origin": {
    "address": "1GpBtJXXa1NdG94cYPGZTc3DfRY2P7EwzH",
    "base": "1.00",
    "commission": "0.00",
    "fee": "0.00",
    "amount": "1.00",
    "CardId": "ade869d8-7913-4f67-bb4d-72719f0a2be0",
    "currency": "USD",
    "description": "Luke Skywalker",
    "rate": "1.00",
    "sources": [
      {
        "id": "35325c99-edeb-4625-9cd8-f56d4783c352",
        "amount": "1"
      }
    ],
    "type": "card"
  },
  "destination": {
    "address": "1PtbHc2C3DHQmTRMxMd1DJgH7AKubjhbip",
    "base": "1.00",
    "commission": "0.00",
    "fee": "0.00",
    "amount": "1.00",
    "CardId": "e3bc8674-f647-42f1-91b5-0395458ee81c",
    "currency": "USD",
    "description": "leia.organa@senate.coruscant.gov",
    "rate": "1.00",
    "type": "email"
  },
  "params": {
    "pair": "USDUSD",
    "margin": "0.00",
    "currency": "USD",
    "rate": "1.00",
    "progress": "0",
    "ttl": 30000
  }
}
```

Transactions record the movement of value into, within and out of the Bitreserve network. Transactions have the following properties:

<aside class="notice">
There are two views of a transaction: public and private. The private view of information only privy to those who were a party to the transaction. Public views suppress and hide any private or personally identifiable information in order for Bitreserve to protect user privacy.
</aside>

Property | Description
--------- | -----------
id | A unique ID on the Bitreserve Network associated with the transaction.
message | A message or note provided by the user at the time the transaction was initiated, with the intent of communicating additional information and context about the nature/purpose of the transaction.
status | The current status of the transaction. Possible values are: `pending`, `waiting`, `cancelled` or `completed`.
type | The nature of the transaction. Possible values are `invite`, `transfer`, `external/out`, `internal`, and `external/in`.
RefundedById | When a transaction is cancelled, specifically a transaction in which money is sent to an email address, this contains the transaction ID of the transaction which refunds the amount back to the user.
createdAt | The date and time the transaction was initiated.
denomination | The funds to be transfered, as originally requested. See "Denomination" below.
origin | The sender of the funds. See "Origin and Destination" below.
destination | The recipient of the funds. See "Origin and Destination" below.
params | Other parameters of this transaction.

<aside class="notice">
A transaction can involve 3 different currencies: the currency as **denominated** by the user, the currency at the **origin** card and the currency at the **destination** card. For instance, _"transfer 1 BTC from my USD card to my EUR card"_. In this case, 1 BTC would be the denominated amount, but the equivalent in USD is credited at the origin, then debited in EUR at the destination.
</aside>

### Denomination

The actual value being transacted is denominated in a certain currency, as expressed by the ```denomination``` field with the following properties:

Property | Description
--------- | -----------
amount | The amount to be transacted.
currency | The currency for said amount.
rate | The quoted rate for converting between the denominated currency and the currency at ```origin```.

<aside class="notice">
If the ```denomination``` and ```origin``` are the same currency, the ```rate``` will be '1.00'.
</aside>

### Origin
The origin has properties regarding how the transaction affects the account at origin of the funds:

Property | Description
--------- | -----------
address | The address from which funds were taken.
base | The amount to debit the origin account, before commissions or fees.
commission | The commission charged by Bitreserve to process the transaction.
fee | The Bitcoin network Fee, if origin is in BTC but destination is not, or is a non-Bitreserve Bitcoin Address.
amount | The amount debited to the origin account, including commissions and fees.
CardId | The ID of the card debited. Only visible to the user who sends the transaction.
currency | The currency of the funds at the origin acount.
description | The name of the sender.
rate | The rate for conversion between origin and destination, as expressed in the currency at origin (the inverse of ```destination.rate```).
type | The type of endpoint. Possible values are 'card' and 'external'

<aside class="notice">
Commissions are incurred only when a currency conversion is required. A commission is charged at origin when the denomination currency is different from the origin currency, and it's deducted at destination when the denomination currency is different from the destination currency.
</aside>


### Destination
The destination of a transaction has its own set of properties describing how the destination account is affected, which include:

Property | Description
--------- | -----------
address | The address to which funds were directed.
base | The amount to credit the destination account, before commissions or fees.
commission | The commission charged by Bitreserve to process the transaction. Commissions are only charged when currency is converted into a different denomination.
fee | The Bitcoin network Fee, if destination is a BTC account but origin is not.
amount | The amount credited to the destination account, including commissions and fees.
CardId | The ID of the card credited. Only visible to the user who receives the transaction.
currency | The denomination of the funds at the time they were sent/received.
description | The name of the recipient. In the case where money is sent via email, the description will contain the email address of the recipient.
rate | The rate for conversion between origin and destination, as expressed in the currency at destination (the inverse of ```origin.rate```).
type | The type of endpoint. Possible values are 'email', 'card' and 'external'.


### Parameters

The `params` property associated with a transaction records additional meta data relating to the respective transaction. It contains the following properties:

Property | Description
--------- | -----------
pair | The currency pair associated with any exchange that took place, if any.
margin | Bitreserve's commission expressed in percentage.
commission | The total commission taken on this transaction, either at origin or at destination.
currency | The currency in which the total commission is expressed.
rate | The exchange rate for this pair.
progress | In case a transaction is coming in from the outside, how many confirmations have been received.
ttl | The time this quote is good for, in milliseconds (`[0-30000]`).
