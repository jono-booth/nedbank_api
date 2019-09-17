module NedbankApi
  class Client

    def initialize(client_id:, client_secret:, api_base: DEFAULT_API_BASE)
      NedbankApi.client_id = client_id
      NedbankApi.client_secret = client_secret
      NedbankApi.api_base = api_base unless api_base.nil?
    end

    def authentication
      @_authentication ||= AuthenticationsApi.new
    end

    def payment
      @_payment ||= PaymentsApi.new
    end
  end
end
