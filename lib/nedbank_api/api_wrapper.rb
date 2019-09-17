module NedbankApi
  class ApiWrapper
    attr_accessor :endpoint
    def idempotency_key
      @idempotency_key ||= rand.to_s[2..24]
    end

    def auth_headers(overrides={})
      {
        "Content-Type" => "application/json",
        "accept" => 'application/json',
        "x-fapi-financial-id" => "OB/2017/001",
        "x-idempotency-key" => idempotency_key,
        "Authorization" => "Bearer #{NedbankApi.access_token}",
        "x-ibm-client-id" => NedbankApi.client_id,
        "x-ibm-client-secret" => NedbankApi.client_secret
      }.merge(overrides)
    end

    def endpoint(path)
      NedbankApi.api_base + path
    end

    def json_to_object(json)
      JSON.parse(json, object_class: OpenStruct)
    end
  end
end
