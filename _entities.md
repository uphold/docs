# Entities

## Account Object

> An example account encoded in JSON looks like this:

```json
{
  "billing": {
    "name": "Abigail Davis"
  },
  "brand": "visa",
  "currency": "USD",
  "id": "0874745c-f0bf-4973-a3d9-9832aeaae087",
  "label": "Savings Account",
  "status": "ok",
  "type": "card"
}
```

Property | Description
-------- | -----------------------------------------------------------------------
billing  | The relevant billing details associated with the account.
brand    | The brand of the account (if it is of type `card`).
currency | The currency in which the account is denominated.
id       | A unique ID associated with the account.
label    | The display name of the account as chosen by the user.
status   | The current status of the account. Possible values are `blocked`, `expired`, `failed`, `ok` and `pending`.
type     | The type of the account. Possible values are `ach`, `card` and `sepa`.

## Authentication Method Object

> An example authentication method encoded in JSON looks like this:

```json
{
  "default": false,
  "id": "3f8f8264-2f5e-4b2b-8333-473715ab039a",
  "label": "Authenticator TOTP",
  "type": "totp",
  "verified": true,
  "verifiedAt": "2019-02-11T14:31:48.485Z"
}
```

Property     | Description
------------ | -----------------------------------------------------------------------
default      | A boolean signalling whether or not the method is the default.
id           | A unique ID associated with the account.
label        | The display name of the authentication method.
type         | The type of authentication method. Possible values are `authy` and `totp`.
verified     | A boolean signalling whether or not the authentication method has been verified.
verifiedAt   | The date and time of verification of the authentication method.

## Card Object

