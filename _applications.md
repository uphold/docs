# Applications
## Registering an application
Developers will need to [register their application](https://uphold.com/dashboard/profile/applications/developer/new) before getting started. A registered application will be assigned a unique _Client Id_ and _Client Secret_.
<aside class="notice">
  <strong>Security Notice</strong>: Your <i>Client Secret</i> should never be shared, must be kept secret at all times and should only be used from your server-side application.
</aside>

## Considerations
- For security reasons, your application **must** be secured with a valid _SSL_ certificate issued by a known Certificate Authority.
- Likewise, the provided _Redirect URL_ when registering the application must be a valid static subresource. Notice that this property cannot be dynamically reconfigured during authorization requests for security reasons.
- The _Redirect URL_ can also be a valid URI with a non-http/https protocol which is useful for mobile and desktop applications, for example: `my-app://uphold/connect`.
- Users can revoke access to your application at any time. Your application **must** be prepared for this and, if necessary, should request authorization from the user again.
- Your application may be suspended in an automated fashion in accordance with our [Terms of Service](https://uphold.com/en/legal/membership-agreement).
- Standard [rate limits](#rate-limits) apply to all issued access tokens.

## Permissions
When requesting authorization from a user the application must specify the level of access needed. These _scopes_ are displayed to the user on the authorization form and currently the user cannot opt-out of individual scopes.

The following _scopes_ are supported by the API:

Scope                             | Description
--------------------------------- | -------------------------------------------------------------------------------------
accounts:read                     | Can view all [accounts](#account-object) and their information.
cards:read                        | Can view all [cards](#card-object) and their information.
cards:write                       | Can create and update any [card](#card-object).
contacts:read                     | Can view all [contacts](#contact-object) and their information.
contacts:write                    | Can create and update any [contact](#contact-object).
transactions:deposit              | Can create a deposit [transaction](#transaction-object).
transactions:read                 | Can view any [transaction](#transaction-object).
transactions:transfer:application | Can create a [transaction](#transaction-object) between the user and the application.
transactions:transfer:others      | Can create a [transaction](#transaction-object) between different users.
transactions:transfer:self        | Can create a [transaction](#transaction-object) between a user's cards.
transactions:withdraw             | Can create a withdrawal [transaction](#transaction-object).
user:read                         | Can view the [user](#user-object) and their information.

### Deprecated scopes
The following _scopes_ are deprecated and will be removed in a future version of the API:

Scope              | Description
------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
transactions:write | Can create a [transaction](#transaction-object) from any origin to any destination (another card or an external address), cancel and resend transactions. This scope is now deprecated in favor of the more fine-grained write scopes above (deposit, transfer and withdraw).

<aside class="notice">
  <strong>Important Notice</strong>: Only specify scopes that your application absolutely needs.

  You can always request more scopes later by asking for user consent again.
</aside>

## Resources
We prefer that you use these image resources when connecting your applications to Uphold.

<img alt="Connect Button" src="images/buttons/uphold-connect-white@1x.png" srcset="images/buttons/uphold-connect-white@1x.png 1x, images/buttons/uphold-connect-white@2x.png 2x"><br> [small (125x41)](images/buttons/uphold-connect-white@1x.png), [large (249x82)](images/buttons/uphold-connect-white@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-with-white@1x.png" srcset="images/buttons/uphold-connect-with-white@1x.png 1x, images/buttons/uphold-connect-with-white@2x.png 2x"><br> [small (206x41)](images/buttons/uphold-connect-with-white@1x.png), [large (412x82)](images/buttons/uphold-connect-with-white@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-white@1x.png" srcset="images/buttons/uphold-powered-white@1x.png 1x, images/buttons/uphold-powered-white@2x.png 2x"><br> [small (199x41)](images/buttons/uphold-powered-white@1x.png), [large (397x82)](images/buttons/uphold-powered-white@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-gray@1x.png" srcset="images/buttons/uphold-connect-gray@1x.png 1x, images/buttons/uphold-connect-gray@2x.png 2x"><br> [small (125x41)](images/buttons/uphold-connect-gray@1x.png), [large (249x82)](images/buttons/uphold-connect-gray@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-with-gray@1x.png" srcset="images/buttons/uphold-connect-with-gray@1x.png 1x, images/buttons/uphold-connect-with-gray@2x.png 2x"><br> [small (206x41)](images/buttons/uphold-connect-with-gray@1x.png), [large (412x82)](images/buttons/uphold-connect-with-gray@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-gray@1x.png" srcset="images/buttons/uphold-powered-gray@1x.png 1x, images/buttons/uphold-powered-gray@2x.png 2x"><br> [small (199x41)](images/buttons/uphold-powered-gray@1x.png), [large (397x82)](images/buttons/uphold-powered-gray@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-green@1x.png" srcset="images/buttons/uphold-connect-green@1x.png 1x, images/buttons/uphold-connect-green@2x.png 2x"><br> [small (124x40)](images/buttons/uphold-connect-green@1x.png), [large (247x80)](images/buttons/uphold-connect-green@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-with-green@1x.png" srcset="images/buttons/uphold-connect-with-green@1x.png 1x, images/buttons/uphold-connect-with-green@2x.png 2x"><br> [small (205x40)](images/buttons/uphold-connect-with-green@1x.png), [large (410x80)](images/buttons/uphold-connect-with-green@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-green@1x.png" srcset="images/buttons/uphold-powered-green@1x.png 1x, images/buttons/uphold-powered-green@2x.png 2x"><br> [small (198x40)](images/buttons/uphold-powered-green@1x.png), [large (395x80)](images/buttons/uphold-powered-green@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-white-gray@1x.png" srcset="images/buttons/uphold-connect-white-gray@1x.png 1x, images/buttons/uphold-connect-white-gray@2x.png 2x"><br> [small (125x41)](images/buttons/uphold-connect-white-gray@1x.png), [large (249x82)](images/buttons/uphold-connect-white-gray@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-connect-with-white-gray@1x.png" srcset="images/buttons/uphold-connect-with-white-gray@1x.png 1x, images/buttons/uphold-connect-with-white-gray@2x.png 2x"><br> [small (206x41)](images/buttons/uphold-connect-with-white-gray@1x.png), [large (412x82)](images/buttons/uphold-connect-with-white-gray@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-white-gray@1x.png" srcset="images/buttons/uphold-powered-white-gray@1x.png 1x, images/buttons/uphold-powered-white-gray@2x.png 2x"><br> [small (199x41)](images/buttons/uphold-powered-white-gray@1x.png), [large (397x82)](images/buttons/uphold-powered-white-gray@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-transparent@1x.png" srcset="images/buttons/uphold-powered-transparent@1x.png 1x, images/buttons/uphold-powered-transparent@2x.png 2x"><br> [small (129x50)](images/buttons/uphold-powered-transparent@1x.png), [large (258x100)](images/buttons/uphold-powered-transparent@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-transparent-green@1x.png" srcset="images/buttons/uphold-powered-transparent-green@1x.png 1x, images/buttons/uphold-powered-transparent-green@2x.png 2x"><br> [small (129x50)](images/buttons/uphold-powered-transparent-green@1x.png), [large (258x100)](images/buttons/uphold-powered-transparent-green@2x.png)

<img alt="Connect Button" src="images/buttons/uphold-powered-transparent-gray@1x.png" srcset="images/buttons/uphold-powered-transparent-gray@1x.png 1x, images/buttons/uphold-powered-transparent-gray@2x.png 2x"><br> [small (129x50)](images/buttons/uphold-powered-transparent-gray@1x.png), [large (258x100)](images/buttons/uphold-powered-transparent-gray@2x.png)
