# Tickers

Developers can query at any time the rates we utilize when exchanging one form of value for another. These are expressed in "currency pairs."

## Get All Tickers

```bash
curl "https://api.bitreserve.org/v0/ticker"
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
    "currency": "CNY",
    "pair": "CNYCNY"
  },
  {
    "ask": "7.6865",
    "bid": "7.6731",
    "currency": "CNY",
    "pair": "EURCNY"
  },
  {
    "ask": "1",
    "bid": "1",
    "currency": "EUR",
    "pair": "EUREUR"
  },
  {
    "ask": "0.799",
    "bid": "0.7988",
    "currency": "GBP",
    "pair": "EURGBP"
  },
  {
    "ask": "145.6111",
    "bid": "145.5311",
    "currency": "JPY",
    "pair": "EURJPY"
  },
  {
    "ask": "1.253",
    "bid": "1.2528",
    "currency": "USD",
    "pair": "EURUSD"
  },
  {
    "ask": "9.6217",
    "bid": "9.6048",
    "currency": "CNY",
    "pair": "GBPCNY"
  },
  {
    "ask": "1",
    "bid": "1",
    "currency": "GBP",
    "pair": "GBPGBP"
  },
  {
    "ask": "182.2707",
    "bid": "182.1691",
    "currency": "JPY",
    "pair": "GBPJPY"
  },
  {
    "ask": "1.5685",
    "bid": "1.5683",
    "currency": "USD",
    "pair": "GBPUSD"
  },
  {
    "ask": "0.0528",
    "bid": "0.0527",
    "currency": "CNY",
    "pair": "JPYCNY"
  },
  {
    "ask": "1",
    "bid": "1",
    "currency": "JPY",
    "pair": "JPYJPY"
  },
  {
    "ask": "6.1345",
    "bid": "6.1245",
    "currency": "CNY",
    "pair": "USDCNY"
  },
  {
    "ask": "116.21",
    "bid": "116.16",
    "currency": "JPY",
    "pair": "USDJPY"
  },
  {
    "ask": "1",
    "bid": "1",
    "currency": "USD",
    "pair": "USDUSD"
  }
]
```

### Request

`GET https://api.bitreserve.org/v0/ticker`

### Response

Returns an associative array containing the current rates Bitreserve has on record for all currency pairs.

## Get Tickers for Currency

```bash
curl "https://api.bitreserve.org/v0/ticker/USD"
```

> The above command returns the following JSON:

```json
[
  {
    "ask": "440.99",
    "bid": "440",
    "currency": "USD",
    "pair": "BTCUSD"
  },
  {
    "ask": "1.253",
    "bid": "1.2528",
    "currency": "USD",
    "pair": "EURUSD"
  },
  {
    "ask": "1.5685",
    "bid": "1.5683",
    "currency": "USD",
    "pair": "GBPUSD"
  },
  {
    "ask": "6.1345",
    "bid": "6.1245",
    "currency": "CNY",
    "pair": "USDCNY"
  },
  {
    "ask": "116.21",
    "bid": "116.16",
    "currency": "JPY",
    "pair": "USDJPY"
  },
  {
    "ask": "1",
    "bid": "1",
    "currency": "USD",
    "pair": "USDUSD"
  }
]
```

This method allows developers to find all exchanges rates relative to a given currency.

### Request

`GET https://api.bitreserve.org/v0/ticker/:currency`

### Response

Returns an associative array containing the current rates Bitreserve has on record for the currency specified.
