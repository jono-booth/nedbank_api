module NedbankApi
  module Models
    class IntentToken < BaseModel
      EXPIRY_BUFFER_SECONDS = 20

      ERRORS = {
        token_expired: {
          error: 'token_expired',
          error_description: 'Intent Access Token has expired'
        }
      }

      attr_accessor :token_expires_at
      attr_accessor :error
      attr_accessor :error_description

      def token_expires_at
        self.initalized_at - EXPIRY_BUFFER_SECONDS + self.expires_in
      end

      def authenticated?
        return false if self.access_token.nil?
        !expired?
      end

      def expired?
        return true if self.token_expires_at.nil?
        raise Exceptions::TokenExpired if token_expires_at < Time.now
        return false

      rescue Exceptions::TokenExpired
        self.error = ERRORS[:token_expired][:error]
        self.error_description = ERRORS[:token_expired][:error_description ]
        return true
      end
    end
  end
end
