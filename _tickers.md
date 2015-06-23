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
// Initialize the client. In this case, we don't need an
// AUTHORIZATION_TOKEN because the Ticker endpoint is public.
$client = new Client();
// Get tickers.
$tickers = $client->getTicker();

echo "*** Current exchange rates ***\n";
foreach ($tickers as $ticker) {
    echo sprintf("Pair: %s\n", $ticker->getPair());
    echo sprintf("Ask: 1 %s = %s %s\n", substr($ticker->getPair(), 0, 3), $ticker->getAsk(), $ticker->getCurrency());
    echo sprintf("Bid: 1 %s = %s %s\n", substr($ticker->getPair(), 0, 3), $ticker->getBid(), $ticker->getCurrency());
    echo "\n";
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
  }, <snip>
```

### Request

`GET https://api.bitreserve.org/v0/ticker`

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
// Initialize the client. In this case, we don't need an
// AUTHORIZATION_TOKEN because the Ticker endpoint is public.
$client = new Client();
// Get tickers for INR.
$tickers = $client->getTickerByCurrency('INR');
echo "*** Current exchange rates ***\n";
foreach ($tickers as $ticker) {
    echo sprintf("Pair: %s\n", $ticker->getPair());
    echo sprintf("Ask: 1 %s = %s %s\n", substr($ticker->getPair(), 0, 3), $ticker->getAsk(), $ticker->getCurrency());
    echo sprintf("Bid: 1 %s = %s %s\n", substr($ticker->getPair(), 0, 3), $ticker->getBid(), $ticker->getCurrency());
    echo "\n";
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
  },<snip>
```

This method allows developers to find all exchanges rates relative to a given currency.

### Request

`GET https://api.bitreserve.org/v0/ticker/:currency`

### Response

Returns an associative array containing the current rates Bitreserve has on record for the currency specified. The example to right shows a compressed list of currencies.
