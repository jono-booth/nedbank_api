RSpec.describe NedbankApi::Client do
  describe '.initialize' do

    it 'sets up the client' do
      NedbankApi::Client.new(
        client_id: 'CLIENTID',
        client_secret: 'CLIENTSECRET',
        api_base: 'APIBASE'
      )

      expect(NedbankApi.client_id).to eq 'CLIENTID'
      expect(NedbankApi.client_secret).to eq 'CLIENTSECRET'
      expect(NedbankApi.api_base).to eq 'APIBASE'
    end
  end
end
