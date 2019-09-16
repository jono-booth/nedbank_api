# NedbankApi
**(Under Construction)**

The purpose of this gem is to streamline development of a Ruby application when using the [Nedbank Marketplace API](https://apim.nedbank.co.za/static/docs).

This gem currently has only the APIs that I need for my project(s). If you are in need of other parts of the API then please feel free to contribute.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nedbank_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nedbank_api

## Usage

### 1) Request token (light)

[Official Documentation](https://apim.nedbank.co.za/static/docs/payments-token)

Using your client ID and client secret (which you obtained when you created an application), you will make a POST request using the endpoint and values below to retrieve a Payment intent access token.

Please note that in order to use this API, you will have to be subscribed to both the Nedbank Authorisation API and this API.

```ruby
$ client = NedbankApi::Client.new(
    client_id: [PROVIDED_CLIENT_ID],
    client_secret: [PROVIDED_CLIENT_SECRET],
    api_url: 'https://api.nedbank.co.za/apimarket/sandbox'
  )
$ client.authenticate!
$ client.authenticated?
#> true
```

If there is an error the error will be returned

```ruby
$ client.authenticated?
#> false
$ p client.error
#> invalid_request
$ p client.error_description
#> 'Invalid Request'
```

### 2) Request Payment intent ID

[Official Documentation](https://apim.nedbank.co.za/static/docs/payments-intent)

Using the Payment intent access token you received in the previous call, proceed to make a payment intent call to receive a Payment ID using the endpoint and values below.


```ruby
$ payment_batch = {
    "Data": {
      "Initiation": {
    ...
    }
  }.to_json

$ payment = client.payment.create_intent(payment_batch)
```

Now the entire response object is available to like so
```ruby
$ p payment.Data.PaymentId
# "456c1abe-9568-4335-a914-73bd1df0085f"
$ p payment.Data.Initiation.InstructedAmount.Amount
# "55.60"
$ p payment.Data.Initiation.InstructedAmount.Currency
# "ZAR"
```

### 3) Get Payments authorization

[Official Documentation](https://apim.nedbank.co.za/static/docs/payments-auth)

To make use of the Payment ID you received in the previous call, add it to the user parameter values found below in the authorization URL to retrieve an access code that you will use to get a heavy/submission token. Make use of the url and values found below.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jono-booth/nedbank_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NedbankApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jono-booth/nedbank_api/blob/master/CODE_OF_CONDUCT.md).
