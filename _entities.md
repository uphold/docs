# Entities
## Account Object
> An example account encoded in JSON looks like this:

```json
{
  "currency": "USD",
  "id": "bfef7422-9f3c-47e0-4d4b-569d92d29a5c",
  "label": "My Chase card",
  "status": "ok",
  "type": "card"
}
```

Property | Description
-------- | -----------------------------------------------------------------------
currency | The currency in which the account is denominated.
id       | A unique ID associated with the account.
label    | The display name of the account as chosen by the user.
status   | The current status of the account. Possible values are: `ok`, `failed`.
type     | The type of the account. Possible values are: `card`, `sepa`.

## Card Object
> An example card encoded in JSON looks like this:

```json
{
  "address": {
    "bitcoin": "muABokE5awaCFtHWiw68rKGuSViBKDXLmH"
  },
  "available": "87.52",
  "balance": "87.52",
  "currency": "EUR",
  "id": "c4a77706-7b3a-4b8b-968b-4190038d37e8",
  "label": "EUR card",
  "lastTransactionAt": "2015-06-03T12:25:21.809Z",
  "settings": {
    "position": 4,
    "starred": true
  },
  "addresses": [{
    "id": "muABokE5awaCFtHWiw68rKGuSViBKDXLmH",
    "network": "bitcoin"
  }],
  "normalized": [{
    "available": "99.04",
    "balance": "99.04",
    "currency": "USD"
  }]
}
```

Property          | Description
----------------- | ---------------------------------------------------------------------------------------------------------
address           | A key/value pair representing the primary address for the card.
available         | The balance available for withdrawal/usage.
balance           | The total balance of the card, including all pending transactions.
currency          | The currency by which the card is denominated.
id                | A unique ID associated with the card.
label             | The display name of the card as chosen by the user.
lastTransactionAt | A timestamp of the last time a transaction on this card was conducted.
settings          | Contains the card's current `position` and whether the card is `starred` or not.
addresses         | An associative array of all the known addresses associated with the card, including the primary card.
normalized        | Contains the normalized `available` and `balance` values in the currency set by the user in the settings.

## Contact Object
> An example contact encoded in JSON looks like this:

```json
{
  "addresses": [
    "mtRwYWGKe1hYqNJ5fSTogXWPnFxoQrPYo6"
  ],
  "company": "Independent",
  "emails": [
    "han.solo@rebelalliance.org"
  ],
  "firstName": "Han",
  "id": "c4db98e4-c9e1-46dc-a927-17a26fb9772c",
  "lastName": "Solo",
  "name": "Han Solo"
}
```

Property  | Description
--------- | ----------------------------------------------------------------------------
addresses | An array of known addresses associated with this contact.
company   | The company of this contact provided by the user.
emails    | An array of known email addresses associated with this contact.
firstName | The first name of this contact provided by the user.
id        | A unique ID in the Uphold network identifying the contact.
lastName  | The last name of this contact provided by the user.
name      | The display name of the contact created by joining the first and last names.

## Currency Pair Object
> An example currency pair encoded in JSON looks like this:

```json
{
  "ask": "225.76",
  "bid": "225.73",
  "currency": "USD",
  "pair": "BTCUSD"
}
```

A currency pair is the combination of two currencies, encoded as two currency codes, e.g. USD, GBP, EUR, concatenated together to represent the current status of converting the first currency into the second. For example, the currency pair "BTCUSD" represents moving from bitcoin to US dollars.

Each currency pair has four properties:

Property | Description
-------- | --------------------------------------------------------------------
ask      | The current ask price, or the price we quote when selling the asset.
bid      | The current bid price, or the price we quote when buying the asset.
currency | The currency that is used in the `ask` and `bid` prices.
pair     | The currency pair AB represents moving from A to B.

## Transaction Object
> An example transaction encoded in JSON looks like this:

```json
{
  "createdAt": "2015-06-04T11:43:30.645Z",
  "denomination": {
    "amount": "2.00",
    "currency": "USD",
    "pair": "USDUSD",
    "rate": "1.00"
  },
  "fees": [],
  "id": "c1c46ee8-b196-4e0f-96cd-76278707ea3c",
  "message": "Join Uphold!",
  "normalized": [{
    "amount": "2.00",
    "commission": "0.00",
    "currency": "USD",
    "rate": "1.00"
  }],
  "params": {
    "currency": "USD",
    "margin": "0.00",
    "pair": "USDUSD",
    "progress": "0",
    "rate": "1.00",
    "ttl": 7000,
    "type": "invite"
  },
  "status": "waiting",
  "type": "transfer",
  "origin": {
    "amount": "2.00",
    "base": "2.00",
    "CardId": "718c7c81-ae87-46b3-97d5-131b78d76f05",
    "commission": "0.00",
    "currency": "USD",
    "description": "John Smith",
    "fee": "0.00",
    "rate": "1.00",
    "sources": [{
      "id": "f66f0e7f-20a1-4983-8855-52b96cd57d31",
      "amount": "2.00"
    }],
    "type": "card",
    "username": "johnsmith"
  },
  "destination": {
    "amount": "2.00",
    "base": "2.00",
    "commission": "0.00",
    "currency": "USD",
    "description": "leia.organa@senate.coruscant.gov",
    "fee": "0.00",
    "rate": "1.00",
    "type": "email",
    "username": null
  }
}
```

