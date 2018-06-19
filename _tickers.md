# Tickers
Developers can query at any time the rates we utilize when exchanging one form of value for another. These are expressed in "currency pairs."

## Get Tickers for Currency

```bash
curl https://api.uphold.com/v0/ticker/USD
```

> The above command returns the following JSON:

```json
[{
  "ask": "225.92",
  "bid": "225.8",
  "currency": "USD",
  "pair": "BTCUSD"
}, {
  "ask": "1.0693",
  "bid": "1.0692",
  "currency": "USD",
  "pair": "CHFUSD"
}, {
  "ask": "1.1266",
  "bid": "1.1258",
  "currency": "USD",
  "pair": "EURUSD"
}, {
  "ask": "1.5329",
  "bid": "1.5328",
  "currency": "USD",
  "pair": "GBPUSD"
}, {
  "ask": "0.0646",
  "bid": "0.0646",
  "currency": "USD",
  "pair": "MXNUSD"
}, {
  "ask": "6.1972",
  "bid": "6.1964",
  "currency": "CNY",
  "pair": "USDCNY"
}, {
  "ask": "63.948",
  "bid": "63.9404",
  "currency": "INR",
  "pair": "USDINR"
}, {
  "ask": "124.148",
  "bid": "124.1455",
  "currency": "JPY",
  "pair": "USDJPY"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "USD",
  "pair": "USDUSD"
}, {
  "ask": "17.1745",
  "bid": "16.6236",
  "currency": "USD",
  "pair": "XAGUSD"
}, {
  "ask": "1200.169",
  "bid": "1182.5524",
  "currency": "USD",
  "pair": "XAUUSD"
}, {
  "ask": "782.288",
  "bid": "753.2652",
  "currency": "USD",
  "pair": "XPDUSD"
}, {
  "ask": "1149.521",
  "bid": "1115.8874",
  "currency": "USD",
  "pair": "XPTUSD"
}]
```

This method allows developers to find all exchanges rates relative to a given currency.

### Request
`GET https://api.uphold.com/v0/ticker/:currency`

### Response
Returns an associative array containing the current rates Uphold has on record for the currency specified. If no currency is specified on the endpoint, USD currency pair will be returned by default.
