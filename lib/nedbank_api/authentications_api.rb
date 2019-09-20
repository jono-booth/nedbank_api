module NedbankApi
  class AuthenticationsApi < ApiWrapper
    class << self
      API_PATHS = {
        request_token: 'nboauth/oauth20/token',
        authorise: 'nboauth/oauth20/authorize'
      }

      def request_token_light
        http = Http.new(url: endpoint(API_PATHS[:request_token]))

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
        http = Http.new(url: endpoint(API_PATHS[:request_token]))

        response = http.post(
          body: URI.encode_www_form({
            client_id: NedbankApi.configuration.client_id,
            client_secret: NedbankApi.configuration.client_secret,
            redirect_uri: NedbankApi.configuration.oauth_redirect_url,
            grant_type: 'authorization_code',
          }.merge(request_body))
        )

        intent_token = Models::IntentToken.new(JSON.parse(response.body, object_class: OpenStruct))

        NedbankApi.intent_token = intent_token

        return intent_token
      end

      def authorisation_url(request_body: {})
        url = endpoint(API_PATHS[:authorise])

        body = URI.encode_www_form({
            client_id: NedbankApi.configuration.client_id,
            redirect_uri: NedbankApi.configuration.oauth_redirect_url,
            response_type: 'code',
            scope: 'payments',
            itype: 'payments'
        }.merge(request_body))

        return "#{url}?#{body}"
      end
    end
  end
end
