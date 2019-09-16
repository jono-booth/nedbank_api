RSpec.describe NedbankApi::Client do
  describe '.authenticate!' do

    context 'a valid request' do
      let(:response_body) { attributes_for :fake_client }
      let(:client_id) { response_body[:client_id] }
      let(:client_secret) { response_body[:client_secret] }

      before :each do
        stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/nboauth/oauth20/token").
          with(
            body: "client_id=#{client_id}&client_secret=#{client_secret}&grant_type=client_credentials&scope=tpp_client_credential",
          ).
          to_return(status: 200, body: response_body.to_json, headers: {})
      end

      it 'sets the access token' do
        client = NedbankApi::Client.new(client_id: client_id, client_secret: client_secret)
        client.authenticate!
        expect(client.authenticated?).to be true
      end

      context 'with an expired access token' do
        it 'does not authenticate' do
          client = NedbankApi::Client.new(client_id: client_id, client_secret: client_secret)
          client.authenticate!
          client.intent.initalized_at = Time.now - 3599
          expect(client.authenticated?).to be false
          expect(client.intent.error).to eq NedbankApi::Models::IntentToken::ERRORS[:token_expired][:error]
          expect(client.intent.error_description).to eq NedbankApi::Models::IntentToken::ERRORS[:token_expired][:error_description]
        end
      end
    end

    context 'given an incorrect credential' do
      let(:response_body) { attributes_for(:client_with_error, :invalid_client) }
      let(:client_id) { response_body[:client_id] }
      let(:client_secret) { response_body[:client_secret] }

      before :each do
        stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/nboauth/oauth20/token").
          with(
            body: "client_id=#{client_id}&client_secret=#{client_secret}&grant_type=client_credentials&scope=tpp_client_credential",
          ).
          to_return(status: 400, body: response_body.to_json, headers: {})
      end

      it 'does not authenticate' do
        WebMock.allow_net_connect!
        client = NedbankApi::Client.new(client_id: client_id, client_secret: client_secret)
        client.authenticate!
      end
    end
  end
end