> An example card encoded in JSON looks like this:

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
    "position": 2,
    "protected": false,
    "starred": true
  }
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
  "ask": "6420.05",
  "bid": "6419",
  "currency": "USD",
  "pair": "BTCUSD"
}
```

A currency pair is the combination of two currencies, encoded as two [currency codes](#currencies) concatenated together to represent the current status of converting the first currency into the second.
For example, the currency pair "BTCUSD" represents moving from bitcoin to US dollars.

Each currency pair has four properties:

Property | Description
-------- | --------------------------------------------------------------------
ask      | The current ask price, or the price we quote when selling the asset.
bid      | The current bid price, or the price we quote when buying the asset.
currency | The currency that is used in the `ask` and `bid` prices.
pair     | The currency pair AB represents moving from A to B.

## Phone Object

> An example phone encoded in JSON looks like this:

```json
{
  "e164Masked": "+XXXXXXXXX04",
  "id": "1d78aeb5-43ac-4ee8-8d28-1291b5d8355c",
  "internationalMasked": "+X XXX-XXX-XX04",
  "nationalMasked": "(XXX) XXX-XX04",
  "primary": true,
  "verified": true
}
```

Property            | Description
------------------- | ---------------------------------------------------------------------------------------------------------
e164Masked          | The masked representation of the phone number in the [E.164 format](https://en.wikipedia.org/wiki/E.164).
id                  | A unique ID in the Uphold platform identifying the phone.
internationalMasked | The masked representation of the phone number in international format.
nationalMasked      | The masked representation of the phone number in national format.
primary             | A boolean indicating if this phone number is the user's primary phone number.
verified            | A boolean indicating if this phone number has been verified.

<aside class="notice">
  For more information about the specifics of the "international" and "national" phone number formats, refer to the
  <a href="https://github.com/google/libphonenumber/blob/master/javascript/i18n/phonenumbers/phonenumberutil.js#L885-L894">implementation</a>
  of the <code>google-libphonenumber</code> package.
</aside>

## Transaction Object

> An example transaction encoded in JSON looks like this:

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

Transactions record the movement of value into, within and out of the Uphold network.
Transactions have the following properties:

<aside class="notice">
  There are two views of a transaction: public and private.
  The private view of information only privy to those who were a party to the transaction.
  Public views suppress and hide any private or personally identifiable information in order for Uphold to protect user privacy.
</aside>

Property     | Description
------------ | -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
application  | The application that created the transaction.
id           | A unique ID on the Uphold Network associated with the transaction.
type         | The nature of the transaction. Possible values are `deposit`, `transfer` and `withdrawal`.
message      | An optional note added when initiating the transaction. Expected to be human-readable prose, e.g. for providing additional information and context about the nature/purpose of the transaction.
denomination | The funds to be transferred, as originally requested. See [Denomination](#denomination).
fees         | The fees that were applied to the transaction. See [Fees](#fees).
status       | The current status of the transaction. Possible values are `pending`, `processing`, `waiting`, `cancelled`, `failed` and `completed`.
params       | Other parameters of this transaction. See [Parameters](#parameters).
createdAt    | The date and time the transaction was initiated.
network      | The network of the transaction (`uphold` for internal transactions).
normalized   | The transaction details in USD. See [Normalized](#normalized).
priority     | The priority of the transaction. Possible values are `normal` and `fast`.
reference    | A reference code assigned to the transaction. Can be any string, up to 100 characters. This is not exposed to the user; a possible use case is to reference an external ID in another system.
origin       | The sender of the funds. See [Origin](#origin).
destination  | The recipient of the funds. See [Destination](#destination).

<aside class="notice">
  A transaction can involve 3 different currencies: the currency as <strong>denominated</strong> by the user, the currency at the <strong>origin</strong> card and the currency at the <strong>destination</strong> card. For instance, <i>"transfer 1 BTC from my USD card to my EUR card"</i>. In this case, 1 BTC would be the denominated amount, but the equivalent in USD is debited at the origin, then credited in EUR at the destination.
</aside>

### Denomination

The actual value being transacted is denominated in a certain currency, as expressed by the `denomination` field with the following properties:

Property | Description
-------- | ---------------------------------------------------------------------------------------------
amount   | The amount to be transacted.
currency | The currency for said amount.
pair     | The [currency pair](#currency-pair-object) representing the denominated currency and the currency at `origin`.
rate     | The quoted rate for converting between the denominated currency and the currency at `origin`.

<aside class="notice">
  If the <code>denomination</code> and <code>origin</code> are the same currency, the <code>rate</code> will be '1.00'.
</aside>

### Fees

The `fees` property contains an array of fees that were applied to the transaction.
Each object in the array contains the following properties:

Property   | Description
---------- | ---------------------------------------------------------------------------------
amount     | The amount to be charged.
currency   | The currency for said amount.
percentage | The percentage amount to be charged.
target     | Can be `origin` or `destination` and determines where the fee was applied.
type       | The type of fee. Can be one of: `deposit`, `exchange`, `network` or `withdrawal`.

<aside class="notice">
  <strong>Important Notice</strong>: For further information on our fees, please visit our FAQ: <a href="https://support.uphold.com/hc/en-us/articles/202342496-Is-Uphold-a-free-service-">Is Uphold a free service?</a>
</aside>

### Parameters

The `params` property associated with a transaction records additional meta data relating to the respective transaction. It contains the following properties:

Property | Description
-------- | -----------------------------------------------------------------------------------------------
currency | The currency in which the total commission is expressed.
margin   | Uphold's commission expressed in percentage.
pair     | The [currency pair](#currency-pair-object) associated with any exchange that took place, if any.
progress | In case a transaction is coming in from the outside, how many confirmations have been received.
rate     | The exchange rate of the transaction.
ttl      | The time this quote is good for, in milliseconds.
type     | The type of the transaction. Possible values are `deposit`, `transfer` and `withdrawal`.

### Normalized

The `normalized` property contains the normalized amount and commission values in USD:

Property   | Description
---------- | -----------------------------------------------------------------------------------
amount     | The amount to be transacted.
commission | The total commission taken on this transaction, either at origin or at destination.
currency   | The currency in which the amount and commission are expressed. The value is always `USD`.
fee        | The normalized fee amount.
rate       | The exchange rate for this [currency pair](#currency-pair-object).
target     | Can be `origin` or `destination` and determines where the fee was applied.

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
isMember    | A boolean signaling if the origin user has completed the membership process.
node        | The details about the transaction origin node.
rate        | The rate for conversion between origin and destination, as expressed in the currency at origin (the inverse of `destination.rate`).
sources     | The transactions where the value was originated from (id and amount).
type        | The type of endpoint. Possible values are `card` and `external`.

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
isMember    | A boolean signaling if the destination user has completed the membership process.
node        | The details about the transaction destination node.
rate        | The rate for conversion between origin and destination, as expressed in the currency at destination (the inverse of `origin.rate`).
type        | The type of endpoint. Possible values are `email`, `card` and `external`.

## User Object

> An example user encoded in JSON looks like this:

```json
{
  "address": {
    "city": "Ryleighfort",
    "line1": "32167 Mohr Land",
    "line2": "Suite 257",
    "zipCode": "47890"
  },
  "balances": {
    "currencies": {
      "BTC": {
        "amount": "4500.00",
        "balance": "5.00",
        "currency": "USD",
        "rate": "900.00000"
      },
      "EUR": {
        "amount": "180.89",
        "balance": "154.88",
        "currency": "USD",
        "rate": "1.16795"
      },
      "USD": {
        "amount": "17710.05",
        "balance": "17710.05",
        "currency": "USD",
        "rate": "1.00000"
      }
    },
    "total": "22390.94"
  },
  "birthdate": "2000-09-27",
  "country": "US",
  "currencies": [
    "BTC",
    "CNY",
    "ETH",
    "EUR",
    "GBP",
    "JPY",
    "LTC",
    "USD",
    "XAU",
    "XRP"
  ],
  "email": "malika.koss@example.com",
  "firstName": "Malika",
  "id": "21e65c4d-55e4-41be-97a1-ff38d8f3d945",
  "lastName": "Koss",
  "memberAt": "2018-08-01T09:53:44.293Z",
  "name": "Malika Koss",
  "phones": [{
    "e164Masked": "+XXXXXXXXX66",
    "id": "abefe0b6-2f5d-45ba-97ac-3b07b08595a3",
    "internationalMasked": "+X XXX-XXX-XX66",
    "nationalMasked": "(XXX) XXX-XX66",
    "primary": true,
    "verified": true
  }],
  "settings": {
    "currency": "USD",
    "hasMarketingConsent": false,
    "hasNewsSubscription": false,
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
      },
      "vmc": {
        "enabled": true
      }
    }
  },
  "state": "US-UT",
  "status": "ok",
  "type": "individual",
  "verifications": {}
}
```

The `user` object contains most of the information we have on record relating to the currently logged in user.

<aside class="notice">
  <strong>Privacy Notice</strong>: Users are only permitted to access information about themselves.
  Our API does not allow accessing information about other users.
</aside>

Property | Description
-------- | ----------------------------------------------------------------------------------------------------------
memberAt | The date when the user became a [verified member](https://support.uphold.com/hc/en-us/articles/206119603).

<aside class="notice">
  The <code>memberAt</code> field can be <code>null</code> if the user hasn't completed the membership process.
  Any information needed for membership will be included in the <a href="#user-verifications">verifications</a> field.
  Note that this is distinct from the <code>pending</code> <a href="#user-status">user status</a>, which is related to the initial signup process.
</aside>

### User Settings

- **otp.login.enabled** - This will prompt the user to input an OTP token when creating an OAuth token.
- **otp.transactions.send.enabled** - This will prompt the user to input an OTP token when creating a transaction to another user.
- **otp.transactions.transfer.enabled** - This will prompt the user to input an OTP token when transacting between the user's own cards.
- **otp.transactions.withdraw.crypto.enabled** - This will prompt the user to input an OTP token when withdrawing to the bitcoin network.
- **otp.vmc.enabled** - This will prompt the user to input an OTP token when using VMCs.

### User Status

We communicate a number of different user statuses through our API.
At a high-level users can be in one of four statuses:

- **pending** - This status applies to a user that is in the process of creating an account;
  it means the signup process is not yet finalized.
- **restricted** - This status means the user is allowed to login to the application, deposit or receive money, and perform trades, but they are not permitted to withdraw nor send money to other users.
  This status exists to allow users to satisfy additional data requirements.
- **blocked** - This status is present when a user has violated our terms of service.
  In this status users are unable to login or access the product.
- **ok** - Everything is ay-ok.

### User Verifications

The `verifications` field can help communicate the reasons for a given user status, or what's missing to complete the membership process.
These verifications have permissible values and in some cases, an associated reason.
Here is an overview of the verifications field:

Flag      | Permissible Values               | Reason         | Description
--------- | -------------------------------- | -------------- | --------------------------------------------------------------------------------------
birthdate | required                         | n/a            | Whether the user needs to provide his/her date of birth.
email     | unconfirmed                      | n/a            | Whether the user needs to confirm his/her email.
identity  | required, retry, review, running | n/a            | The status of identity verification during membership application process.
location  | required, blocked                | country, state | Whether the user has specified his/her location, which can be a blocked country/state.
phone     | required, unconfirmed            | n/a            | The status of phone number verification.
terms     | required                         | updated        | Whether the user has accepted the latest version of the terms of service.
