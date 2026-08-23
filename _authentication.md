# Authentication

Uphold is an [OAuth 2.0](https://oauth.net/2/)-compliant service.

Partners looking to integrate with our API must [register an application](#registering-an-application).
Applications that implement a user-facing web interface, to provide custom functionality for multiple Uphold users, should use the [Web Application Flow](#web-application-flow).
Native applications — desktop, command-line or mobile — that receive the authorization redirect on a local loopback address should use the [Native Application Flow (PKCE)](#native-application-flow-pkce).
Applications that implement a backend interface for a corporate partner (and therefore represent an Uphold user themselves) should use the [Client Credentials Flow](#client-credentials-flow).

## Web Application Flow

Ideal for web applications that wish to retrieve information about a user's Uphold account or take actions on their behalf.

### Step 1 - Authorization

The authenticating web application should redirect users to the following URL:

`https://wallet.uphold.com/authorize/<client_id>`

Or for Sandbox applications:

`https://wallet-sandbox.uphold.com/authorize/<client_id>`

> Example of an authorization request URL:

```
https://wallet.uphold.com/authorize/<client_id>?state=<state_string>&scope=accounts:read%20cards:read
```

Supported query parameters:

Parameter    | Required | Description
------------ | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------
intention    | no       | By default, unauthenticated users will be redirected to the `login` page. This behavior can be changed by sending `signup` as the `intention` value.
redirect_uri | no       | Must be an **exact match** of one of the application's registered _Redirect URLs_. When omitted, the first registered _Redirect URL_ is used.
scope        | yes      | Permissions to request from the user. Multiple scopes [should be](https://tools.ietf.org/html/rfc6749#section-3.3) separated by spaces.
state        | yes      | An unguessable, cryptographically secure random string used to protect against cross-site request forgery attacks.

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
  "scope": "accounts:read cards:read",
  "token_type": "bearer"
}
```

If the user accepts your request, Uphold will redirect the user back to your site with a temporary `code` and the previously provided `state`, _as is_.

This temporary `code` is valid for a duration of **5 minutes** and **can only be used once** — repeated or concurrent attempts to redeem the same code fail with an `invalid_grant` error, in which case the user must go through the authorization flow again.

By default, access tokens issued through this flow do not expire.
An `expires_in` field, indicating the token's lifetime in seconds, is only present when the application is configured with an access token lifetime.
Likewise, a `refresh_token` is only issued to applications with the refresh token grant enabled.
The `scope` field lists the permissions granted to the token — tokens obtained through this flow are always scoped.

Your application is responsible for ensuring that the `state` matches the value previously provided, thus preventing a malicious third-party from forging this request.

You may then exchange this `code` for an `access token` using the following endpoint:

`POST https://api.uphold.com/oauth2/token`

Or for Sandbox applications:

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

  Note that invalid credentials sent via HTTP Basic Authentication yield a <a href="#errors">401 HTTP error</a>, while invalid credentials sent via the request body yield a <a href="#errors">400 HTTP error</a>.
</aside>

### Error Responses

> Example of an error response for an invalid authorization code:

```json
{
  "error": "invalid_grant",
  "error_description": "Authorization code is invalid"
}
```

Failed requests to the token endpoint return an [RFC 6749](https://tools.ietf.org/html/rfc6749#section-5.2)-style error response, where `error` is a machine-readable code and `error_description` a human-readable explanation.

The most common error codes are:

Error               | HTTP status                                    | Typical cause
------------------- | ---------------------------------------------- | --------------------------------------------------------------
invalid_request     | 400                                            | A required parameter is missing or malformed.
invalid_client      | 400 (401 when using HTTP Basic Authentication) | Unknown *clientId* or wrong *clientSecret*.
invalid_grant       | 400                                            | The authorization code is invalid, expired or already used.
invalid_scope       | 400                                            | The requested scope is not available to the application.
unauthorized_client | 400                                            | The grant type is not enabled for the application.

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

  This prevents attackers from stealing tokens from the user's browser history, logs, referrer headers and other insecure locations when credentials are sent via query URLs.
</aside>

## Native Application Flow (PKCE)

Ideal for desktop, command-line and mobile applications — public clients that cannot keep a secret and receive the authorization redirect on a local loopback address.

This flow extends the [Web Application Flow](#web-application-flow) with a Proof Key for Code Exchange ([PKCE, RFC 7636](https://datatracker.ietf.org/doc/html/rfc7636)), which binds the authorization code to a per-attempt secret so that an intercepted code cannot be redeemed by anyone else.

Any authorization redirecting to a loopback _Redirect URL_ (see [Loopback Redirect URLs](#loopback-redirect-urls)) **must** use this flow; the same application's `https` authorizations are unaffected. Applications may additionally be enrolled to require PKCE on every authorization by [contacting us](#support).

### Step 1 - Generate a Proof Key

> Example of generating a verifier and challenge:

```bash
code_verifier=$(openssl rand -base64 32 | tr -d '=' | tr '+/' '-_')
code_challenge=$(printf '%s' "$code_verifier" | openssl dgst -sha256 -binary | openssl base64 | tr -d '=' | tr '+/' '-_')
```

For every authorization attempt, generate a fresh cryptographically random `code_verifier` — 43 to 128 characters from the set `A-Z a-z 0-9 - . _ ~` — and derive the `code_challenge` as the base64url-encoded SHA-256 digest of the verifier.

Only the challenge is sent when starting the flow; the verifier never leaves your application until the token exchange.

### Step 2 - Authorization

> Example of an authorization start URL:

```
https://api.uphold.com/oauth2/authorize/start?client_id=<client_id>&code_challenge=<code_challenge>&code_challenge_method=S256&state=<state_string>&scope=accounts:read%20cards:read
```

Direct the user's browser to the following endpoint, which stores the challenge and redirects the user to the Uphold authorization page:

`GET https://api.uphold.com/oauth2/authorize/start`

Or for Sandbox applications:

`GET https://api-sandbox.uphold.com/oauth2/authorize/start`

Supported query parameters:

Parameter             | Required | Description
--------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------
client_id             | yes      | The application's *clientId*.
code_challenge        | yes      | The base64url-encoded SHA-256 digest of the `code_verifier` (43 characters).
code_challenge_method | yes      | Must be set to *'S256'*.
redirect_uri          | no       | Must match one of the application's registered _Redirect URLs_ (see [Loopback Redirect URLs](#loopback-redirect-urls)). When omitted, the first registered _Redirect URL_ is used.
scope                 | yes      | Permissions to request from the user. Multiple scopes [should be](https://tools.ietf.org/html/rfc6749#section-3.3) separated by spaces.
state                 | yes      | An unguessable, cryptographically secure random string (up to 500 characters), unique per authorization attempt.

The challenge is bound to the (`client_id`, `state`) pair and is valid for **30 minutes**.
Restarting an abandoned authorization with the same `state` and the same challenge is allowed, but reusing a `state` with a *different* challenge fails with an `invalid_request` error until the previous challenge expires — generate a fresh `state` for every attempt.

As in the Web Application Flow, once the user accepts your request they are redirected back to your application with a temporary single-use `code` and the previously provided `state`.

### Step 3 - Requesting a Token

> Exchanging the `code` and `code_verifier` for a `token`:

```bash
curl https://api.uphold.com/oauth2/token \
  -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -u <clientId>:<clientSecret> \
  -d 'code=<code>&code_verifier=<code_verifier>&grant_type=authorization_code'
```

Exchange the code exactly as in the [Web Application Flow](#step-2-requesting-a-token), additionally sending the verifier generated in step 1:

Parameter     | Required | Description
------------- | -------- | -------------------------------------------------------------
code_verifier | yes      | The `code_verifier` this authorization attempt started with.

The API hashes the verifier and compares it against the challenge bound to the code.
A missing or mismatched verifier fails with an `invalid_grant` error **and consumes the code** — the user must go through the authorization flow again.

### Loopback Redirect URLs

Native applications typically listen for the authorization redirect on a random port of the loopback interface, which cannot be known at registration time.

Register a _Redirect URL_ with the `http` scheme and the host `127.0.0.1`, `[::1]` or `localhost` — for example, `http://127.0.0.1:8080/callback`.
During an authorization request, the **port is ignored** when matching a loopback `redirect_uri` against the registered value, following [RFC 8252](https://datatracker.ietf.org/doc/html/rfc8252#section-7.3): a registration of `http://127.0.0.1:8080/callback` matches `http://127.0.0.1:53127/callback`.
The scheme, host, path and query must still match exactly, and the port must be numeric.

<aside class="notice">
  <strong>Important Notice</strong>: Authorizations redirecting to a loopback <i>Redirect URL</i> <strong>always</strong> require PKCE. The application's <code>https</code> <i>Redirect URLs</i> are unaffected, unless the application is enrolled to require PKCE on every authorization.
</aside>

## Client Credentials Flow

Ideal for backend integrations that do not require access to other Uphold user accounts.

For **business usage only** you may choose to use client credentials authentication.
This requires [manual approval](#support) from Uphold.

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
  <strong>Security Notice</strong>: No other method of authentication is supported.
  For security reasons only the "Authorization" header will be processed.
  This prevents attackers from stealing tokens from the user's browser history, logs, referrer headers and other insecure locations when credentials are sent via query URLs.
</aside>

## Personal Access Tokens (PAT)

Ideal for scripts, automated tools and command-line programs which remain under your control.

For **personal usage only** you may choose to use a PAT.
This token establishes who you are, provides full access to your user account and does not expire until revoked.
Authenticating with a PAT does not require a Two Factor Authentication challenge; however, individual operations that require a one-time password — such as creating another PAT or changing your password — will still request one (see [Two-Factor Authentication](#two-factor-authentication)).
For this reason it should be treated just like your email/password combination, i.e. remain secret and never shared with third parties.
PATs can be issued and revoked individually.

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
    "description": "token 1",
    "id": "a97bb994-6e24-4a89-b653-e0a6d0bcf634"
  },
  {
    "description": "token 2",
    "id": "b97bb994-6e24-4a89-b653-e0a6d0bcf635"
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
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -H "OTP-Token: <OTP-Token>" \
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

To create a Personal Access Token you may use the following endpoint, authenticating with an existing access token that is not limited to specific [permissions](#permissions), such as another PAT:

`POST https://api.uphold.com/v0/me/tokens`

Supported parameters:

Parameter   | Required | Description
----------- | -------- | ------------------------------------------------------------
description | yes      | A human-readable description of this PAT (1 to 255 characters).

<aside class="notice">
  Requires the <code>OTP-Token</code> header with a valid one-time password, if Two Factor Authentication is enabled (see <a href="#two-factor-authentication">Two-Factor Authentication</a>).
</aside>

<aside class="notice">
  <strong>Important Notice</strong>: The <code>accessToken</code> value is only returned once, at creation time — store it securely.
  Business accounts cannot create Personal Access Tokens.
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
--------- | -------- | -----------------------------------------------------------------------------------
token     | yes      | The `accessToken` value of the PAT you wish to revoke (not its `id`).

Returns an HTTP status code of `204` and no body in case of success, or a [404 HTTP error](#errors) if the token does not exist.

### Using a PAT

> Example of using a personal access token to make requests to our API:

```bash
curl https://api.uphold.com/v0/me \
  -H "Authorization: Bearer <token>"
```

> Alternatively, a PAT can be sent via HTTP Basic Authentication, using the token as the username and `x-oauth-basic` as the password:

```bash
curl https://api.uphold.com/v0/me \
  -u <token>:x-oauth-basic
```

A PAT may be used for authenticating a request via the OAuth scheme.

The `<token>` should be set as the `accessToken` received during creation.

## Basic Authentication

> Example of listing your authentication methods using email and password:

```bash
curl https://api.uphold.com/v0/me/authentication_methods \
  -u <email>:<password>
```

Authenticating with your email and password combination is restricted to a small set of endpoints used to manage and bootstrap Two Factor Authentication:

- `GET /v0/me/authentication_methods`
- `POST /v0/me/authentication_methods/:id/request_challenge`
- `GET /v0/me/phones`

All other endpoints require an OAuth access token or a [Personal Access Token](#personal-access-tokens-pat).

## Two-Factor Authentication

> Example of a response requiring a one-time password:

```
HTTP/1.1 401 Unauthorized
OTP-Token: required
```

When an operation requires a one-time password (OTP, also known as Two-Factor Authentication), the API responds with a [401 HTTP error](#errors) and the response header `OTP-Token: required`.

In that case, repeat the request with the following headers:

Header        | Required | Description
------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------
OTP-Token     | yes      | The one-time password (verification code).
OTP-Method-Id | no       | The `id` of the [authentication method](#authentication-method-object) to verify against. Only taken into account when the user has no default authentication method; otherwise the default method is always used.

For SMS-based authentication methods, a verification code must first be requested through the [request challenge endpoint](#request-authentication-method-challenge).
