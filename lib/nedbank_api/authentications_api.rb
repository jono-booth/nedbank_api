module NedbankApi
  class AuthenticationsApi < ApiWrapper
    def request_token
      http = Http.new(url: endpoint('/nboauth/oauth20/token'))

      response = http.post(
        body: URI.encode_www_form({
          client_id: @client_id,
          client_secret: @client_secret,
          grant_type: 'client_credentials',
          scope: 'tpp_client_credential'
        })
      )

      return Models::IntentToken.new(JSON.parse(response.body, object_class: OpenStruct))
    end
  end
end
