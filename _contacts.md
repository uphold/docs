# Contacts

## List Contacts

```bash
curl "https://api.bitreserve.org/v0/me/contacts" \
  -H "Authorization: Bearer <token>"
```
```php
<?php
require_once 'vendor/autoload.php';
use Bitreserve\BitreserveClient as Client;
// Initialize the client.
$client = new Client(getenv('AUTHORIZATION_TOKEN'));
// Get the current user.
$user = $client->getUser();
$contact_objects = $user->getContacts();

echo "*** List of user contacts ***\n";
foreach ($contact_objects as $contact) {
  echo sprintf("id: %s\n", $contact->getID());
  echo sprintf("FirstName: %s\n", $contact->getFirstName());
  echo sprintf("LastName: %s\n", $contact->getLastName());
  echo sprintf("Company: %s\n", $contact->getCompany());
  $emails = $contact->getEmails();
  foreach ($emails as $email) {
    echo sprintf("Email: %s\n", $email);
  }
  $addresses = $contact->getAddresses();
  foreach ($addresses as $address) {
    echo sprintf("Adresses: %s\n", $address);
  }
  echo sprintf("Name: %s\n", $contact->getName());
  echo "\n";
}
?>
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

`GET https://api.bitreserve.org/v0/me/contacts`

### Response

Returns an array of contact objects associated with the current user.

## Get Contact

```bash
curl "https://api.bitreserve.org/v0/me/contacts/9fae84eb-712d-4b6a-9b2c-764bdde4c079" \
  -H "Authorization: Bearer <token>"
```
```php
<?php
require_once 'vendor/autoload.php';
use Bitreserve\BitreserveClient as Client;
// Initialize the client.
$client = new Client(getenv('AUTHORIZATION_TOKEN'));
// Get the current user.
$user = $client->getUser();
//Enter the user ID of the contact you want the details of.
$contact = $user->getContactById('1f0b8698-5c61-4f39-82b5-e89abd94970f');

echo "*** List information of one contact ***\n";
echo sprintf("id: %s\n", $contact->getId());
?>
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

`GET https://api.bitreserve.org/v0/me/contacts/:id`

### Response

Returns an associative array containing the details of the designated contact.

## Create Contact

```bash
curl -X POST --data "firstName=Luke&lastName=Skywalker&company=Lars+Moisture+Farm,+Inc.&emails=support@larsmoisturefarm.com" \
  -H "Authorization: Bearer <token>" \
  https://api.bitreserve.org/v0/me/contacts
```
```php
<?php
require_once 'vendor/autoload.php';
use Bitreserve\BitreserveClient as Client;
// Initialize the client.
$client = new Client(getenv('AUTHORIZATION_TOKEN'));
// Get the current user.
$user = $client->getUser();
$emails = array("emailofcontact@gmail.com");
$addresses = array();
$contact = $user->createContact('CantactFirstName', 'ContactLastName', 'ContactCompany', $emails, $addresses);
echo "*** Details of newly created contact ***\n";
  echo sprintf("id: %s\n", $contact->getID());
  echo sprintf("FirstName: %s\n", $contact->getFirstName());
  echo sprintf("LastName: %s\n", $contact->getLastName());
  echo sprintf("Company: %s\n", $contact->getCompany());
  $emails = $contact->getEmails();
  foreach ($emails as $email) {
    echo sprintf("Email: %s\n", $email);
  }
  $addresses = $contact->getAddresses();
  foreach ($addresses as $address) {
    echo sprintf("Adresses: %s\n", $address);
  }
  echo sprintf("Name: %s\n", $contact->getName());
  echo "\n";
  ?>
```

### Request

`POST https://api.bitreserve.org/v0/me/contacts`

Parameter | Default |  Description
--------- | ----------- | -----------
firstName | | Contact's first name. (max: 255 chars)
lastName | | Contact's last name. (max: 255 chars)
company | | Contact's company. (max: 255 chars)
emails | | List of email addresses.
addresses | | List of bitcoin addresses.

### Response

A fully formed [Contact Object](#contact-object)
