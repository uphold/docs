# Applications

## Registering an application

Developers will need to [register their application](https://support.uphold.com/hc/en-us/articles/217210266) before getting started. A registered application will be assigned a unique _Client Id_ and _Client Secret_.

<aside class="notice">
  <strong>Security Notice</strong>: Your <i>Client Secret</i> should never be shared, must be kept secret at all times and should only be used from your server-side application.
</aside>

## Considerations

- For security reasons, your application **must** be secured with a valid _SSL_ certificate issued by a known Certificate Authority.
- Likewise, the provided _Redirect URL_ when registering the application must be a valid static subresource. Notice that this property cannot be dynamically reconfigured during authorization requests for security reasons.
- The _Redirect URL_ can also be a valid URI with a non-http/https protocol which is useful for mobile and desktop applications, for example: `my-app://uphold/connect`.
- Users can revoke access to your application at any time. Your application **must** be prepared for this and, if necessary, should request authorization from the user again.
- Likewise, when users change their password, all authorization tokens are expired and the user enters a cool-down period where outbound transactions are not allowed, for security reasons. Your application **must** be prepared for this.
- Your application may be suspended in an automated fashion in accordance with our [Terms of Service](https://uphold.com/en/legal/membership-agreement).
- Standard [rate limits](#rate-limits) apply to all issued access tokens.

## Permissions

When requesting authorization from a user the application must specify the level of access needed. These _scopes_ are displayed to the user on the authorization form and currently the user cannot opt-out of individual scopes.

The API supports the following _scopes_:

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

<img alt="Connect" src="images/buttons/green_bg/connect.png" srcset="images/buttons/green_bg/connect.png 1x, images/buttons/green_bg/connect@2x.png 2x"><br> [small (129x40)](images/buttons/green_bg/connect.png), [large (258x80)](images/buttons/green_bg/connect@2x.png), [vector (SVG)](images/buttons/green_bg/connect.svg)

<img alt="Connect with Uphold" src="images/buttons/green_bg/connect_with_uphold.png" srcset="images/buttons/green_bg/connect_with_uphold.png 1x, images/buttons/green_bg/connect_with_uphold@2x.png 2x"><br> [small (206x40)](images/buttons/green_bg/connect_with_uphold.png), [large (412x80)](images/buttons/green_bg/connect_with_uphold@2x.png), [vector (SVG)](images/buttons/green_bg/connect_with_uphold.svg)

<img alt="Powered by Uphold" src="images/buttons/green_bg/powered_by_uphold.png" srcset="images/buttons/green_bg/powered_by_uphold.png 1x, images/buttons/green_bg/powered_by_uphold@2x.png 2x"><br> [small (199x40)](images/buttons/green_bg/powered_by_uphold.png), [large (398x80)](images/buttons/green_bg/powered_by_uphold@2x.png), [vector (SVG)](images/buttons/green_bg/powered_by_uphold.svg)

<img alt="Connect" src="images/buttons/white_bg/connect.png" srcset="images/buttons/white_bg/connect.png 1x, images/buttons/white_bg/connect@2x.png 2x"><br> [small (129x40)](images/buttons/white_bg/connect.png), [large (258x80)](images/buttons/white_bg/connect@2x.png), [vector (SVG)](images/buttons/white_bg/connect.svg)

<img alt="Connect with Uphold" src="images/buttons/white_bg/connect_with_uphold.png" srcset="images/buttons/white_bg/connect_with_uphold.png 1x, images/buttons/white_bg/connect_with_uphold@2x.png 2x"><br> [small (206x40)](images/buttons/white_bg/connect_with_uphold.png), [large (412x80)](images/buttons/white_bg/connect_with_uphold@2x.png), [vector (SVG)](images/buttons/white_bg/connect_with_uphold.svg)

<img alt="Powered by Uphold" src="images/buttons/white_bg/powered_by_uphold.png" srcset="images/buttons/white_bg/powered_by_uphold.png 1x, images/buttons/white_bg/powered_by_uphold@2x.png 2x"><br> [small (199x40)](images/buttons/white_bg/powered_by_uphold.png), [large (398x80)](images/buttons/white_bg/powered_by_uphold@2x.png), [vector (SVG)](images/buttons/white_bg/powered_by_uphold.svg)
