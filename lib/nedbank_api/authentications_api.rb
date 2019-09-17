module NedbankApi
  class AuthenticationsApi < ApiWrapper
    class << self
      def request_token_light
        http = Http.new(url: endpoint('/nboauth/oauth20/token'))

        response = http.post(
          body: URI.encode_www_form({
            client_id: NedbankApi.configuration.client_id,
            client_secret: NedbankApi.configuration.client_secret,
            grant_type: 'client_credentials',
            scope: 'tpp_client_credential'
          })
        )

        intent_token = Models::IntentToken.new(JSON.parse(response.body, object_class: OpenStruct))

        NedbankApi.intent_token = intent_token

        return intent_token
      end

      def request_token_heavy(request_body: {})
        http = Http.new(url: endpoint('/nboauth/oauth20/token'))

        response = http.post(
          body: URI.encode_www_form({
            client_id: NedbankApi.configuration.client_id,
            client_secret: NedbankApi.configuration.client_secret,
            grant_type: 'authorization_code',
          }.merge(request_body))
        )

        NedbankApi.intent_token = intent_token

        return Models::IntentToken.new(JSON.parse(response.body, object_class: OpenStruct))
      end

      def authorise_intent(request_body: {})
        http = Http.new(url: endpoint('/nboauth/oauth20/authorize'))

        body = URI.encode_www_form({
            response_type: 'code',
            scope: 'payments',
            client_id: NedbankApi.configuration.client_id,
            type: 'payments',
            state: 'payments'
        }.merge(request_body))

        response = http.post(
          headers: { "accept" => 'text/html' },
          body: body
        )

        return response.body
      end
    end
  end
end
