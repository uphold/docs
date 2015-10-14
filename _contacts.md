# Contacts

## List Contacts

```bash
curl "https://api.uphold.com/v0/me/contacts" \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[
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
  },
  {
    "id": "2f3b26bf-4621-4fe9-ab7d-565105b22588",
    "firstName": "Leia",
    "lastName": "Organa",
    "company": "Galactic Senate",
    "emails": [
      "leia.organa@senate.coruscant.gov"
    ],
    "addresses": [],
    "name": "Leia Organa"
  }
]
```

### Request

`GET https://api.uphold.com/v0/me/contacts`

### Response

Returns an array of contact objects associated with the current user.

## Get Contact

```bash
curl "https://api.uphold.com/v0/me/contacts/9fae84eb-712d-4b6a-9b2c-764bdde4c079" \
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

### Response

Returns an associative array containing the details of the designated contact.

## Create Contact

```bash
curl -X POST --data "firstName=Luke&lastName=Skywalker&company=Lars+Moisture+Farm,+Inc.&emails=support@larsmoisturefarm.com" \
  -H "Authorization: Bearer <token>" \
  https://api.uphold.com/v0/me/contacts
```

### Request

`POST https://api.uphold.com/v0/me/contacts`

Parameter | Default |  Description
--------- | ----------- | -----------
firstName | | Contact's first name. (max: 255 chars)
lastName | | Contact's last name. (max: 255 chars)
company | | Contact's company. (max: 255 chars)
emails | | List of email addresses.
addresses | | List of bitcoin addresses.

### Response

A fully formed [Contact Object](#contact-object)
