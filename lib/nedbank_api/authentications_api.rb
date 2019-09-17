module NedbankApi
  class AuthenticationsApi < ApiWrapper
    def request_token_light
      http = Http.new(url: endpoint('/nboauth/oauth20/token'))

      response = http.post(
        body: URI.encode_www_form({
          client_id: NedbankApi.client_id,
          client_secret: NedbankApi.client_secret,
          grant_type: 'client_credentials',
          scope: 'tpp_client_credential'
        })
      )

      intent_token = Models::IntentToken.new(JSON.parse(response.body, object_class: OpenStruct))

      NedbankApi.access_token = intent_token.access_token

      return intent_token
    end

    def request_token_heavy(request_body:)
      http = Http.new(url: endpoint('/nboauth/oauth20/token'))

      response = http.post(
        body: URI.encode_www_form({
          client_id: NedbankApi.client_id,
          client_secret: NedbankApi.client_secret,
          grant_type: 'authorization_code',
        }.merge(request_body))
      )

      return Models::IntentToken.new(JSON.parse(response.body, object_class: OpenStruct))
    end
  end
end