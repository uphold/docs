# Countries
The Uphold platform uses standard `ISO 3166` codes to handle any action that involves country or subdivision (states, regions, etc.) references, such as creating a new user. You can use the API to access those codes, alongside other pertinent information about those countries and subdivisions.

## Get All Countries

```bash
curl https://api.uphold.com/v0/countries
```

> The above command returns the following JSON:

```json
[{
  "alpha2": "AD",
  "currency": "EUR",
  "name": "Andorra",
  "phone": {
    "code": "376",
    "example": "312 345"
  }
}, {
  "alpha2": "AE",
  "currency": "AED",
  "name": "United Arab Emirates",
  "phone": {
    "code": "971",
    "example": "050 123 4567"
  }
}, {
  "alpha2": "AF",
  "currency": "AFN",
  "name": "Afghanistan",
  "phone": {
    "code": "93",
    "example": "070 123 4567"
  }
}]
```

Retrieves the information of all countries supported by the platform.

### Request
`GET https://api.uphold.com/v0/countries`

### Response
Returns an associative array containing the standard `alpha2` code for every country available, alongside additional information, such as its `name`, official `currency` and `phone` details.

## Get Country details

```bash
curl https://api.uphold.com/v0/countries/US
```

> The above command returns the following JSON:

```json
{
  "alpha2": "US",
  "currency": "USD",
  "name": "United States Of America",
  "phone": {
    "code": "1",
    "example": "(201) 555-5555"
  }
}
```

Retrieves the information about a single country (provided its `alpha2` code).

### Request
`GET https://api.uphold.com/v0/countries/:code`

### Response
Returns an object containing the country's `alpha2` code, name, official `currency` and `phone` details.

## Get Country subdivisions

```bash
curl https://api.uphold.com/v0/countries/US/subdivisions
```

> The above command returns the following JSON:

```json
[{
  "code": "US-AK",
  "name": "Alaska"
}, {
  "code": "US-AL",
  "name": "Alabama"
}, {
  "code": "US-AR",
  "name": "Arkansas"
}, {
  "code": "US-AS",
  "name": "American Samoa"
}, {
  "code": "US-AZ",
  "name": "Arizona"
}, {
  "code": "US-CA",
  "name": "California"
}, {
  "code": "US-CO",
  "name": "Colorado"
}, {
  "code": "US-CT",
  "name": "Connecticut"
}, {
  "code": "US-DC",
  "name": "District of Columbia"
}, {
  "code": "US-DE",
  "name": "Delaware"
}, {
  "code": "US-FL",
  "name": "Florida"
}, {
  "code": "US-GA",
  "name": "Georgia"
}, {
  "code": "US-GU",
  "name": "Guam"
}, {
  "code": "US-HI",
  "name": "Hawaii"
}, {
  "code": "US-IA",
  "name": "Iowa"
}, {
  "code": "US-ID",
  "name": "Idaho"
}, {
  "code": "US-IL",
  "name": "Illinois"
}, {
  "code": "US-IN",
  "name": "Indiana"
}, {
  "code": "US-KS",
  "name": "Kansas"
}, {
  "code": "US-KY",
  "name": "Kentucky"
}, {
  "code": "US-LA",
  "name": "Louisiana"
}, {
  "code": "US-MA",
  "name": "Massachusetts"
}, {
  "code": "US-MD",
  "name": "Maryland"
}, {
  "code": "US-ME",
  "name": "Maine"
}, {
  "code": "US-MI",
  "name": "Michigan"
}, {
  "code": "US-MN",
  "name": "Minnesota"
}, {
  "code": "US-MO",
  "name": "Missouri"
}, {
  "code": "US-MP",
  "name": "Northern Mariana Islands"
}, {
  "code": "US-MS",
  "name": "Mississippi"
}, {
  "code": "US-MT",
  "name": "Montana"
}, {
  "code": "US-NC",
  "name": "North Carolina"
}, {
  "code": "US-ND",
  "name": "North Dakota"
}, {
  "code": "US-NE",
  "name": "Nebraska"
}, {
  "code": "US-NH",
  "name": "New Hampshire"
}, {
  "code": "US-NJ",
  "name": "New Jersey"
}, {
  "code": "US-NM",
  "name": "New Mexico"
}, {
  "code": "US-NV",
  "name": "Nevada"
}, {
  "code": "US-NY",
  "name": "New York"
}, {
  "code": "US-OH",
  "name": "Ohio"
}, {
  "code": "US-OK",
  "name": "Oklahoma"
}, {
  "code": "US-OR",
  "name": "Oregon"
}, {
  "code": "US-PA",
  "name": "Pennsylvania"
}, {
  "code": "US-PR",
  "name": "Puerto Rico"
}, {
  "code": "US-RI",
  "name": "Rhode Island"
}, {
  "code": "US-SC",
  "name": "South Carolina"
}, {
  "code": "US-SD",
  "name": "South Dakota"
}, {
  "code": "US-TN",
  "name": "Tennessee"
}, {
  "code": "US-TX",
  "name": "Texas"
}, {
  "code": "US-UM",
  "name": "United States Minor Outlying Islands"
}, {
  "code": "US-UT",
  "name": "Utah"
}, {
  "code": "US-VA",
  "name": "Virginia"
}, {
  "code": "US-VI",
  "name": "Virgin Islands, U.S."
}, {
  "code": "US-VT",
  "name": "Vermont"
}, {
  "code": "US-WA",
  "name": "Washington"
}, {
  "code": "US-WI",
  "name": "Wisconsin"
}, {
  "code": "US-WV",
  "name": "West Virginia"
}, {
  "code": "US-WY",
  "name": "Wyoming"
}]
```

Retrieves the list of subdivisions of a given country (provided its `alpha2` code).

### Request
`GET https://api.uphold.com/v0/countries/:code/subdivisions`

### Response
Returns an associative array containing the official `code` and `name` of each subdivision.
