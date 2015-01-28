# Authentication

Bitreserve is an OAuth 2.0 compliant service.

To use the Bitreserve API, one must present a Personal Access Token (PAT) with each request. This token establishes who you are, and what permissions you have when interacting with the API. There are two types of access tokens: a persistent token that never expires, and temporary tokens that expire after 15 minutes of inactivity. Persistent tokens are ideal for use within an application that is permanently associated with the same Bitreserve account, and for which the collection of a username and password from an end-user is not feasible. Temporary tokens can be generated and bound to any valid Bitreserve account and grants the holder of that token to act on a User's behalf.

If you have OTP (One Time Password, also known as Two-Factor Authentication) enabled, then you will get an HTTP 401 (Unauthorized) response, along with the HTTP header `X-Bitreserve-OTP: Required`. You will then automatically receive an SMS, or Push Notification with your verification code, depending on whether you have the Authy app installed or not. Then execute the command above again, this time passing your OTP verification code as a header, like so: `X-Bitreserve-OTP: <OTP-Token>`.

## OAuth 2.0

We are currently working on providing the Web Application Flow and Non-Web Application Flow. Meanwhile you can use our API using Basic Authentication or create a Personal Access Token.

## Basic Authentication

### Via Username/Email and Password

You can use Basic Authentication using your username or email and password combination. If you have OTP enabled you must send the `X-Bitreserve-OTP` in every request.

> Simple request using username or email and password:

```bash
curl https://api.bitreserve.org/v0/me \
  -H 'X-Bitreserve-OTP: <OTP-Token>' \
  -u <username-or-email>:<password>
```

### Via Personal Access Tokens

We recommend people secure Personal Access Tokens like you would a password. They are functionally equivalent, but have the advantage of being able to to be issued and revoked individually. This means if one of them gets compromised you can revoke it without affecting all the applications or clients within your ecosystem.

> To create a Personal Access Token, execute the following command:

```bash
curl https://api.bitreserve.org/v0/me/tokens \
  -X POST \
  -H 'X-Bitreserve-OTP: <OTP-Token>' \
  -H "Content-Type: application/json" \
  -u <username-or-email>:<password> \
  -d '{ "description": "My command line script" }'
```

> If your request for a token checks out, then our API will return the following:

```json
{
  "access_token": "41ee8b1fa14042e031fe304bb4793b54e6576d19b306dc205136172b80d59d20",
  "description": "My command line script",
  "expires": null
}
```

> Here is an example for using the personal access token to make requests to our API:

```bash
curl https://api.bitreserve.org/v0/me \
  -u 41ee8b1fa14042e031fe304bb4793b54e6576d19b306dc205136172b80d59d20:X-OAuth-Basic
```
