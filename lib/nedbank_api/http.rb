module NedbankApi
  class Http
    API_DOMAIN = 'https://api.nedbank.co.za/apimarket/sandbox'

    def initialize(url:)
      @url = URI(API_DOMAIN + url)
    end

    def net_http
      @net_http ||= Net::HTTP.new(@url.host, @url.port).tap do |http|
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
    end

    def post(body: {})
      request = Net::HTTP::Post.new(@url)
      request.body = URI.encode_www_form(body)
      response = net_http.request(request)
      return response.read_body
    end
  end
end
