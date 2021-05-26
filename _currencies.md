# Currencies

Uphold [supports](https://uphold.com/en/transparency) multiple financial assets,
including traditional currencies, cryptocurrencies, stablecoins, precious metals, U.S. equities, and more.

<aside class="notice">
  For brevity and convenience, we may refer to any such asset simply as "currency" throughout the API documentation.
  In cases that only apply to specific classes of assets, we will clarify accordingly.
</aside>

In Uphold's API, various endpoints include currencies in their input or output.
We represent all such currencies by an abbreviation **code** of variable length, typically containing uppercase letters
(for example, a currency's [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) code,
an equity's [ticker symbol](https://en.wikipedia.org/wiki/Ticker_symbol),
or other similar well-known representation).

## List Supported Assets

> Example of unauthenticated request to list all supported assets:

```bash
curl https://api.uphold.com/v0/assets
```

> The above command returns JSON in the following format:

```json
[
  {
    "code": "BTC",
    "formatting": {
      "decimal": ".",
      "format": "__symbol__ __value__ __code__",
      "grouping": ",",
      "precision": 8
    },
    "name": "Bitcoin",
    "status": "open",
    "symbol": "₿",
    "type": "cryptocurrency"
  },
  {
    "code": "USD",
    "formatting": {
      "decimal": ".",
      "format": "__symbol__ __value__ __code__",
      "grouping": ",",
      "precision": 2
    },
    "name": "US Dollar",
    "status": "open",
    "symbol": "$",
    "type": "fiat"
  },
  {
    "code": "XPT",
    "formatting": {
      "decimal": ".",
      "format": "__code__ __value__ __symbol__",
      "grouping": ",",
      "precision": 8
    },
    "name": "Platinum",
    "status": "open",
    "symbol": "oz",
    "type": "commodity"
  },
  {
    "code": "AAPL",
    "formatting": {
      "decimal": ".",
      "format": "__value__ __code__",
      "grouping": ",",
      "precision": 6
    },
    "name": "Apple",
    "status": "extended",
    "type": "equity"
  }
]
```

> Example of authenticated request to list only the assets available to the current user:

```bash
curl https://api.uphold.com/v0/assets \
  -H "Authorization: Bearer <token>"
```

> Example of filtering the list to show only assets of specific `type`s:

```bash
curl https://api.uphold.com/v0/assets?q=type:cryptocurrency,fiat,equity
```

Get the list of supported currencies and other financial assets, with details as described by the table below:

Property   | Description
---------- | --------------------------------------------------------------------------------------------------------
code       | Uppercase abbreviation of the asset, e.g. "BTC", USD", "C", or "BRK.B".
formatting | Specification for user-facing display, including number formatting and placement of the code and symbol.
name       | Full name of the asset, e.g. "Euro", "Basic Attention Token", or "0x".
status     | Current trading status. See [below](#asset-status) for more details.
symbol     | A short and well-known representation of the asset, if one exists — e.g. "$", "₿", or "Kč".
type       | Type of asset. Possible values are `commodity`, `cryptocurrency`, `equity`, `fiat`, `stablecoin` and `utility_token`.

If the request is unauthenticated, the full list of assets supported by Uphold is returned.
Authenticated requests, on the other hand, will filter the output,
returning only the assets available for the current user,
which can depend on factors such as their country and state of residency.

The list of assets returned can also be filtered by `type` using a query string parameter,
as shown in the example to the side.

Please note that this endpoint is [paginated](#pagination), due to the large number of supported assets (hundreds),
so multiple requests may be required to get the complete list.

### Asset status

The `status` field of an asset indicates whether it can be transacted at the moment.
The possible values are:

* `open` — the asset is in regular operation and transactions can be made with it.
  Most assets remain in this status save for exceptional circumstances, where they can become `halted`.
  Equities, on the other hand, will regularly transition between `open` and either `closed` or `extended`,
  depending on their availability for 24/7 operation. See below for details on these statuses.
* `closed` — the asset is temporarily disabled for trading;
  used for equities during periods outside the U.S. stock market's trading hours
  ([typically](https://www.nasdaq.com/stock-market-trading-hours-for-nasdaq) from 9:30am to 4:00pm ET on weekdays).
* `extended` — used for equities that we make available for trading outside the U.S. stock market's trading hours.
  Transactions made with assets in this status will settle instantly for the user,
  but will have a higher spread, as Uphold takes financial risk to provide this service.
* `halted` — trading has been temporarily disabled due to extraordinary circumstances.
  This can be the case e.g. if a provider is down, or when a cryptocurrency is undergoing a fork.
