# Transparency

The following section outlines a system for how Bitreserve will provide the transparency our members require in order to ascertain the solvency of the reserve we operate to protect the value entrusted to us by our Members.

We will provide our members with access to two different resources. The first is the Bitreserve Ledger, or "Reserveledger" as we call it. The Reserveledger is a real-time listing of all the company's assets and liabilities. Each entry in the ledger can reference one or more transactions that a user can inquire about and obtain the details of via the second key resource: the Reservechain.

## Reserve Status

```bash
curl "https://api.bitreserve.org/v0/reserve/statistics"
```
```php
<?php
require_once 'vendor/autoload.php';
use \Bitreserve\BitreserveClient as Client;
$client = new Client();
// Get the reserve summary of all the obligations and assets within it.
$statistics = $client->getReserve()->getStatistics();
?>
```

> Which returns the following:

```json
[
  {
    "currency": "BTC",
    "values": [
      {
        "assets": "287.24725",
        "currency": "BTC",
        "liabilities": "133.789096",
        "rate": "1.00"
      },
      {
        "assets": "592404.25",
        "currency": "CNY",
        "liabilities": "275919.87",
        "rate": "2062.34967"
      },
      {
        "assets": "76787.16",
        "currency": "EUR",
        "liabilities": "35764.61",
        "rate": "267.31889"
      },
      {
        "assets": "60512.35",
        "currency": "GBP",
        "liabilities": "28184.40",
        "rate": "210.66168"
      },
      {
        "assets": "10591340.78",
        "currency": "JPY",
        "liabilities": "4933052.69",
        "rate": "36871.86292"
      },
      {
        "assets": "96843.97",
        "currency": "USD",
        "liabilities": "45106.32",
        "rate": "337.14500"
      }
    ],
    "totals": {
      "commissions": "7.47763",
      "transactions": "1755.86701",
      "assets": "493.75857302",
      "liabilities": "335.82190088"
    }
  },<snip>

```

To assist developers with tracking the overall status of our Reserve, we provide a summary of all the obligations and assets within it. Then for convenience's sake we compute the value of each our holdings in all of the currencies we support, making it easy for example to display our total US dollar liabilities, but expressed in Euros. For example, a request to fetch a summary will return an array of assets with the following properties:

Property | Description
-------- | -----------
currency | The asset class of the holding being summarized.
values | Expresses the value of held in the associated currency in all supported forms.
totals | Lists the commissions, transaction volume, assets and liabilities.

Each normalized holding has the following properties:

Property | Description
-------- | -----------
assets | The quantity of assets held for the corresponding holding, but converted to a different currency.
currency | The currency we are computing the current holding in.
liabilities | The quantity of liabilities for the corresponding holding, but converted to a different currency.
rate | The rate we used when computing the holding to the corresponding currency.

### Request

`GET https://api.bitreserve.org/v0/reserve/statistics`

<aside class="notice">
**Import Notice**: This endpoint is public. Authentication is not required.
</aside>

### Response
Returns an associative array containing the summaries for each currency that Bitreserve holds. The example to right shows a full summary for one currency.

## The Reserveledger

Our ledger provides a detailed record of the obligations (a.k.a. "liabilities") flowing into our network via our members, and the resulting changes we as a company make to the assets in our reserve to secure the value of those obligations.

The ledger is made up of "entries," each of which contains information about the change to an asset, a liability, or both, and references the related transactions that affected the change whenever possible.

Frequently one may find that changes to the Reserve's assets and liabilities are not made in lock step with one another, and that the Reserve may accrue liabilities of one asset type or another, and then have those liabilities offset by a single change to the Reserve's assets.



```bash
curl "https://api.bitreserve.org/v0/reserve/ledger"
```
```php
<?php
require_once 'vendor/autoload.php';
use \Bitreserve\BitreserveClient as Client;
$client = new Client();
// Get the reserve ledger
$pager = $client->getReserve()->getLedger();
?>
```
### Request
`GET https://api.bitreserve.org/v0/reserve/ledger`

<aside class="notice">
**Import Notice**: This endpoint is public. Authentication is not required.
</aside>