Transactions record the movement of value into, within and out of the Uphold network. Transactions have the following properties:
<aside class="notice">
  There are two views of a transaction: public and private. The private view of information only privy to those who were a party to the transaction. Public views suppress and hide any private or personally identifiable information in order for Uphold to protect user privacy.
</aside>

Property     | Description
------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
id           | A unique ID on the Uphold Network associated with the transaction.
type         | The nature of the transaction. Possible values are `deposit`, `transfer` and `withdrawal`.
message      | A message or note provided by the user at the time the transaction was initiated, with the intent of communicating additional information and context about the nature/purpose of the transaction.
denomination | The funds to be transferred, as originally requested. See "Denomination" below.
fees         | The fees that were applied to the transaction.
status       | The current status of the transaction. Possible values are: `pending`, `waiting`, `cancelled` or `completed`.
params       | Other parameters of this transaction. See [Parameters](#parameters).
createdAt    | The date and time the transaction was initiated.
normalized   | The transaction details in USD. See [Normalized](#normalized).
origin       | The sender of the funds. See "Origin and Destination" below.
destination  | The recipient of the funds. See "Origin and Destination" below.

<aside class="notice">
  A transaction can involve 3 different currencies: the currency as <strong>denominated</strong> by the user, the currency at the <strong>origin</strong> card and the currency at the <strong>destination</strong> card. For instance, <i>"transfer 1 BTC from my USD card to my EUR card"</i>. In this case, 1 BTC would be the denominated amount, but the equivalent in USD is credited at the origin, then debited in EUR at the destination.
</aside>

### Denomination
The actual value being transacted is denominated in a certain currency, as expressed by the `denomination` field with the following properties:

Property | Description
-------- | ---------------------------------------------------------------------------------------------
amount   | The amount to be transacted.
currency | The currency for said amount.
pair     | The currency pair representing the denominated currency and the currency at `origin`.
rate     | The quoted rate for converting between the denominated currency and the currency at `origin`.

<aside class="notice">
  If the `denomination` and `origin` are the same currency, the `rate` will be '1.00'.
</aside>

### Fees
The `fees` property contains an array of fees that were applied to the transaction. Each object in the array contains the following properties:

Property | Description
-------- | ---------------------------------------------------------------------------------
amount   | The amount to be charged.
currency | The currency for said amount.
target   | Can be `origin` or `destination` and determines where the fee was applied.
type     | The type of fee. Can be one of: `deposit`, `exchange`, `network` or `withdrawal`.

<aside class="notice">
  <strong>Important Notice</strong>: For further information on our fees, please visit our FAQ: <a href="https://support.uphold.com/hc/en-us/articles/202342496-Is-Uphold-a-free-service-">Is Uphold a free service?</a>
</aside>

### Parameters
The `params` property associated with a transaction records additional meta data relating to the respective transaction. It contains the following properties:

Property | Description
-------- | -----------------------------------------------------------------------------------------------
currency | The currency in which the total commission is expressed.
margin   | Uphold's commission expressed in percentage.
pair     | The currency pair associated with any exchange that took place, if any.
progress | In case a transaction is coming in from the outside, how many confirmations have been received.
ttl      | The time this quote is good for, in milliseconds.

### Normalized
The `normalized` property contains the normalized amount and commission values in USD:

Property   | Description
---------- | -----------------------------------------------------------------------------------
amount     | The amount to be transacted.
commission | The total commission taken on this transaction, either at origin or at destination.
currency   | The currency in which the amount and commission are expressed. The value is always `USD`.
rate       | The exchange rate for this pair.

### Origin
The origin has properties regarding how the transaction affects the origin of the funds:

Property    | Description
----------- | -----------------------------------------------------------------------------------------------------------------------------------
CardId      | The ID of the card debited. Only visible to the user who sends the transaction.
amount      | The amount debited, including commissions and fees.
base        | The amount to debit, before commissions or fees.
commission  | The commission charged by Uphold to process the transaction.
currency    | The currency of the funds at the origin.
description | The name of the sender.
fee         | The Bitcoin network Fee, if origin is in BTC but destination is not, or is a non-Uphold Bitcoin Address.
rate        | The rate for conversion between origin and destination, as expressed in the currency at origin (the inverse of `destination.rate`).
sources     | The transactions where the value was originated from (id and amount).
type        | The type of endpoint. Possible values are 'card' and 'external'.
username    | The username from the user that performed the transaction.

<aside class="notice">
  Commissions are incurred only when a currency conversion is required. A commission is charged at origin when the denomination currency is different from the origin currency, and it's deducted at destination when the denomination currency is different from the destination currency.
</aside>

### Destination
The destination of a transaction has its own set of properties describing how the destination is affected, which include:

Property    | Description
----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------
CardId      | The ID of the card credited. Only visible to the user who receives the transaction.
amount      | The amount credited, including commissions and fees.
base        | The amount to credit, before commissions or fees.
commission  | The commission charged by Uphold to process the transaction. Commissions are only charged when currency is converted into a different denomination.
currency    | The denomination of the funds at the time they were sent/received.
description | The name of the recipient. In the case where money is sent via email, the description will contain the email address of the recipient.
fee         | The Bitcoin network Fee, if destination is a BTC address but origin is not.
rate        | The rate for conversion between origin and destination, as expressed in the currency at destination (the inverse of `origin.rate`).
type        | The type of endpoint. Possible values are 'email', 'card' and 'external'.

## User Object
> An example user encoded in JSON looks like this:

```json
{
  "address": {},
  "birthdate": "2014-08-27",
  "country": "US",
  "currencies": [
    "BTC",
    "CHF",
    "CNY",
    "EUR",
    "GBP",
    "INR",
    "JPY",
    "MXN",
    "USD",
    "XAG",
    "XAU",
    "XPD",
    "XPT"
  ],
  "email": "luke.skywalker@uphold.com",
  "firstName": "Luke",
  "identity": {},
  "lastName": "Skywalker",
  "name": "Luke Skywalker",
  "phones": [{
    "e164Masked": "+XXXXXXXXX54",
    "id": "03c46123-1f82-4bca-893d-d5de587c3135",
    "internationalMasked": "+X XXX-XXX-XX54",
    "nationalMasked": "(XXX) XXX-XX54",
    "primary": true,
    "verified": true
  }],
  "settings": {
    "currency": "USD",
    "hasNewsSubscription": true,
    "intl": {
      "dateTimeFormat": {
        "locale": "en-US"
      },
      "language": {
        "locale": "en-US"
      },
      "numberFormat": {
        "locale": "en-US"
      }
    },
    "otp": {
      "login": {
        "enabled": true
      },
      "transactions": {
        "send": {
          "enabled": true
        },
        "transfer": {
          "enabled": false
        },
        "withdraw": {
          "crypto": {
            "enabled": true
          }
        }
      }
    }
  },
  "memberAt": "2015-07-10T15:36:20.288Z",
  "state": "California",
  "status": "ok",
  "username": "skywalker",
  "verifications": {},
  "balances": {
    "total": "499.04",
    "currencies": {
      "BTC": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "440.49500"
      },
      "CHF": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "1.08085"
      },
      "CNY": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "0.16017"
      },
      "EUR": {
        "amount": "99.04",
        "balance": "87.52",
        "currency": "USD",
        "rate": "1.13165"
      },
      "GBP": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "1.52485"
      },
      "INR": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "0.01605"
      },
      "JPY": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "0.00837"
      },
      "MXN": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "0.06700"
      },
      "USD": {
        "amount": "400.00",
        "balance": "400.00",
        "currency": "USD",
        "rate": "1.00000"
      },
      "XAG": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "17.27900"
      },
      "XAU": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "1235.46975"
      },
      "XPD": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "772.33385"
      },
      "XPT": {
        "amount": "0.00",
        "balance": "0.00",
        "currency": "USD",
        "rate": "1232.91175"
      }
    }
  },
  "cards": <snip>
}
```

The `user` object contains all information we have on record relating to the currently logged in user.
<aside class="notice">
  <strong>Privacy Notice</strong>: Users are only permitted to access information about themselves. Our API does not allow accessing information about other users.
</aside>

Property | Description
-------- | ----------------------------------------------------
memberAt | The date when the user has become a verified member.

### User Settings

- **otp.login.enabled** - This will prompt the user to input an OTP token when creating an OAuth token.
- **otp.transactions.send.enabled** - This will prompt the user to input an OTP token when creating a transaction to another user.
- **otp.transactions.transfer.enabled** - This will prompt the user to input an OTP token when transacting between the user's own cards.
- **otp.transactions.withdraw.crypto.enabled** - This will prompt the user to input an OTP token when withdrawing to the bitcoin network.

### User Status
We communicate a number of different user states through our API. At a high-level users can be in one of four states:

- **pending** - This state is present while the user is creating an account.
- **restricted** - When a user is in this state they are allowed to login to the application and receive money, but they are not permitted to initiate transactions. This state exists to allow users to satisfy additional data requirements.
- **blocked** - This state is present when a user has violated our terms of service. In this state users are unable to login or access the product.
- **ok** - Everything is ay-ok.

When users are in a specific state, the `verifications` field can help communicate the reasons for account status and potential suspension. These verifications have permissible values and in some cases, an associated reason. Here is an overview of the verifications field:

Flag      | Permissible Values               | Reason         | Description
--------- | -------------------------------- | -------------- | --------------------------------------------------------------------------------------
birthdate | required                         | n/a            | Whether the user needs to provide his/her date of birth.
email     | unconfirmed                      | n/a            | Whether the user needs to confirm his/her email.
identity  | required, retry, review, running | n/a            | The status of identity verification during membership application process.
location  | required, blocked                | country, state | Whether the user has specified his/her location, which can be a blocked country/state.
phone     | required, unconfirmed            | n/a            | The status of phone number verification.
terms     | required                         | updated        | Whether the user has accepted the latest version of the terms of service.
