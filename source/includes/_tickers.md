# Tickers
Developers can query at any time the rates we utilize when exchanging one form of value for another. These are expressed in "currency pairs."

## Get All Tickers

```bash
curl https://api.uphold.com/v0/ticker
```

> The above command returns the following JSON:

```json
[{
  "ask": "1",
  "bid": "1",
  "currency": "BTC",
  "pair": "BTCBTC"
}, {
  "ask": "440.99",
  "bid": "440",
  "currency": "USD",
  "pair": "BTCUSD"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "CHF",
  "pair": "CHFCHF"
}, {
  "ask": "6.7505",
  "bid": "6.7459",
  "currency": "CNY",
  "pair": "CHFCNY"
}, {
  "ask": "0.9554",
  "bid": "0.9549",
  "currency": "EUR",
  "pair": "CHFEUR"
}, {
  "ask": "0.709",
  "bid": "0.7087",
  "currency": "GBP",
  "pair": "CHFGBP"
}, {
  "ask": "67.2329",
  "bid": "67.1861",
  "currency": "INR",
  "pair": "CHFINR"
}, {
  "ask": "129.0301",
  "bid": "128.9632",
  "currency": "JPY",
  "pair": "CHFJPY"
}, {
  "ask": "16.1385",
  "bid": "16.1296",
  "currency": "MXN",
  "pair": "CHFMXN"
}, {
  "ask": "1.0811",
  "bid": "1.0806",
  "currency": "USD",
  "pair": "CHFUSD"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "CNY",
  "pair": "CNYCNY"
}, {
  "ask": "7.0661",
  "bid": "7.0641",
  "currency": "CNY",
  "pair": "EURCNY"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "EUR",
  "pair": "EUREUR"
}, {
  "ask": "0.7422",
  "bid": "0.7421",
  "currency": "GBP",
  "pair": "EURGBP"
}, {
  "ask": "70.5195",
  "bid": "70.4993",
  "currency": "INR",
  "pair": "EURINR"
}, {
  "ask": "135.0637",
  "bid": "135.0463",
  "currency": "JPY",
  "pair": "EURJPY"
}, {
  "ask": "1.1317",
  "bid": "1.1316",
  "currency": "USD",
  "pair": "EURUSD"
}, {
  "ask": "9.5214",
  "bid": "9.5187",
  "currency": "CNY",
  "pair": "GBPCNY"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "GBP",
  "pair": "GBPGBP"
}, {
  "ask": "95.0474",
  "bid": "95.0207",
  "currency": "INR",
  "pair": "GBPINR"
}, {
  "ask": "181.9941",
  "bid": "181.972",
  "currency": "JPY",
  "pair": "GBPJPY"
}, {
  "ask": "1.5249",
  "bid": "1.5248",
  "currency": "USD",
  "pair": "GBPUSD"
}, {
  "ask": "0.1002",
  "bid": "0.1001",
  "currency": "CNY",
  "pair": "INRCNY"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "INR",
  "pair": "INRINR"
}, {
  "ask": "0.0523",
  "bid": "0.0523",
  "currency": "CNY",
  "pair": "JPYCNY"
}, {
  "ask": "0.5221",
  "bid": "0.5219",
  "currency": "INR",
  "pair": "JPYINR"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "JPY",
  "pair": "JPYJPY"
}, {
  "ask": "0.4183",
  "bid": "0.4182",
  "currency": "CNY",
  "pair": "MXNCNY"
}, {
  "ask": "0.0592",
  "bid": "0.0592",
  "currency": "EUR",
  "pair": "MXNEUR"
}, {
  "ask": "0.0439",
  "bid": "0.0439",
  "currency": "GBP",
  "pair": "MXNGBP"
}, {
  "ask": "4.1624",
  "bid": "4.1605",
  "currency": "INR",
  "pair": "MXNINR"
}, {
  "ask": "7.996",
  "bid": "7.9946",
  "currency": "JPY",
  "pair": "MXNJPY"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "MXN",
  "pair": "MXNMXN"
}, {
  "ask": "0.067",
  "bid": "0.067",
  "currency": "USD",
  "pair": "MXNUSD"
}, {
  "ask": "6.244",
  "bid": "6.2425",
  "currency": "CNY",
  "pair": "USDCNY"
}, {
  "ask": "62.298",
  "bid": "62.2829",
  "currency": "INR",
  "pair": "USDINR"
}, {
  "ask": "119.349",
  "bid": "119.34",
  "currency": "JPY",
  "pair": "USDJPY"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "USD",
  "pair": "USDUSD"
}, {
  "ask": "17.5526",
  "bid": "17.0054",
  "currency": "USD",
  "pair": "XAGUSD"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "XAG",
  "pair": "XAGXAG"
}, {
  "ask": "1244.6975",
  "bid": "1226.242",
  "currency": "USD",
  "pair": "XAUUSD"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "XAU",
  "pair": "XAUXAU"
}, {
  "ask": "787.4225",
  "bid": "757.2452",
  "currency": "USD",
  "pair": "XPDUSD"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "XPD",
  "pair": "XPDXPD"
}, {
  "ask": "1250.7275",
  "bid": "1215.096",
  "currency": "USD",
  "pair": "XPTUSD"
}, {
  "ask": "1",
  "bid": "1",
  "currency": "XPT",
  "pair": "XPTXPT"
}]
```

### Request
`GET https://api.uphold.com/v0/ticker`

### Response
Returns an associative array containing the current rates Uphold has on record for all currency pairs.

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
Returns an associative array containing the current rates Uphold has on record for the currency specified.
