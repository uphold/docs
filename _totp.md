# One-Time Password

Uphold supports one-time passwords through authenticator apps (TOTP — Time-Based One-Time Password) and SMS to secure user accounts.
Adopting and adhering to this mechanism is recommended for safety reasons.
The following section documents how the Authentication Methods API works to provide support for this security mechanism.

## List Authentication Methods

```bash
curl https://api.uphold.com/v0/me/authentication_methods \
  -H "Authorization: Bearer <token>"
```

> The above command returns the following JSON:

```json
[{
  "default": false,
  "id": "3f8f8264-2f5e-4b2b-8333-473715ab039a",
  "label": "Authenticator TOTP",
  "type": "totp",
  "verified": true,
  "verifiedAt": "2019-02-11T14:31:48.485Z"
},
{
  "default": true,
  "id": "be95ed5f-d048-4348-9572-411df23bedc9",
  "label": "+XXXXXXXXXX57",
  "type": "sms",
  "verified": true,
  "verifiedAt": "2019-01-11T14:20:04.055Z"
}]
```

Retrieves a list of authentication methods for the current user.

Requests authenticated with email and password (see [Basic Authentication](#basic-authentication)) receive a reduced set of fields — `default`, `id`, `label`, `type` and `verified` — and only include verified authentication methods.

### Request

`GET https://api.uphold.com/v0/me/authentication_methods`

### Response

Returns an array of the current user's authentication methods.

## Add Authentication Method

```bash
curl https://api.uphold.com/v0/me/authentication_methods/totp \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H 'OTP-Token: <OTP-Token>'
```

> The above command returns the following JSON:

```json
{
  "default": false,
  "id": "3f8f8264-2f5e-4b2b-8333-473715ab039a",
  "label": "Authenticator TOTP",
  "type": "totp",
  "url": "otpauth://totp/Uphold:han.solo@rebelalliance.org?algorithm=SHA1&digits=6&issuer=Uphold&period=30&secret=QRV62S3O6LXDB7FRKR4LMF3VGR6MZT7S",
  "verified": false,
  "verifiedAt": null
}
```

### Request

`POST https://api.uphold.com/v0/me/authentication_methods/:type`

Where `:type` is one of:

Type | Description
---- | ------------------------------------------------------------------------------
sms  | Enrolls the user's primary phone number to receive verification codes via SMS.
totp | Registers an authenticator app (Time-Based One-Time Password).

<aside class="notice">
  Requires the <code>OTP-Token</code> header with a valid one-time password, if Two Factor Authentication is already enabled (see <a href="#two-factor-authentication">Two-Factor Authentication</a>).
</aside>

### Response

Returns a fully formed [Authentication Method](#authentication-method-object) representing the authentication method created.

## Verify Authentication Method

```bash
curl https://api.uphold.com/v0/me/authentication_methods/3f8f8264-2f5e-4b2b-8333-473715ab039a/verify \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "token": "<OTP-Token>" }'
```

> The above command returns the following JSON:

```json
{
  "default": false,
  "id": "3f8f8264-2f5e-4b2b-8333-473715ab039a",
  "label": "Authenticator TOTP",
  "type": "totp",
  "verified": true,
  "verifiedAt": "2019-02-11T14:31:48.485Z"
}
```

### Request

`POST https://api.uphold.com/v0/me/authentication_methods/:id/verify`

### Response

Returns an [Authentication Method](#authentication-method-object) object representing the verified authentication method.

## Remove Authentication Method

```bash
curl https://api.uphold.com/v0/me/authentication_methods/3f8f8264-2f5e-4b2b-8333-473715ab039a \
  -X DELETE \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -H "OTP-Token: <OTP-Token>"
```

> The above command does not return a JSON response.

### Request

`DELETE https://api.uphold.com/v0/me/authentication_methods/:id`

<aside class="notice">
  Requires the <code>OTP-Token</code> header with a valid one-time password only when the user has no default authentication method.
</aside>
<aside class="notice">
  The default authentication method cannot be deleted — attempting to do so returns a <a href="#errors">403 HTTP error</a>.
</aside>

### Response

Returns an HTTP status code of <code>204</code> and no JSON body, in case of success.

## Request Authentication Method Challenge

```bash
curl https://api.uphold.com/v0/me/authentication_methods/be95ed5f-d048-4348-9572-411df23bedc9/request_challenge \
  -X POST \
  -u <email>:<password>
```

> The above command does not return a JSON response.

Requests the delivery of a verification code through the given authentication method. This is only supported for `sms` authentication methods — other method types return a [422 HTTP error](#errors).

This endpoint can be authenticated with basic authentication (email and password) or with an access token that is not limited to specific [permissions](#permissions), such as a [Personal Access Token](#personal-access-tokens-pat), so that a verification code can be obtained before completing a two-factor authentication challenge.

### Request

`POST https://api.uphold.com/v0/me/authentication_methods/:id/request_challenge`

<aside class="notice">
  This endpoint is strictly <a href="#rate-limits">rate limited</a>.
</aside>

### Response

Returns an HTTP status code of <code>204</code> and no JSON body, in case of success.
