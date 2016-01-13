# Applications

## Registering an application

Developers will need to [register their application](https://uphold.com/dashboard/profile/applications/developer/new) before getting started. A registered application will be assigned a unique *Client Id* and *Client Secret*.

<aside class="notice">
  <strong>Security Notice</strong>: Your <i>Client Secret</i> should never be shared, must be kept secret at all times and should only be used from your server-side application.
</aside>

## Considerations

* For security reasons, your application **must** be secured with a valid *SSL* certificate issued by a known Certificate Authority.
* Likewise, the provided *Redirect URL* when registering the application must be a valid static subresource. Notice that this property cannot be dynamically reconfigured during authorization requests for security reasons.
* Users can revoke access to your application at any time. Your application **must** be prepared for this and, if necessary, should request authorization from the user again.
* Your application may be suspended in an automated fashion in accordance with our [Terms of Service](https://uphold.com/en/legal/membership-agreement).
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
transactions:deposit | Can create a deposit [transaction](#transaction-object).
transactions:read | Can view any [transaction](#transaction-object).
transactions:send | Can create a [transaction](#transaction-object) between different users (including invites).
transactions:transfer | Can create a [transaction](#transaction-object) between a user's cards.
transactions:withdraw | Can create a withdrawal [transaction](#transaction-object).
transactions:write | Can create a [transaction](#transaction-object) from any card to any destination (another card or an external address), cancel and resend transactions. This scope will be deprecated in the future in favor of the more fine-grained write scopes above (deposit, send, transfer and withdraw).
user:read | Can view the [user](#user-object) and their information.

<aside class="notice">
  <strong>Important Notice</strong>: Only specify scopes that your application absolutely needs.

  You can always request more scopes later by asking for user consent again.
</aside>

## Resources

We prefer that you use these image resources when connecting your applications to Uphold.

<img alt="Connect Button" src="uphold-connect-white@1x.png" srcset="uphold-connect-white@1x.png 1x, images/buttons/uphold-connect-white@2x.png 2x"><br>
[small (125x41)](uphold-connect-white@1x.png), [large (249x82)](images/buttons/uphold-connect-white@2x.png)

<img alt="Connect Button" src="uphold-connect-with-white@1x.png" srcset="uphold-connect-with-white@1x.png 1x, images/buttons/uphold-connect-with-white@2x.png 2x"><br>
[small (206x41)](uphold-connect-with-white@1x.png), [large (412x82)](images/buttons/uphold-connect-with-white@2x.png)

<img alt="Connect Button" src="uphold-powered-white@1x.png" srcset="uphold-powered-white@1x.png 1x, images/buttons/uphold-powered-white@2x.png 2x"><br>
[small (199x41)](uphold-powered-white@1x.png), [large (397x82)](images/buttons/uphold-powered-white@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-gray@1x.png" srcset="images/buttons/uphold-connect-gray@1x.png 1x, images/buttons/uphold-connect-gray@2x.png 2x"><br>
[small (125x41)](images/buttons/uphold-connect-gray@1x.png), [large (249x82)](images/buttons/uphold-connect-gray@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-with-gray@1x.png" srcset="images/buttons/uphold-connect-with-gray@1x.png 1x, images/buttons/uphold-connect-with-gray@2x.png 2x"><br>
[small (206x41)](images/buttons/uphold-connect-with-gray@1x.png), [large (412x82)](images/buttons/uphold-connect-with-gray@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-gray@1x.png" srcset="images/buttons/uphold-powered-gray@1x.png 1x, images/buttons/uphold-powered-gray@2x.png 2x"><br>
[small (199x41)](images/buttons/uphold-powered-gray@1x.png), [large (397x82)](images/buttons/uphold-powered-gray@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-green@1x.png" srcset="images/buttons/uphold-connect-green@1x.png 1x, images/buttons/uphold-connect-green@2x.png 2x"><br>
[small (124x40)](images/buttons/uphold-connect-green@1x.png), [large (247x80)](images/buttons/uphold-connect-green@2x.png)

<img alt="Connect Button" src="uphold-connect-with-green@1x.png" srcset="uphold-connect-with-green@1x.png 1x, images/buttons/uphold-connect-with-green@2x.png 2x"><br>
[small (205x40)](uphold-connect-with-green@1x.png), [large (410x80)](images/buttons/uphold-connect-with-green@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-green@1x.png" srcset="images/buttons/uphold-powered-green@1x.png 1x, images/buttons/uphold-powered-green@2x.png 2x"><br>
[small (198x40)](images/buttons/uphold-powered-green@1x.png), [large (395x80)](images/buttons/uphold-powered-green@2x.png)

<img alt="Connect Button" src="uphold-connect-white-gray@1x.png" srcset="uphold-connect-white-gray@1x.png 1x, images/buttons/uphold-connect-white-gray@2x.png 2x"><br>
[small (125x41)](uphold-connect-white-gray@1x.png), [large (249x82)](images/buttons/uphold-connect-white-gray@2x.png)

<img alt="Connect Button" src="uphold-connect-with-white-gray@1x.png" srcset="uphold-connect-with-white-gray@1x.png 1x, images/buttons/uphold-connect-with-white-gray@2x.png 2x"><br>
[small (206x41)](uphold-connect-with-white-gray@1x.png), [large (412x82)](images/buttons/uphold-connect-with-white-gray@2x.png)

<img alt="Connect Button" src="uphold-powered-white-gray@1x.png" srcset="uphold-powered-white-gray@1x.png 1x, images/buttons/uphold-powered-white-gray@2x.png 2x"><br>
[small (199x41)](uphold-powered-white-gray@1x.png), [large (397x82)](images/buttons/uphold-powered-white-gray@2x.png)

<img alt="Connect Button" src="uphold-powered-transparent@1x.png" srcset="uphold-powered-transparent@1x.png 1x, images/buttons/uphold-powered-transparent@2x.png 2x"><br>
[small (129x50)](uphold-powered-transparent@1x.png), [large (258x100)](images/buttons/uphold-powered-transparent@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-transparent-green@1x.png" srcset="images/buttons/uphold-powered-transparent-green@1x.png 1x, images/buttons/uphold-powered-transparent-green@2x.png 2x"><br>
[small (129x50)](images/buttons/uphold-powered-transparent-green@1x.png), [large (258x100)](images/buttons/uphold-powered-transparent-green@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-transparent-gray@1x.png" srcset="images/buttons/uphold-powered-transparent-gray@1x.png 1x, images/buttons/uphold-powered-transparent-gray@2x.png 2x"><br>
[small (129x50)](images/buttons/uphold-powered-transparent-gray@1x.png), [large (258x100)](images/buttons/uphold-powered-transparent-gray@2x.png)
