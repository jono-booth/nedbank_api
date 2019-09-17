# Authorisations API

[Official Documentation](https://apim.nedbank.co.za/static/docs/payments-auth)

## Request token (light)

Before you can make a call to any of the APIs, you need to subscribe to the Nedbank Authorisation API. This call will let you create an intent token which you will use to call the intent operation of the API you want to use.

```ruby
$ token = NedbankApi::AuthorisationsApi.new.request_token_light
$ token.authenticated?
#> true
$ token.access_token
#> "TEMPACCESSTOKEN"
```

If there is an error the error will be returned

```ruby
$ token.authenticated?
#> false
$ p token.error
#> invalid_request
$ p token.error_description
#> 'Invalid Request'
```
