module NedbankApi
  class Client

    attr_accessor :intent_token

    ENDPOINTS = {
      authorisation: '/nboauth/oauth20/token',
      payments: '/open-banking/payments'
    }

    def initialize(client_id:, client_secret:)
      @client_id = client_id
      @client_secret = client_secret
    end

    def authenticate
      http = Http.new(url: ENDPOINTS[:authorisation])

      response = http.post(body: {
        client_id: @client_id,
        client_secret: @client_secret,
        grant_type: 'client_credentials',
        scope: 'tpp_client_credential'
      })

      self.intent_token = ResponseObjects::IntentToken.new(JSON.parse(response, object_class: OpenStruct))
    end
  end
end
