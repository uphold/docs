# Countries

## List Countries

This endpoint returns the data for all countries and territories registered in our platform (about 250 of them, without [pagination](#pagination)).

Each entry contains several fields of information, which are described in the table below:

Property   | Description
---------- | --------------------------------------------------------------------------------------------------------
alpha2     | The [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code for the country or territory, e.g. "US" or "FR".
currency   | The [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) code of the official currency used in the country, e.g. "EUR" or "GBP".
name       | The common or official name of the country or territory, e.g. "Portugal" or "North Macedonia".
phone      | The country calling code (international phone number prefix) and an example phone number.
status     | The status of the country regarding [Uphold's regulatory compliance rules](https://support.uphold.com/hc/en-us/articles/202022209-Supported-Geographies). Can be either "ok" or "blocked".

### Request

> Example request to get the list of countries and territories:

```bash
curl https://api.uphold.com/v0/countries
```

`GET https://api.uphold.com/v0/countries`

### Response

> The above command returns the following JSON:

```json
[
  {
    "alpha2": "AD",
    "currency": "EUR",
    "name": "Andorra",
    "phone": {
      "code": "376",
      "example": "312 345"
    },
    "status": "ok"
  },
  // ...
  {
    "alpha2": "PT",
    "currency": "EUR",
    "name": "Portugal",
    "phone": {
      "code": "351",
      "example": "912 345 678"
    },
    "status": "ok"
  },
  // ...
  {
    "alpha2": "ZW",
    "currency": "ZWL",
    "name": "Zimbabwe",
    "phone": {
      "code": "263",
      "example": "071 123 4567"
    },
    "status": "ok"
  }
]
```

Returns an array of country objects as described in the table above.

## Get Country

This endpoint allows fetching the data for a specific country, given its [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) code.

### Request

> Example request to get the data for a specific country:

```bash
curl https://api.uphold.com/v0/countries/US
```

`GET https://api.uphold.com/v0/countries/:country`

### Response

> The above command returns the following JSON:

```json
{
  "alpha2": "US",
  "currency": "USD",
  "name": "United States of America",
  "phone": {
    "code": "1",
    "example": "(201) 555-0123"
  },
  "status": "ok"
}
```

Returns a single country object as described in the table above.

## Get Country Payments

This endpoint returns a list of available payment methods and corresponding supported currencies for a given country or territory.

### Request

> Example request to get the payment methods available in a given country:

```bash
curl https://api.uphold.com/v0/countries/PT/payments
```

`GET https://api.uphold.com/v0/countries/:country/payments`

### Response

> The above command returns the following JSON:

```json
[
  {
    "currency": "EUR",
    "method": "card"
  },
  {
    "currency": "EUR",
    "method": "sepa"
  },
  {
    "currency": "GBP",
    "method": "card"
  },
  {
    "currency": "USD",
    "method": "card"
  }
]
```

Returns an array of payment objects containing two fields:

Property   | Description
---------- | --------------------------------------------------------------------------------------------------------
currency   | The [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) code of the currency supported for this payment method in this country.
method     | The type of payment method. One of "[ach](https://en.wikipedia.org/wiki/ACH_Network)", "[card](https://en.wikipedia.org/wiki/Credit_card)", or "[sepa](https://en.wikipedia.org/wiki/Single_Euro_Payments_Area)".

<aside class="notice">
  Each method+currency pair is represented as a separate entry in this list. For example, if both USD and EUR are supported for the <code>card</code> method, the list will contain two entries, one with the USD-card pair, and one with the EUR-card pair.
</aside>

## Get Country Subdivisions

This endpoint provides a list of the subdivisions of a given country.

### Request

> Example request to get the subdivisions of a given country:

```bash
curl https://api.uphold.com/v0/countries/BA/subdivisions
```

`GET https://api.uphold.com/v0/countries/:country/subdivisions`

### Response

> The above command returns the following JSON:

```json
[
  {
    "code": "BA-BIH",
    "name": "Federacija Bosne i Hercegovine"
  },
  {
    "code": "BA-BRC",
    "name": "Brčko distrikt"
  },
  {
    "code": "BA-SRP",
    "name": "Republika Srpska"
  }
]
```

Returns an array of subdivision objects, containing the official name and the corresponding [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) code.
If the country contains no subdivisions, an empty array is returned.
