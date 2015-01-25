# Changelog

**2015-01-23**

* [Transactions](#transactions) `ttl` is now returned in milliseconds instead of seconds for increased accuracy. Additionally, instead of returning a response with a 503 status code when creating a transaction for a pair that is unavailable, a transaction with a `ttl` of `0` will be returned instead. This allows for a transaction to be previewed, but not executed.
* Added endpoint for [cancelling](#cancel-a-transaction) a transaction.
* Added endpoint for [resending](#resend-a-transaction) a transaction.
* Renamed the [create](#step-1-create-transaction) transaction endpoint from `POST /transactions/new` to `POST /transactions`.
* Renamed the [execute](#step-2-commit-transaction) transaction endpoint from `POST /transactions` to `POST /transactions/:id/commit`.
* Fixed a typo in the [OAuth](#via-personal-access-tokens) token endpoint URL.

**2014-11-28**

* [Tickers](#tickers) are now returned as collections instead of objects.
* A global rate limit has been introduced.
