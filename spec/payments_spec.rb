RSpec.describe Payments do

  describe '.intent' do
    client = NedbankApi::Client.new(
      client_id: client_id,
      client_secret: client_secret
    )
    client.payments.create_intent
  end
end
