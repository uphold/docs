# Tickers

Developers can query at any time the rates we utilize when exchanging one form of value for another.
These are expressed in [currency pairs](#currency-pair-object).

## Get Tickers for Currency

```bash
curl https://api.uphold.com/v0/ticker/USD
```

> The above command returns JSON in the following format:

```json
[{
  "ask": "0.27226",
  "bid": "0.27226",
  "currency": "USD",
  "pair": "AEDUSD"
},
{
  "ask": "0.02675",
  "bid": "0.02675",
  "currency": "USD",
  "pair": "ARSUSD"
},
{
  "ask": "0.72624",
  "bid": "0.72624",
  "currency": "USD",
  "pair": "AUDUSD"
},
{
  "ask": "0.15813",
  "bid": "0.15733",
  "currency": "USD",
  "pair": "BATUSD"
},
{
  "ask": "437.67",
  "bid": "436.02",
  "currency": "USD",
  "pair": "BCHUSD"
},
{
  "ask": "0.24239",
  "bid": "0.24239",
  "currency": "USD",
  "pair": "BRLUSD"
},
{
  "ask": "6420.05",
  "bid": "6419",
  "currency": "USD",
  "pair": "BTCUSD"
},
{
  "ask": "21.83459",
  "bid": "21.61919",
  "currency": "USD",
  "pair": "BTGUSD"
},
{
  "ask": "0.77245",
  "bid": "0.77245",
  "currency": "USD",
  "pair": "CADUSD"
},
{
  "ask": "1.03568",
  "bid": "1.03568",
  "currency": "USD",
  "pair": "CHFUSD"
},
{
  "ask": "0.14552",
  "bid": "0.14552",
  "currency": "USD",
  "pair": "CNYUSD"
},
{
  "ask": "184.17319",
  "bid": "183.07604",
  "currency": "USD",
  "pair": "DASHUSD"
},
{
  "ask": "0.15799",
  "bid": "0.15799",
  "currency": "USD",
  "pair": "DKKUSD"
},
{
  "ask": "210.5",
  "bid": "210.17",
  "currency": "USD",
  "pair": "ETHUSD"
},
{
  "ask": "1.17848",
  "bid": "1.17848",
  "currency": "USD",
  "pair": "EURUSD"
},
{
  "ask": "1.31527",
  "bid": "1.31527",
  "currency": "USD",
  "pair": "GBPUSD"
},
{
  "ask": "0.12805",
  "bid": "0.12805",
  "currency": "USD",
  "pair": "HKDUSD"
},
{
  "ask": "0.27898",
  "bid": "0.27898",
  "currency": "USD",
  "pair": "ILSUSD"
},
{
  "ask": "0.01377",
  "bid": "0.01377",
  "currency": "USD",
  "pair": "INRUSD"
},
{
  "ask": "0.00886",
  "bid": "0.00886",
  "currency": "USD",
  "pair": "JPYUSD"
},
{
  "ask": "0.0099",
  "bid": "0.0099",
  "currency": "USD",
  "pair": "KESUSD"
},
{
  "ask": "0.02671",
  "bid": "0.02664",
  "currency": "USD",
  "pair": "LBAUSD"
},
{
  "ask": "55.51",
  "bid": "55.39",
  "currency": "USD",
  "pair": "LTCUSD"
},
{
  "ask": "0.05264",
  "bid": "0.05264",
  "currency": "USD",
  "pair": "MXNUSD"
},
{
  "ask": "0.12313",
  "bid": "0.12313",
  "currency": "USD",
  "pair": "NOKUSD"
},
{
  "ask": "0.6658",
  "bid": "0.6658",
  "currency": "USD",
  "pair": "NZDUSD"
},
{
  "ask": "0.01841",
  "bid": "0.01841",
  "currency": "USD",
  "pair": "PHPUSD"
},
{
  "ask": "0.27465",
  "bid": "0.27465",
  "currency": "USD",
  "pair": "PLNUSD"
},
{
  "ask": "0.11368",
  "bid": "0.11368",
  "currency": "USD",
  "pair": "SEKUSD"
},
{
  "ask": "0.73244",
  "bid": "0.73244",
  "currency": "USD",
  "pair": "SGDUSD"
},
{
  "ask": "3.67302",
  "bid": "3.67302",
  "currency": "AED",
  "pair": "USDAED"
},
{
  "ask": "37.384",
  "bid": "37.384",
  "currency": "ARS",
  "pair": "USDARS"
},
{
  "ask": "1.37695",
  "bid": "1.37695",
  "currency": "AUD",
  "pair": "USDAUD"
},
{
  "ask": "6.356066865823428462",
  "bid": "6.323910706380825903",
  "currency": "BAT",
  "pair": "USDBAT"
},
{
  "ask": "0.00229347",
  "bid": "0.00228483",
  "currency": "BCH",
  "pair": "USDBCH"
},
{
  "ask": "4.1255",
  "bid": "4.1255",
  "currency": "BRL",
  "pair": "USDBRL"
},
{
  "ask": "0.00015579",
  "bid": "0.00015576",
  "currency": "BTC",
  "pair": "USDBTC"
},
{
  "ask": "0.0462552",
  "bid": "0.04579889",
  "currency": "BTG",
  "pair": "USDBTG"
},
{
  "ask": "1.29458",
  "bid": "1.29458",
  "currency": "CAD",
  "pair": "USDCAD"
},
{
  "ask": "0.96555",
  "bid": "0.96555",
  "currency": "CHF",
  "pair": "USDCHF"
},
{
  "ask": "6.8717",
  "bid": "6.8717",
  "currency": "CNY",
  "pair": "USDCNY"
},
{
  "ask": "0.00546221",
  "bid": "0.00542967",
  "currency": "DASH",
  "pair": "USDDASH"
},
{
  "ask": "6.32967",
  "bid": "6.32967",
  "currency": "DKK",
  "pair": "USDDKK"
},
{
  "ask": "0.004758053004710472",
  "bid": "0.004750593824228029",
  "currency": "ETH",
  "pair": "USDETH"
},
{
  "ask": "0.84855",
  "bid": "0.84855",
  "currency": "EUR",
  "pair": "USDEUR"
},
{
  "ask": "0.7603",
  "bid": "0.7603",
  "currency": "GBP",
  "pair": "USDGBP"
},
{
  "ask": "7.80938",
  "bid": "7.80938",
  "currency": "HKD",
  "pair": "USDHKD"
},
{
  "ask": "3.58455",
  "bid": "3.58455",
  "currency": "ILS",
  "pair": "USDILS"
},
{
  "ask": "72.62198",
  "bid": "72.62198",
  "currency": "INR",
  "pair": "USDINR"
},
{
  "ask": "112.81103",
  "bid": "112.81103",
  "currency": "JPY",
  "pair": "USDJPY"
},
{
  "ask": "101.00997",
  "bid": "101.00997",
  "currency": "KES",
  "pair": "USDKES"
},
{
  "ask": "37.537537537537537538",
  "bid": "37.439161362785473605",
  "currency": "LBA",
  "pair": "USDLBA"
},
{
  "ask": "0.0180538",
  "bid": "0.01801477",
  "currency": "LTC",
  "pair": "USDLTC"
},
{
  "ask": "18.9965",
  "bid": "18.9965",
  "currency": "MXN",
  "pair": "USDMXN"
},
{
  "ask": "8.1213",
  "bid": "8.1213",
  "currency": "NOK",
  "pair": "USDNOK"
},
{
  "ask": "1.50195",
  "bid": "1.50195",
  "currency": "NZD",
  "pair": "USDNZD"
},
{
  "ask": "54.309",
  "bid": "54.309",
  "currency": "PHP",
  "pair": "USDPHP"
},
{
  "ask": "3.64098",
  "bid": "3.64098",
  "currency": "PLN",
  "pair": "USDPLN"
},
{
  "ask": "8.79693",
  "bid": "8.79693",
  "currency": "SEK",
  "pair": "USDSEK"
},
{
  "ask": "1.3653",
  "bid": "1.3653",
  "currency": "SGD",
  "pair": "USDSGD"
},
{
  "ask": "7.20046083",
  "bid": "7.18752246",
  "currency": "VOX",
  "pair": "USDVOX"
},
{
  "ask": "0.06919122",
  "bid": "0.06659874",
  "currency": "XAG",
  "pair": "USDXAG"
},
{
  "ask": "0.0008392",
  "bid": "0.00082561",
  "currency": "XAU",
  "pair": "USDXAU"
},
{
  "ask": "0.00094715",
  "bid": "0.00091395",
  "currency": "XPD",
  "pair": "USDXPD"
},
{
  "ask": "0.00120104",
  "bid": "0.00115312",
  "currency": "XPT",
  "pair": "USDXPT"
},
{
  "ask": "2.176231",
  "bid": "2.175474",
  "currency": "XRP",
  "pair": "USDXRP"
},
{
  "ask": "0.13913",
  "bid": "0.13888",
  "currency": "USD",
  "pair": "VOXUSD"
},
{
  "ask": "15.0153",
  "bid": "14.4527",
  "currency": "USD",
  "pair": "XAGUSD"
},
{
  "ask": "1211.224",
  "bid": "1191.608",
  "currency": "USD",
  "pair": "XAUUSD"
},
{
  "ask": "1094.1465",
  "bid": "1055.7955",
  "currency": "USD",
  "pair": "XPDUSD"
},
{
  "ask": "867.2155",
  "bid": "832.614",
  "currency": "USD",
  "pair": "XPTUSD"
},
{
  "ask": "0.45967",
  "bid": "0.45951",
  "currency": "USD",
  "pair": "XRPUSD"
}]
```

This method allows developers to find all exchanges rates relative to a given currency.

### Request

`GET https://api.uphold.com/v0/ticker/:currency`

### Response

Returns an associative array containing the current rates Uphold has on record for the currency specified.
If no currency is specified on the endpoint, USD currency pair will be returned by default.

## Get Tickers for Currency Pair

```bash
curl https://api.uphold.com/v0/ticker/USD-EUR
```

> The above command returns JSON in the following format:

```json
{
  "ask":"0.87742",
  "bid":"0.87742",
  "currency":"EUR"
}
```

```bash
curl https://api.uphold.com/v0/ticker/EUR-USD
```

> The above command returns JSON in the following format:

```json
{
  "ask":"1.13985",
  "bid":"1.13985",
  "currency":"USD"
}
```

This method allows developers to find the exchange rate of a currency relative to any other currency.

<aside class="notice">
The order of the currencies in the pair affects the output.
</aside>

As is shown in the example, the endpoint will provide the exchange rate from the first currency to the second currency.

### Request

`GET https://api.uphold.com/v0/ticker/:pair`

### Response

Returns an object containing the current rate Uphold has on record for the specified currency pair.
