module NedbankApi
  class ApiWrapper
    attr_accessor :endpoint

    def initialize(client:)
      @api_url = client.api_url
      @client_id = client.client_id
      @client_secret = client.client_secret
      @access_token = client.access_token
    end

    def idempotency_key
      @idempotency_key ||= rand.to_s[2..24]
    end

    def auth_headers(overrides={})
      {
        "Content-Type" => "application/json",
        "accept" => 'application/json',
        "x-fapi-financial-id" => "OB/2017/001",
        "x-idempotency-key" => idempotency_key,
        "Authorization" => "Bearer #{@access_token}",
        "x-ibm-client-id" => @client_id,
        "x-ibm-client-secret" => @client_secret
      }.merge(overrides)
    end

    def endpoint(path)
      @api_url + path
    end
  end
end
