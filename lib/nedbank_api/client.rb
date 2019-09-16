module NedbankApi
  class Client
    attr_accessor :intent
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :api_url

    def initialize(client_id:, client_secret:, api_url:)
      @client_id = client_id
      @client_secret = client_secret
      @api_url = api_url
    end

    def authenticate!
      self.intent = AuthenticationsApi.new(client: self).request_token
    end

    def authenticated?
      return false if self.intent.nil?
      self.intent.authenticated?
    end

    def access_token
      return nil if self.intent.nil?
      self.intent.access_token
    end

    def payment
      PaymentsApi.new(client: self)
    end
  end
end
