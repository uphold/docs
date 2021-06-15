# One-Time Password

Uphold provides a TOTP (Time-Based One-Time Password) mechanism to secure user accounts.
Adopting and adhering to this mechanism is recommended for safety reasons.
The following section documents how the Authentication Methods API works to provide support for this security mechanism.

## List Authentication Methods

```bash
curl https://api.uphold.com/v0/me/authentication_methods \
  -u <email>:<password>
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
  "type": "authy",
  "verified": true,
  "verifiedAt": "2019-01-11T14:20:04.055Z"
}]
```

Retrieves a list of authentication methods for the current user.

### Request

`GET https://api.uphold.com/v0/me/authentication_methods`

### Response

Returns an array of the current user's authentication methods.

## Add Authentication Method

```bash
curl https://api.uphold.com/v0/me/authentication_methods/totp \
  -X POST \
  -H "Authorization: Bearer <token>" \
  -H 'OTP-Method-Id: <OTP-Method-Id>'
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

`POST https://api.uphold.com/v0/me/authentication_methods/totp`

<aside class="notice">
  Requires the <code>OTP-Method-Id</code> header with the id of a verified authentication method that belongs to the user, and the <code>OTP-Token</code> header with a valid TOTP token associated to that authentication method.
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
  -H "OTP-Method-Id: <Method-Id>" \
  -H "OTP-Token: <OTP-Token>"
```

> The above command does not return a JSON response.

### Request

`DELETE https://api.uphold.com/v0/me/authentication_methods/3f8f8264-2f5e-4b2b-8333-473715ab039a`

<aside class="notice">
  Requires the <code>OTP-Method-Id</code> header to be sent with the id of a verified authentication method that belongs to the user.
</aside>
<aside class="notice">
  Requires the <code>OTP-Token</code> header to be sent with a valid TOTP token, belonging to the authentication method specified in <code>OTP-Method-Id</code>.
</aside>
<aside class="notice">
  You cannot delete all of a user's authentication methods as trying to delete the last verified method of a user will return an error.
</aside>

### Response

Returns an HTTP status code of `204` ([No Content](https://datatracker.ietf.org/doc/html/rfc7231#section-6.3.5))
and no JSON body, in case of success.
