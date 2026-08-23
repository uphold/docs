# Webhooks

For **business usage only** you may choose to use webhooks to get updates in real time instead of having to poll the API.
This requires [manual approval](#support) from Uphold.

A webhooks integration requires the following details:

* **Subscription URL:** the URL for Uphold to send webhook requests to;
* **Secret:** the secret for Uphold to use to sign all requests and prove they have not been tampered with
  (not the same as the client secret that is used for Uphold's API).

Each webhook uses the following format:

Parameter | Description
----------|--------------------------------------------------------------------------------------
createdAt | Timestamp of the notification, can be used to verify message ordering.
id        | Unique identifier of the notification, can be used to ignore duplicate notifications.
payload   | JSON with the actual model data being sent by the webhook.
retries   | Number of retries of the notification, in case of failure of previous requests (e.g. the request getting an HTTP response not in the 2xx range).
type      | Type of the notification (e.g. `card:updated`).
userId    | Unique identifier of the Uphold user that owns the resource.

In addition, the request also includes a `Signature` header that can be used to verify that the request body has not been tampered with.
Its value is the HMAC-SHA512 of the JSON-serialized request body, computed with the previously provided secret, hex-encoded and prefixed with `sha512=`.
To verify a request, compute the HMAC-SHA512 of the raw request body using the shared secret, and compare `sha512=` followed by the resulting hex digest against the `Signature` header, using a constant-time comparison function to avoid leaking timing information.

> Example of `Signature` header:

```
sha512=040518ad86dd4bea08ba6d23240f53a9f35175bcb3c548e83f33acc792aabcafe29954f92b0e1d6ede9192c851b3ba0768f760f516e168c7b318a17d2714bf52
```

## Card updated

If you want to be notified whenever a given card's balance changes, you can use the "Card Updated" scope. This is useful when you want to perform actions regarding the user's total balance or the balance of a specific card, so that you can act accordingly.

> The following is a `card:updated` webhook payload example:

```json
{
  "createdAt": "2018-05-03T12:25:21.809Z",
  "id": "c4db98e4-c9e1-46dc-a927-17a26fb9772c",
  "payload": {
    "context": {
      "transaction": {
        "id": "fd2907af-5bcd-488e-9310-42993d0e375e"
      }
    },
    "id": "c4a77706-7b3a-4b8b-968b-4190038d37e8"
  },
  "retries": 0,
  "type": "card:updated",
  "userId": "e5b23ad5-6c1e-44d0-a49d-a080135fc083"
}
```

This webhook returns the following payload:

Parameter | Description
----------|---------------------------------------
context   | A JSON object with additional context.
id        | The id of the updated card.

The additional context includes the following details:

Parameter   | Description
------------|------------------------------------------------------------------------
transaction | A JSON object with the id of the transaction that triggered the update.

It returns the `id` of the card and additional context whenever a card has changed its `available` or `balance`, i.e. whenever it sends or receives a transaction.
The context includes the id of that transaction.
The payload does not contain the full card details — use the [get card details](#get-card-details) endpoint to retrieve the updated card.

## OAuth authorization revoked

This webhook is triggered when a user that had previously authorized your app decides to remove said authorization. When this happens, you'll receive a request informing you of which user has removed the authorization. To subscribe to these updates, you'll need to configure a webhook with the "OAuth Authorization Revoked" scope.

> The following is a `oauth-authorization:revoked` webhook payload example:

```json
{
  "createdAt": "2018-05-03T12:25:21.809Z",
  "id": "c4db98e4-c9e1-46dc-a927-17a26fb9772c",
  "payload": {
    "id": "758d3c93-5f00-46dd-a1b3-facdc215e09b"
  },
  "retries": 0,
  "type": "oauth-authorization:revoked",
  "userId": "e5b23ad5-6c1e-44d0-a49d-a080135fc083"
}
```

This webhook returns the following payload:

Parameter | Description
----------|---------------------------------------
id        | The id of the authorization.

It returns the `id` of the authorization that was revoked.

## Transaction status

When you create a transaction, the first set of validations is run and you'll get an error if the transaction request is not valid. Otherwise, the request is completed successfully and, once the transaction is committed, its `status` will be `processing`. In the meantime, we perform another set of validations that can lead to the transaction's `status` changing — for example, to `completed` or `failed`. This asynchronous behavior can be handled by subscribing to a webhook with the "Transaction Status Updated" scope, which will allow you to receive updates whenever a transaction changes its `status` — any status transition is forwarded.
The notifications you receive are determined by your webhook subscription's configuration — the event type and, optionally, filters for a specific entity or user.

> The following is a `transaction:status:updated` webhook payload example:

```json
{
  "createdAt": "2018-05-03T12:25:21.809Z",
  "id": "c4db98e4-c9e1-46dc-a927-17a26fb9772c",
  "payload": {
    "id": "c4a77706-7b3a-4b8b-968b-4190038d37e8",
    "status":  "completed"
  },
  "retries": 0,
  "type": "transaction:status:updated",
  "userId": "e5b23ad5-6c1e-44d0-a49d-a080135fc083"
}
```

This webhook returns the following payload:

Parameter | Description
----------|-------------------------------------------------------------------------
id        | The id of the transaction.
status    | A string with the transaction status that triggered the hook.
|         | Any status change is forwarded. Statuses include: `cancelled`, `completed`, `failed`, `on-hold`, `processing` and `waiting`.

It returns the `id` of the created transaction, along with its current `status`.
