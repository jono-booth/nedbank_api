module NedbankApi
  class Client

    DEFAULT_API_BASE = 'https://api.nedbank.co.za/apimarket/sandbox'

    def initialize(client_id:, client_secret:, api_base: DEFAULT_API_BASE)
      NedbankApi.client_id = client_id
      NedbankApi.client_secret = client_secret
      NedbankApi.api_base = api_base
    end

    def authentication
      @_authentication ||= AuthenticationsApi.new
    end

    def payment
      @_payment ||= PaymentsApi.new
    end
  end
end
