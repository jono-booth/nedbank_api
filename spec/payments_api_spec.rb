RSpec.describe NedbankApi::PaymentsApi do
  describe '.create_intent' do
    let(:client) { build(:fake_client) }

    let(:response_example) { File.read('spec/support/payment/post_intent_response.json') }
    let(:request_body) { File.read('spec/support/payment/post_intent_request.json') }

    before :each do
      stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/open-banking/payments").
        to_return(status: 200, body: response_example)
    end

    it 'sends a payment batch to the Payments API' do
      payment = NedbankApi::PaymentsApi.new(client: client).create_intent(payments_batch: request_body)

      expect(payment.Data.PaymentId).to eq JSON.parse(response_example)['Data']['PaymentId']
      expect(payment.Data.Initiation.InstructedAmount.Amount).to eq JSON.parse(response_example)['Data']['Initiation']['InstructedAmount']['Amount']
    end
  end

  describe '.payment_auth' do
    # let(:client) { NedbankApi::Client.new(attributes_for(:real_client)) }
    let(:client) { build(:fake_client) }

    let(:payment_response_example) { File.read('spec/support/payment/post_intent_response.json') }
    let(:payment_auth_response) { 'https://yourapp.co.za/handle/auth/?code=xxxxxxxxxxxxxxxxxxxxxxxxxxxx' }

    before :each do
      stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/open-banking/payments").
        to_return(status: 200, body: payment_response_example)

      stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/nboauth/oauth20/authorize").
        to_return(status: 200, body: payment_auth_response)
    end

    let(:request_body) { File.read('spec/support/payment/post_intent_request.json') }

    it 'returns a payment auth url' do
      payment = NedbankApi::PaymentsApi.new(client: client).create_intent(payments_batch: request_body)
      payment_auth = NedbankApi::PaymentsApi.new(client: client).payment_auth(payment_id: payment.Data.PaymentId, redirect_uri: 'https://jono3000.ngrok.io/api/v1/soap/nedbank/authenticate')
      expect(payment_auth.body).to eq payment_auth_response
    end
  end
end
