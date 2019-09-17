module NedbankApi
  module Models
    class BaseModel < Delegator
      attr_accessor :initialized_at

      def initialize(obj)
        super
        @delegate_sd_obj = obj
        self.initialized_at = Time.now
      end

      def __getobj__
        @delegate_sd_obj
      end

      def __setobj__(obj)
        @delegate_sd_obj = obj
      end
    end
  end
end
