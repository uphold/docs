# Contacts

## List Contacts

```bash
curl https://api.uphold.com/v0/me/contacts \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "addresses": [],
  "company": "Rebel Alliance",
  "emails": [
    "han.solo@rebelalliance.org"
  ],
  "firstName": "Han",
  "id": "9fae84eb-712d-4b6a-9b2c-764bdde4c079",
  "lastName": "Solo",
  "name": "Han Solo"
}, {
  "addresses": [],
  "company": "Galactic Senate",
  "emails": [
    "leia.organa@senate.coruscant.gov"
  ],
  "firstName": "Leia",
  "id": "2f3b26bf-4621-4fe9-ab7d-565105b22588",
  "lastName": "Organa",
  "name": "Leia Organa"
}]
```

### Request

`GET https://api.uphold.com/v0/me/contacts`

<aside class="notice">
  Requires the <code>contacts:read</code> scope for Uphold Connect applications.
</aside>

### Response

Returns an array of contact objects associated with the current user.

## Get Contact

```bash
curl https://api.uphold.com/v0/me/contacts/9fae84eb-712d-4b6a-9b2c-764bdde4c079 \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
{
  "addresses": [],
  "company": "Rebel Alliance",
  "emails": [
    "han.solo@rebelalliance.org"
  ],
  "firstName": "Han",
  "id": "9fae84eb-712d-4b6a-9b2c-764bdde4c079",
  "lastName": "Solo",
  "name": "Han Solo"
}
```

### Request

`GET https://api.uphold.com/v0/me/contacts/:id`

<aside class="notice">
  Requires the <code>contacts:read</code> scope for Uphold Connect applications.
</aside>

### Response

Returns an associative array containing the details of the designated contact.

## Create Contact

```bash
curl https://api.uphold.com/v0/me/contacts \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "firstName": "Luke", "lastName": "Skywalker", "company": "Lars Moisture Farm, Inc.", "emails": ["support@larsmoisturefarm.com"] }'
```

### Request

`POST https://api.uphold.com/v0/me/contacts`

<aside class="notice">
  Requires the <code>contacts:write</code> scope for Uphold Connect applications.
</aside>

Parameter | Description
--------- | --------------------------------------
addresses | List of bitcoin addresses.
company   | Contact's company. (max: 255 chars)
emails    | List of email addresses.
firstName | Contact's first name. (max: 255 chars)
lastName  | Contact's last name. (max: 255 chars)

### Response

A fully formed [Contact Object](#contact-object)
