# Webhooks
For **business usage only** you may choose to use webhooks to get updates in real time instead of having to poll the API. This requires manual approval from Uphold.

A webhooks integration requires the following details:
* **Subscription URL:** the URL for Uphold to send webhook requests to;
* **Secret:** the secret for Uphold to use to sign all requests and prove they have not been tampered (not the same as the client secret that is used for Uphold's API).

Each webhook uses the following format:

Parameter | Description
----------|--------------------------------------------------------------------------------------
createdAt | Timestamp of the notification, can be used to verify message ordering.
id        | Unique identifier of the notification, can be used to ignore duplicate notifications.
retries   | Number of retries of the notification, in case of failure of previous requests (e.g. the request getting an HTTP response not in the 2xx range).
type      | Type of the notification (e.g. `card:updated`).
payload   | JSON with the actual model data being sent by the webhook.
userId    | Unique identifier of the Uphold user that owns the resource.

> Example of signature header:

```
sha512=040518ad86dd4bea08ba6d23240f53a9f35175bcb3c548e83f33acc792aabcafe29954f92b0e1d6ede9192c851b3ba0768f760f516e168c7b318a17d2714bf52
```

In addition, the request also includes a signature header, that can be used to verify the request body has not been tampered. That header is built by signing the request body with the previously provided secret, using the SHA512 algorithm.

## Card Updated

> Example of a `card:updated` request:

```json
{
  "createdAt": "2018-05-03T12:25:21.809Z",
  "id": "c4db98e4-c9e1-46dc-a927-17a26fb9772c",
  "retries": 0,
  "type": "card:updated",
  "payload": {
    "id": "c4a77706-7b3a-4b8b-968b-4190038d37e8",
    "context": {
      "transaction": {
        "id": "fd2907af-5bcd-488e-9310-42993d0e375e"
      }
    }
  },
  "userId": "e5b23ad5-6c1e-44d0-a49d-a080135fc083"
}

```

Returns the card details and context whenever a card has changed its `available` or `balance`, i.e. whenever it sends or receives a transaction. The context includes the id of that transaction.

This webhook returns the following payload:

Parameter | Description
----------|---------------------------------------
id        | The id of the updated card.
context   | a JSON object with additional context.

The additional context includes the following details:

Parameter   | Description
------------|------------------------------------------------------------------------
transaction | A JSON object with the id of the transaction that triggered the update.
