module NedbankApi
  class Http
    def initialize(url:)
      @url = URI(url)
    end

    def get(body: {}, headers: {})
      request = Net::HTTP::Get.new(@url)
      make_request(request: request, body: body, headers: headers)
    end

    def post(body: {}, headers: {})
      request = Net::HTTP::Post.new(@url)
      make_request(request: request, body: body, headers: headers)
    end

    def make_request(request:, body: {}, headers: {})
      headers.each do |key,value|
        request[key] = value
      end

      request.body = body
      net_http.request(request)
    end

    private

    def net_http
      @net_http ||= Net::HTTP.new(@url.host, @url.port).tap do |http|
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
    end

  end
end
