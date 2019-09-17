module NedbankApi
  module Models
    class IntentToken < BaseModel
      ERRORS = {
        token_expired: {
          error: 'token_expired',
          error_description: 'Intent Access Token has expired'
        }
      }

      attr_accessor :token_expires_at,
       :error,
       :error_description

      def token_expires_at
        self.initialized_at + self.expires_in
      end

      def authenticated?
        return false if self.access_token.nil?
        !expired?
      end

      def expired?
        return true if self.expires_in.nil?
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
