RSpec.describe NedbankApi do
  it "has a version number" do
    expect(NedbankApi::VERSION).not_to be nil
  end

  describe '.authenticate' do
    let(:client_id) { 'f4f92bdd-c521-4886-9bc4-e2531efc0611' }
    let(:client_secret) { 'rM1vK5qY4hO4kK4rW2cS0wN5rI7yJ3nT7nK8eO7gV1eO5eW8bN' }

    let(:response_body) do
      {
        access_token: "TOKEN0",
        scope: "tpp_client_credential",
        token_type: "bearer",
        expires_in: 3599
      }.to_json
    end

    before :each do
      stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/nboauth/oauth20/token").
        with(
          body: "client_id=#{client_id}&client_secret=#{client_secret}&grant_type=client_credentials&scope=tpp_client_credential",
        ).
        to_return(status: 200, body: response_body, headers: {})
    end

    it 'sets the access token' do
      n = NedbankApi::Client.new(client_id: client_id, client_secret: client_secret)
      n.authenticate
      expect(n.intent_token.authenticated?).to be true
    end

    context 'given an expired access token' do
      before :each do
        allow_any_instance_of(NedbankApi::ResponseObjects::ResponseObject).to receive(:initalized_at).and_return Time.now - 3599
      end

      it 'does not authenticate' do
        n = NedbankApi::Client.new(client_id: client_id, client_secret: client_secret)
        n.authenticate
        expect(n.intent_token.authenticated?).to be false
      end
    end
  end
end
