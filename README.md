# NedbankApi

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

You should already have your client ID and client secret which is generated in the [My Applications](https://apim.nedbank.co.za/application).

### Authenticate
```ruby
$ client = NedbankApi.client.new(client_id: [CLIENT_ID], client_secret: [CLIENT_SECRET])
$ client.authenticate
$ client.authenticated?
#> true
```

### Payments
```ruby
$ client = NedbankApi.client.new(client_id: [CLIENT_ID], client_secret: [CLIENT_SECRET])
$ client.payments.create_intent(payment_batch)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jono-booth/nedbank_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NedbankApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jono-booth/nedbank_api/blob/master/CODE_OF_CONDUCT.md).
