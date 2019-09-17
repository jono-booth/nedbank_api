RSpec.describe NedbankApi::AuthenticationsApi do
  describe '.request_token_light' do
    context 'a valid request' do
      let(:response_body) { attributes_for :fake_client }

      before :each do
        stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/nboauth/oauth20/token").
          to_return(status: 200, body: response_body.to_json, headers: {})
      end

      it 'authenticates and sets the access token' do
        token = NedbankApi::AuthenticationsApi.request_token_light
        expect(NedbankApi.intent_token.access_token).to eq response_body[:access_token]
        expect(token.authenticated?).to be true
      end

      context 'with an expired access token' do
        it 'does not authenticate' do
          token = NedbankApi::AuthenticationsApi.request_token_light
          token.initialized_at = Time.now - 3599
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
        token = NedbankApi::AuthenticationsApi.request_token_light
        expect(token.authenticated?).to be false
      end
    end
  end

  describe '.authorise_intent' do
    let(:intent_id) { "GOODPEOPLEDRINKGOODBEER" }
    let(:request_body) { File.read('spec/support/payment/post_intent_request.json') }
    let(:response_body) { 'https://yourapp.co.za/handle/auth/?code=xxxxxxxxxxxxxxxxxxxxxxxxxxxx' }

    before :each do
      stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/nboauth/oauth20/authorize").
        with(body: Regexp.new("intentid=#{intent_id}")).
        to_return(status: 200, body: response_body)
    end

    it 'returns a payment auth url' do
      authorisation_url = NedbankApi::AuthenticationsApi.authorise_intent(request_body: { intentid: intent_id, redirect_uri: 'https://myapp.com' })
      expect(authorisation_url).to eq response_body
    end
  end
end
