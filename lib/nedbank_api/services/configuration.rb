module NedbankApi
  class Configuration

    attr_accessor :client_id,
      :client_secret,
      :api_endpoint

    API_ENDPOINT = 'https://api.nedbank.co.za/apimarket/sandbox'

    def initialize
      @client_id = nil
      @client_secret = nil
      @api_endpoint = API_ENDPOINT
    end
  end
end
