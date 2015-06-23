# Tickers

Developers can query at any time the rates we utilize when exchanging one form of value for another. These are expressed in "currency pairs."

## Get All Tickers

```bash
curl "https://api.bitreserve.org/v0/ticker"
```
```php
<?php
require_once 'vendor/autoload.php';
use Bitreserve\BitreserveClient as Client;
$client = new Client();
$tickers = $client->getTicker();
foreach ($tickers as $ticker) {
  // Process $tickers.
}
?>
```

> The above command returns the following JSON:

```json
[
  {
    "ask": "1",
    "bid": "1",
    "currency": "BTC",
    "pair": "BTCBTC"
  },
  {
    "ask": "440.99",
    "bid": "440",
    "currency": "USD",
    "pair": "BTCUSD"
  },
  {
    "ask": "1",
    "bid": "1",
    "currency": "CHF",
    "pair": "CHFCHF"
  },
  {
    "ask": "6.7505",
    "bid": "6.7459",
    "currency": "CNY",
    "pair": "CHFCNY"
  }<snip>
```

### Request

`GET https://api.bitreserve.org/v0/ticker`

<aside class="notice">
**Import Notice**: This endpoint is public. Authentication is not required.
</aside>

### Response

Returns an associative array containing the current rates Bitreserve has on record for all currency pairs. The example to right shows a compressecd list of currencies.

## Get Tickers for Currency

```bash
curl "https://api.bitreserve.org/v0/ticker/USD"
```
```php
<?php
require_once 'vendor/autoload.php';
use Bitreserve\BitreserveClient as Client;
$client = new Client();
$tickers = $client->getTickerByCurrency('INR');
foreach ($tickers as $ticker) {
  //process $tickers.
}
?>
```
> The above command returns the following JSON:

```json
[
  {
    "ask": "225.92",
    "bid": "225.8",
    "currency": "USD",
    "pair": "BTCUSD"
  },
  {
    "ask": "1.0693",
    "bid": "1.0692",
    "currency": "USD",
    "pair": "CHFUSD"
  },
  {
    "ask": "1.1266",
    "bid": "1.1258",
    "currency": "USD",
    "pair": "EURUSD"
  },
  {
    "ask": "1.5329",
    "bid": "1.5328",
    "currency": "USD",
    "pair": "GBPUSD"
  }<snip>
```

This method allows developers to find all exchanges rates relative to a given currency.

### Request

`GET https://api.bitreserve.org/v0/ticker/:currency`

<aside class="notice">
**Import Notice**: This endpoint is public. Authentication is not required.
</aside>

### Response

Returns an associative array containing the current rates Bitreserve has on record for the currency specified. The example to right shows a compressed list of currencies.
