module NedbankApi
  module Models
    class Payment < BaseModel

      def created?
        self.Data.present?
      end
    end
  end
end
