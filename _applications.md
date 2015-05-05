# Applications

## Registering an application

Developers will need to [register their application](https://bitreserve.org/dashboard/profile/applications/developer/new) before getting started. A registered application will be assigned a unique *Client Id* and *Client Secret*.

<aside class="notice">
**Security Notice**: Your *Client Secret* should never be shared, must be kept secret at all times and should only be used from your server-side application.
</aside>

## Considerations

* For security reasons, your application **must** be secured with a valid *SSL* certificate issued by a known Certificate Authority.
* Likewise, the provided *Redirect URL* when registering the application must be a valid static subresource. Notice that this property cannot be dynamically reconfigured during authorization requests for security reasons.
* Users can revoke access to your application at any time. Your application **must** be prepared for this and, if necessary, should request authorization from the user again.
* Your application may be suspended in an automated fashion in accordance with our [Terms of Service](https://bitreserve.org/en/tos).
* Standard [rate limits](#rate-limits) apply to all issued access tokens.

## Permissions

When requesting authorization from a user the application must specify the level of access needed. These *scopes* are displayed to the user on the authorization form and currently the user cannot opt-out of individual scopes.

The following *scopes* are supported by the API:

Scope |  Description
--------- | -----------
cards:read | Can view all [cards](#card-object) and their information.
cards:write | Can create and update any [card](#card-object).
contacts:read | Can view all [contacts](#contact-object) and their information.
contacts:write | Can create and update any [contact](#contact-object).
transactions:read | Can view any [transaction](#transaction-object).
transactions:write | Can create a [transaction](#transaction-object) from any card to any destination (another card or an external address), cancel and resend transactions.
user:read | Can view the [user](#user-object) and their information.

<aside class="notice">
**Important Notice**: Only specify scopes that your application absolutely needs.

You can always request more scopes later by asking for user consent again.
</aside>
