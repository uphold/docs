# Authentication

Uphold is an OAuth 2.0 compliant service.

Partners looking to integrate with our API must [register an application](#registering-an-application). Applications that implement a user-facing web interface, to provide custom functionality for multiple Uphold users, should use the [Web Application Flow](#web-application-flow). Applications that implement a backend interface for a corporate partner (and therefore represent an Uphold user themselves) should use the [Client Credentials Flow](#client-credentials-flow).

## Web Application Flow

Ideal for web applications that wish to retrieve information about a user's Uphold account or take actions on their behalf.

### Step 1 - Authorization

The authenticating web application should redirect users to the following URL:

`https://uphold.com/authorize/<client_id>`

Or for sandbox applications:

`https://sandbox.uphold.com/authorize/<client_id>`

Supported query parameters:

Parameter | Required | Description
--------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------
intention | no       | Unauthenticated users will be redirected to the `login` page, this behavior can be changed by sending `signup` as the `intention` value.
scope     | yes      | Permissions to request from the user.
state     | yes      | An unguessable, cryptographically secure random string used to protect against cross-site request forgery attacks.

### Step 2 - Requesting a Token

> Exchanging the `code` for a `token`:

```bash
curl https://api.uphold.com/oauth2/token \
  -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -u <clientId>:<clientSecret> \
  -d 'code=<code>&grant_type=authorization_code'
```

> If your request for a token checks out, then our API will return the following:

```json
{
  "access_token": "41ee8b1fa14042e031fe304bb4793b54e6576d19b306dc205136172b80d59d20",
  "expires_in": null
}
```

If the user accepts your request, Uphold will redirect the user back to your site with a temporary `code` and the previously provided `state`, _as is_.

This temporary `code` is valid for a duration of **5 minutes** and **can only be used once**.

Your application is responsible for ensuring that the `state` matches the value previously provided, thus preventing a malicious third-party from forging this request.

You may then exchange this `code` for an `access token` using the following endpoint:

`POST https://api.uphold.com/oauth2/token`

Or for sandbox applications:

`https://api-sandbox.uphold.com/oauth2/token`

Supported parameters:

Parameter     | Required | Description
------------- | -------- | -------------------------------------------------------------------------------------
client_id     | yes      | The application's *clientId*. Please use HTTP Basic Authentication when possible.
client_secret | yes      | The application's *clientSecret*. Please use HTTP Basic Authentication when possible.
code          | yes      | The code acquired in step 1.
grant_type    | yes      | Must be set to *'authorization_code'*.

<aside class="notice">
  <strong>Important Notice</strong>: We recommend encoding the <i>clientId</i> and <i>clientSecret</i> with the HTTP Basic Authentication scheme, instead of authenticating via the request body.
</aside>

### Step 3 - Using the Access Token

> Request using the 'Authorization' header:

```bash
curl https://api.uphold.com/v0/me/cards \
  -H "Authorization: Bearer <token>"
```

Once you have obtained an access token you may call any protected API method on behalf of the user using the "Authorization" HTTP header in the format:

`Authorization: Bearer <token>`

<aside class="notice">
  <strong>Security Notice</strong>: No other method of authentication is supported. For security reasons only the "Authorization" header will be processed.

  This prevents attackers from stealing tokens from the user's browser history, logs, referer headers and other unsecure locations when credentials are sent via query URLs.
</aside>

## Client Credentials Flow

Ideal for backend integrations that do not require access to other Uphold user accounts.

For **business usage only** you may choose to use client credentials authentication. This requires manual approval from Uphold.

### Creating a Token

> To create a client credentials token, execute the following command (make sure the application is set to use client credentials and not authorization code):

```bash
curl https://api.uphold.com/oauth2/token \
  -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -u <clientId>:<clientSecret> \
  -d 'grant_type=client_credentials'
```

To create a client credentials token you may use the following endpoint:

`POST https://api.uphold.com/oauth2/token`

Supported parameters:

Parameter     | Required | Description
------------- | -------- | -------------------------------------------------------------------------------------
client_id     | yes      | The application's *clientId*. Please use HTTP Basic Authentication when possible.
client_secret | yes      | The application's *clientSecret*. Please use HTTP Basic Authentication when possible.
grant_type    | yes      | Must be set to *'client_credentials'*.

<aside class="notice">
  <strong>Important Notice</strong>: We recommend encoding the <i>clientId</i> and <i>clientSecret</i> with the HTTP Basic Authentication scheme, instead of authenticating via the request body.
</aside>

### Using the Token

> Request using the 'Authorization header':

```bash
curl https://api.uphold.com/v0/me/cards \
  -H "Authorization: Bearer <token>"
```

Once you have obtained a client credentials token you may call any protected API method on behalf of the user account owner of the application using the "Authorization" HTTP header in the format:

`Authorization: Bearer <token>`

<aside class="notice">
  <strong>Security Notice</strong>: No other method of authentication is supported. For security reasons only the "Authorization" header will be processed.

  This prevents attackers from stealing tokens from the user's browser history, logs, referer headers and other unsecure locations when credentials are sent via query URLs.
</aside>

## Personal Access Tokens (PAT)

Ideal for scripts, automated tools and command-line programs which remain under your control.

For **personal usage only** you may choose to use a PAT. This token establishes who you are, provides full access to your user account and bypasses Two Factor Authentication, if enabled. For this reason it should be treated just like your email/password combination, i.e. remain secret and never shared with third parties. PATs can be issued and revoked individually.

### Listing PATs

> To list active Personal Access Tokens, execute the following command:

```bash
curl https://api.uphold.com/v0/me/tokens \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[
  {
      "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634",
      "description": "token 1"
  },
  {
      "id": "b97bb994-6e24-4a89-b653-e0a6d0bcf635",
      "description": "token 2"
  }
]
```

To list Personal Access Tokens you may use the following endpoint:

`GET https://api.uphold.com/v0/me/tokens`

### Creating a PAT

> To create a Personal Access Token, execute the following command:

```bash
curl https://api.uphold.com/v0/me/tokens \
  -X POST \
  -H "Content-Type: application/json" \
  -H "OTP-Method-Id: <Method-Id>" \
  -H "OTP-Token: <OTP-Token>" \
  -u <email>:<password> \
  -d '{ "description": "My command line script" }'
```

> The above command returns the following JSON:

```json
{
    "accessToken":"c386ae9c4557c1c661b15911071b06d9e6c3fc9a",
    "description":"My command line script",
    "id":"a97bb994-6e24-4a89-b653-e0a6d0bcf634"
}
```

To create a Personal Access Token you may use the following endpoint:

`POST https://api.uphold.com/v0/me/tokens`

Supported parameters:

Parameter   | Required | Description
----------- | -------- | -----------------------------------------
description | yes      | A human-readable description of this PAT.

<aside class="notice">
  Requires the <code>OTP-Method-Id</code> header with the id of a verified authentication method that belongs to the user, and the <code>OTP-Token</code> header with a valid TOTP token associated to that authentication method.
</aside>

### Revoking a PAT

> To revoke a Personal Access Token, execute the following command:

```bash
curl https://api.uphold.com/v0/me/tokens/:token \
  -X DELETE \
  -H "Authorization: Bearer <token>"
```

To revoke a Personal Access Token you may use the following endpoint:

`DELETE https://api.uphold.com/v0/me/tokens/:token`

Supported parameters:

Parameter | Required | Description
--------- | -------- | ---------------------------
token     | yes      | The PAT you wish to revoke.

### Using a PAT

> Example of using a personal access token to make requests to our API:

```bash
curl https://api.uphold.com/v0/me \
  -H "Authorization: Bearer <token>"
```

A PAT may be used for authenticating a request via the OAuth scheme.

The `<token>` should be set as the `accessToken` received during creation.

## Basic Authentication

> Simple request using email and password:

```bash
curl https://api.uphold.com/v0/me \
  -H 'OTP-Method-Id: <Method-Id>' \
  -H 'OTP-Token: <OTP-Token>' \
  -u <email>:<password>
```

You can use Basic Authentication by providing your email and password combination.

If OTP (One-Time Password, also known as Two-Factor Authentication) is required, then you will get a [401 HTTP error](#errors), along with the HTTP headers `OTP-Token: Required` and `OTP-Method-Id: Required`.
In which case, execute the command above again, this time passing your OTP verification code and method id as a headers, like so: `OTP-Token: <OTP-Token>` and `OTP-Method-Id: <OTP-Method-Id>`.
