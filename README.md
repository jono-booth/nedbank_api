# NedbankApi
**(Under Construction)**

The purpose of this gem is to streamline development of a Ruby application when using the [Nedbank Marketplace API](https://apim.nedbank.co.za/static/docs).

This gem currently has only the APIs that I need for my project(s). If you are in need of other parts of the API then please feel free to contribute.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nedbank_api', github: 'jono-booth/nedbank_api'
```

And then execute:

    $ bundle

## Documentation

1. [Getting Started](docs/getting_started.md)
2. [Authorisation API](docs/authorisations_api.md)
3. [Payments API](docs/payments_api.md)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jono-booth/nedbank_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NedbankApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jono-booth/nedbank_api/blob/master/CODE_OF_CONDUCT.md).
