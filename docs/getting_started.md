# Getting Starterd

## Installation

Before you can make a call to any of the APIs, you need to subscribe to the Nedbank Authorisation API.

You will also receive a Client ID and Client Secret for authentication.

Your first step is to setup your environment by adding these credentials to your application configuration.

```ruby
# config/initializers/nedbank_api.rb

NedbankApi.configure do |config|
  config.client_id = [PROVIDED_CLIENT_ID]
  config.client_secret = [PROVIDED_CLIENT_SECRET]
  config.api_endpoint = 'https://api.nedbank.co.za/apimarket/sandbox' # Defatul - optional
end
```
