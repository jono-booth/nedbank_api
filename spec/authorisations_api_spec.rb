RSpec.describe NedbankApi::AuthenticationsApi do
  describe '.authenticate!' do

    context 'a valid request' do
      let(:response_body) { attributes_for :fake_client }

      before :each do
        stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/nboauth/oauth20/token").
          to_return(status: 200, body: response_body.to_json, headers: {})
      end

      it 'sets the access token' do
        token = NedbankApi::AuthenticationsApi.new.request_token_light
        expect(token.authenticated?).to be true
      end

      context 'with an expired access token' do
        it 'does not authenticate' do
          token = NedbankApi::AuthenticationsApi.new.request_token_light
          token.initalized_at = Time.now - 3599
          expect(token.authenticated?).to be false
          expect(token.error).to eq NedbankApi::Models::IntentToken::ERRORS[:token_expired][:error]
          expect(token.error_description).to eq NedbankApi::Models::IntentToken::ERRORS[:token_expired][:error_description]
        end
      end
    end

    context 'given an error' do
      let(:response_body) { attributes_for(:client_with_error, :invalid_client) }

      before :each do
        stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/nboauth/oauth20/token").
          to_return(status: 400, body: response_body.to_json, headers: {})
      end

      it 'does not authenticate' do
        token = NedbankApi::AuthenticationsApi.new.request_token_light
        token = client.authentication.request_token_light
        expect(token.authenticated?).to be false
      end
    end
  end
end
