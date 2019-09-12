module NedbankApi
  module ResponseObjects
    class IntentToken < ResponseObject
      EXPIRY_BUFFER_SECONDS = 20
      attr_accessor :token_expires_at

      def token_expires_at
        self.initalized_at - EXPIRY_BUFFER_SECONDS + self.expires_in
      end

      def authenticated?
        return false if self.access_token.nil?
        !expired?
      end

      def expired?
        return true if self.token_expires_at.nil?
        token_expires_at < Time.now
      end
    end
  end
end
