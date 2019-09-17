require 'nedbank_api/api_wrapper'
require 'nedbank_api/authentications_api'
require 'nedbank_api/exceptions'
require 'nedbank_api/payments_api'
require 'nedbank_api/version'
require 'nedbank_api/models/base_model'
require 'nedbank_api/models/intent_token'
require 'nedbank_api/models/payment'
require 'nedbank_api/models/payment_submission'
require 'nedbank_api/services/http'
require 'nedbank_api/services/client'

require 'uri'
require 'openssl'
require 'net/http'
require 'uri'
require 'securerandom'

module NedbankApi

  class << self
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :api_base
    attr_accessor :access_token

    def access_token=(access_token)
      @access_token = access_token
    end
  end
end