This endpoint supports [Pagination](#pagination).

### Deposits

The following entry shows how a deposit of 0.5 bitcoin by a user would be encoded on the Reserveledger. Every deposit results in two entries in the ledger. The first records the acquisition of a liability, and the second the genesis of an asset. Specifically, it shows the creation of 0.5 bitcoin as an obligation to the user, plus the acquisition of 0.5 bitcoin as an asset.

<pre class="inline"><code>{
  "type": "liability",
  "out": {
    "amount": "0.00",
    "currency": "BTC"
  },
  "in": {
    "amount": "0.5",
    "currency": "BTC"
  },
  "TransactionId": "e205b50e-6649-416d-82c1-98f0ba44dcd9",
  "createdAt": "2014-10-08T12:26:29.844Z"
},
{
  "type": "asset",
  "out": {
    "amount": "0.00",
    "currency": "BTC"
  },
  "in": {
    "amount": "0.5",
    "currency": "BTC"
  },
  "createdAt": "2014-10-08T12:26:29.844Z"
}

</code></pre>

### Transfer of Value

The entry below shows how a user transferring 1.3 bitcoin to a "dollar card," effectively exchanging bitcoin for dollars, would be encoded on the ledger. In this entry, two liabilities are affected. The first is a loss of 1.3 BTC as an obligation, and the second is a gain of $507.51 USD as an obligation. Which makes sense: when a user transfers the bitcoin to their dollar card, Bitreserve no longer owes them that bitcoin. Instead, Bitreserve owes them the $507.51 they exchanged for that bitcoin.

<pre class="inline"><code>{
  "type": "liability",
  "out": {
    "amount": "1.3",
    "currency": "BTC"
  },
  "in": {
    "amount": "507.51",
    "currency": "USD"
  },
  "TransactionId": "1571fbef-d34e-447c-9b6e-4ad775953082",
  "createdAt": "2014-09-30T20:29:36.575Z"
}

</code></pre>

This transfer of value affects our liabilities immediately and in real-time, and thus is reflected in real-time in the ledger. But when our obligations to our members change a possible imbalance in our Reserve is introduced. To compensate for this, we must make changes to the assets as well. These changes to our assets may or may not happen in real-time. This would therefore be recorded in our ledger at some point in the future as follows:

<pre class="inline"><code>{
  "type": "asset",
  "out": {
    "amount": "1.3",
    "currency": "BTC"
  },
  "in": {
    "amount": "507.51",
    "currency": "USD"
  },
  "createdAt": "2014-09-30T20:29:36.575Z"
}

</code></pre>

The examples above are nearly identical from one another due to the simplicity of the use case it elucidates. Consider however that when operating normally it is likely that a series of changes to our liabilities will be aggregated and accounted for in a single change to our assets in order to restore balance to the reserve.

### Withdrawal of Bitcoin

When value is removed from the Reserve, two entries are added. One accounting for the change in assets, and the other for the change in liabilities. The following entry shows how a user transmitting some bitcoin to an external network/wallet would be encoded on the ledger. It shows the removal of a liability of bitcoin to the user, and the subsequent removal of bitcoin as an asset.

<pre class="inline"><code>{
  "type": "asset",
    "out": {
    "amount": "0.10359178",
    "currency": "BTC"
  },
  "in": {
    "amount": "0.00",
    "currency": "BTC"
  },
  "createdAt": "2014-10-08T06:53:51.080Z"
},
{
  "type": "liability",
  "out": {
    "amount": "0.10359178",
    "currency": "BTC"
  },
  "in": {
    "amount": "0.00",
    "currency": "BTC"
  },
  "TransactionId": "6ab1f3e8-3b84-40b0-aec7-8008117c9f86",
  "createdAt": "2014-10-08T06:53:51.080Z"
}

</code></pre>

### Reallocation of Assets

Bitreserve may decide to secure the value of its Reserve by holding value in asset classes which may or may not correlate to how our liabilities are denominated among our members. For example, Bitreserve may wish to convert $1,000,000 in cash into a security of equal value. These changes to the Reserve do not relate to any specific transaction, but need to be accounted for nonetheless. What follows is how we could encode shifting 1M dollars into a US Treasury Bill. Take note that we can optionally include additional data relating to the asset class.

<pre class="inline"><code>{
  "type": "asset",
  "out": {
    amount: "1000000",
    currency: "USD"
  },
  "in": {
    "amount": "1",
    "currency": "T-Bill"
    "meta": {
      "maturityDate": '2016-05-01 00:00:00 UTC',
      "principal": 1000000,
      "rate": 1.5,
      "cusip": 345370860
    }
  },
  "createdAt": "2014-10-08T06:53:51.080Z"
}

</code></pre>

<aside class="notice">
For the time being this "reallocation" example is merely theoretical, but speaks to the potential for us to records assets of various types.
</aside>

## The Reservechain

Bitreserve's Reservechain is a record of all of the transactions made by its Members that move value through the network. It is a "chain" in that any value moved in a transaction can be easily traced back to it's origin.

At a high level, each transaction in the Reservechain contains the following key pieces of information:

* a unique ID
* the entity initiating the transaction
* the entity receiving the value being moved
* a collection of value stored on the network from which the value for current transaction is derived
* all relevant exchange data associated with the transaction, including the quoted exchange rates, Bitreserve's commission, etc.

<aside class="notice">
Transactions relating to the flow of value into and out of the network may contain additional information correlating and making reference to external systems which can be independently queried to verify the veracity of the transaction recorded in our system.
</aside>

#### Traceability

Just like a block chain, the Reservechain is both completely transparent, and **traceable**. For a transaction to be traceable, the value encapsulated by the transaction must reference all the places within the chain where that value is drawn from. This is done by providing a list of transaction IDs, and the value drawn from each. By following these transactions you walk backwards down different paths of the Reservechain until you ultimately find a genesis point for all value accounted for in the transaction.

#### Security and Privacy

All transactions are made public, but specific details about the transaction may be withheld from parties who were not a party to said transaction. To control this we would require developers to authenticate prior to retrieving privileged information relating to a transaction.

### Deposits

A deposit relates to two things: the adding of value into the Reservechain from the outside, and the creation of a new obligation to a user.

Given that this is a point in the chain at which there is a genesis of value, there are no subsequent transactions within the Reservechain to link backwards to. However, we will provide a link to the external authority documenting the source of the value whenever possible.

<pre class="inline"><code>{
  "id": "e205b50e-6649-416d-82c1-98f0ba44dcd9",
  "type": "deposit",
  "params": {
    "currency": "BTC",
    "margin": "0.00",
    "pair": "BTCBTC",
    "rate": "1.00",
    "txid": "ffb51cc62944f334aa56ef7339a8df9ba08c712d9db609207f2f1f2105b914b2"
  },
  "denomination": {
    "amount": "0.5",
    "currency": "BTC"
  },
  "origin": {
    "amount": "0.5",
    "base": "0.5",
    "commission": "0.00",
    "currency": "BTC",
    "fee": "0.00",
    "rate": "1.00",
    "sources": []
  },
  "destination": {
    "amount": "0.5",
    "base": "0.5",
    "commission": "0.00",
    "currency": "BTC",
    "fee": "0.00",
    "rate": "1.00"
  },
  "status": "completed",
  "createdAt": "2014-10-08T12:26:29.807Z"
}

</code></pre>

### Withdrawals

Withdrawal documents the flow of assets out of the system. The destination of the transaction would refer as completely as it can to any external sources that the Bitreserve transaction can be correlated against/with.

Withdrawals also account for value leaving the Reservechain, and is thus a terminus point with regards to traceability.

<pre class="inline"><code>{
  "id": "6ab1f3e8-3b84-40b0-aec7-8008117c9f86",
  "type": "withdrawal",
  "params": {
    "currency": "BTC",
    "margin": "0.00",
    "pair": "BTCBTC",
    "rate": "1.00",
    "txid": "5ee2a05a4af8bef5090ee8974798c097a7d6a75be7564d17e6a330bc1c434bab"
  },
  "denomination": {
    "amount": "34.00",
    "currency": "USD"
  },
  "origin": {
    "amount": "0.10359178",
    "base": "0.10349178",
    "commission": "0.00",
    "currency": "BTC",
    "fee": "0.0001",
    "rate": "1.00",
    "sources": [
      {
        "id": "33eef226-1c1e-4b38-be2f-28d9a57aecdb",
        "amount": "0.10359178"
      }
    ]
  },
  "destination": {
    "address": "1BSrDxeTL9ViJBrAb1QHjK2wsGShjSGVeb",
    "amount": "0.10349178",
    "base": "0.10349178",
    "commission": "0.00",
    "currency": "BTC",
    "fee": "0.00",
    "rate": "1.00",
  },
  "status": "completed",
  "createdAt": "2014-10-08T06:53:51.060Z"
}

</code></pre>

### Transfers

A transfer documents movement of value within our network, either between two parties or two denominations, or both.

<pre class="inline"><code>{
  "id": "1571fbef-d34e-447c-9b6e-4ad775953082",
  "type": "transfer",
  "params": {
    "currency": "USD",
    "margin": "0.45",
    "pair": "BTCUSD",
    "rate": "392.16000",
    "txid": "1946783b396998f8f91c984431ecfecff6d0a72db68b32d0873c1024c7279254"
  },
  "denomination": {
    "amount": "1.3",
    "currency": "BTC"
  },
  "origin": {
    "amount": "1.3001",
    "base": "1.3",
    "commission": "0.00",
    "currency": "BTC",
    "fee": "0.0001",
    "rate": "0.00255",
    "sources": [
      {
        "id": "61cdccdf-cb6e-414e-aafc-7c42dc375cf6",
        "amount": "0.73327414"
      },
      {
        "id": "34f87520-49a4-4f46-8ee0-ba0522c06aa1",
        "amount": "0.56682586"
      }
    ]
  },
  "destination": {
    "amount": "507.51",
    "base": "509.81",
    "commission": "2.30",
    "currency": "USD",
    "fee": "0.00",
    "rate": "392.16000"
  },
  "status": "completed",
  "createdAt": "2014-09-30T20:29:36.458Z"
}

</code></pre>

## Privacy

The Reservechain is a public resource, and is 100% anonymous. **At no point does the Reservechain expose any personally identifiable information**, or any information that could be directly tied to an identity with our network.

We may disclose personally identifiable information to those who were a party to a transaction by way of the protected [List User Transactions](#list-user-transactions) and [List Card Transactions](#list-card-transactions) endpoints.
