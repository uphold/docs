# Authentication
Uphold is an OAuth 2.0 compliant service.

Partners looking to integrate with our API must [register an application](#registering-an-application). Applications that implement a user-facing web interface, to provide custom functionality for multiple Uphold users, should use the [Web Application Flow](#web-application-flow). Applications that implement a backend interface for a corporate partner (and therefore represent an Uphold user themselves) should use use the [Client Credentials Flow](#client-credentials-flow).

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

For **personal usage only** you may choose to use a PAT. This token establishes who you are, provides full access to your user account and bypasses Two Factor Authentication, if enabled. For this reason it should be treated just like your username/password combination, i.e. remain secret and never shared with third parties. PATs can be issued and revoked individually.

### Creating a PAT
> To create a Personal Access Token, execute the following command:

```bash
curl https://api.uphold.com/v0/me/tokens \
  -X POST \
  -H 'OTP-Token: <OTP-Token>' \
  -H "Content-Type: application/json" \
  -u <username-or-email>:<password> \
  -d '{ "description": "My command line script" }'
```

To create a Personal Access Token you may use the following endpoint:

`POST https://api.uphold.com/v0/me/tokens`

Supported parameters:

Parameter   | Required | Description
----------- | -------- | -----------------------------------------
description | yes      | A human-readable description of this PAT.

<aside class="notice">
  <strong>Important Notice</strong>: This request must be authenticated with your username and password using the HTTP Basic Authentication scheme or via OAuth, and a valid OTP token via the `OTP-Token` header.
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
  -u 41ee8b1fa14042e031fe304bb4793b54e6576d19b306dc205136172b80d59d20:X-OAuth-Basic
```

A PAT may be used for authenticating a request via the HTTP Basic Authentication scheme.

The username should be set as the `token` and password should be set to `X-OAuth-Basic`.

## Basic Authentication
> Simple request using username or email and password:

```bash
curl https://api.uphold.com/v0/me \
  -H 'OTP-Token: <OTP-Token>' \
  -u <username-or-email>:<password>
```

You can use Basic Authentication by providing your username or email and password combination.

If OTP (One Time Password, also known as Two-Factor Authentication) is required, then you will get an HTTP 401 (Unauthorized) response, along with the HTTP header `OTP-Token: Required`. Execute the command above again, this time passing your OTP verification code as a header, like so: `OTP-Token: <OTP-Token>`.
