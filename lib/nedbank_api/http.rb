module NedbankApi
  class Http
    def initialize(url:)
      @url = URI(url)
    end

    def net_http
      @net_http ||= Net::HTTP.new(@url.host, @url.port).tap do |http|
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
    end

    def get(body: {}, headers: {})
      request = Net::HTTP::Get.new(@url)

      headers.each do |key,value|
        request[key] = value
      end

      request.body = body
      response = net_http.request(request)

      return response
    end
    def post(body: {}, headers: {})
      request = Net::HTTP::Post.new(@url)

      headers.each do |key,value|
        request[key] = value
      end

      request.body = body
      response = net_http.request(request)

      return response
    end
  end
end
