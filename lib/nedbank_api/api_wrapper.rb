module NedbankApi
  class ApiWrapper
    class << self
      def auth_headers(overrides={})
        {
          "Content-Type" => "application/json",
          "accept" => 'application/json',
          "x-fapi-financial-id" => "OB/2017/001",
          "x-idempotency-key" => idempotency_key,
          "Authorization" => "Bearer #{NedbankApi.intent_token.access_token}",
          "x-ibm-client-id" => NedbankApi.configuration.client_id,
          "x-ibm-client-secret" => NedbankApi.configuration.client_secret
        }.merge(overrides)
      end

      def idempotency_key
        rand.to_s[2..24]
      end

      def endpoint(path, suffix: nil)
        [NedbankApi.configuration.api_endpoint, path, suffix].compact.join('/')
      end

      def json_to_object(json)
        JSON.parse(json, object_class: OpenStruct)
      end
    end
  end
end
