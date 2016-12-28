# Contacts
## List Contacts

```bash
curl https://api.uphold.com/v0/me/contacts \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "id": "9fae84eb-712d-4b6a-9b2c-764bdde4c079",
  "firstName": "Han",
  "lastName": "Solo",
  "company": "Rebel Alliance",
  "emails": [
    "han.solo@rebelalliance.org"
  ],
  "addresses": [],
  "name": "Han Solo"
}, {
  "id": "2f3b26bf-4621-4fe9-ab7d-565105b22588",
  "firstName": "Leia",
  "lastName": "Organa",
  "company": "Galactic Senate",
  "emails": [
    "leia.organa@senate.coruscant.gov"
  ],
  "addresses": [],
  "name": "Leia Organa"
}]
```

### Request
`GET https://api.uphold.com/v0/me/contacts`
<aside class="notice">Requires the `contacts:read` scope for Uphold Connect applications.</aside>

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
  "id": "9fae84eb-712d-4b6a-9b2c-764bdde4c079",
  "firstName": "Han",
  "lastName": "Solo",
  "company": "Rebel Alliance",
  "emails": [
    "han.solo@rebelalliance.org"
  ],
  "addresses": [],
  "name": "Han Solo"
}
```

### Request
`GET https://api.uphold.com/v0/me/contacts/:id`
<aside class="notice">Requires the `contacts:read` scope for Uphold Connect applications.</aside>

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
<aside class="notice">Requires the `contacts:write` scope for Uphold Connect applications.</aside>

Parameter | Description
--------- | --------------------------------------
firstName | Contact's first name. (max: 255 chars)
lastName  | Contact's last name. (max: 255 chars)
company   | Contact's company. (max: 255 chars)
emails    | List of email addresses.
addresses | List of bitcoin addresses.

### Response
A fully formed [Contact Object](#contact-object)
