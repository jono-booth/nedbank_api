RSpec.describe NedbankApi::PaymentsApi do
  describe '.create_intent' do
    let(:request_body) { File.read('spec/support/payment/post_intent_request.json') }
    let(:response_body) { File.read('spec/support/payment/post_intent_response.json') }

    before :each do
      stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/open-banking/payments").
        to_return(status: 200, body: response_body)
    end

    it 'returns a payment object' do
      payment = NedbankApi::PaymentsApi.new.create_intent(request_body: request_body)

      expect(payment.Data.PaymentId).to eq JSON.parse(response_body)['Data']['PaymentId']
      expect(payment.Data.Initiation.InstructedAmount.Amount).to eq JSON.parse(response_body)['Data']['Initiation']['InstructedAmount']['Amount']
    end
  end

  describe '.payment_auth' do
    let(:intent_id) { "GOODPEOPLEDRINKGOODBEER" }
    let(:request_body) { File.read('spec/support/payment/post_intent_request.json') }
    let(:response_body) { 'https://yourapp.co.za/handle/auth/?code=xxxxxxxxxxxxxxxxxxxxxxxxxxxx' }

    before :each do
      stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/nboauth/oauth20/authorize").
        with(body: Regexp.new("intentid=#{intent_id}")).
        to_return(status: 200, body: response_body)
    end

    it 'returns a payment auth url' do
      authorisation_url = NedbankApi::PaymentsApi.new.authorise_payment(intent_id: intent_id, redirect_uri: 'https://jono3000.ngrok.io/api/v1/soap/nedbank/authenticate')
      expect(authorisation_url).to eq response_body
    end
  end

  describe '.submit_payment' do
    let(:request_body) { File.read('spec/support/payment/post_payment_submission_request.json') }
    let(:response_body) { File.read('spec/support/payment/post_payment_submission_response.json') }

    before :each do
      stub_request(:post, "https://api.nedbank.co.za/apimarket/sandbox/open-banking/payment-submissions").
        to_return(status: 200, body: response_body)
    end

    it 'returns a payment submission object' do
      submission = NedbankApi::PaymentsApi.new.submit_payment(request_body: request_body)
      expect(submission.PaymentSubmissionId).to eq "62820068622336"
      expect(submission.PaymentId).to eq "8124568155717632"
      expect(submission.Status).to eq "AcceptedSettlementInProcess"
    end
  end

  describe '.get_payment_submission' do
    let(:payment_submission_id) { "62820068622336" }
    let(:response_body) { File.read('spec/support/payment/post_payment_submission_response.json') }

    before :each do
      stub_request(:get, "https://api.nedbank.co.za/apimarket/sandbox/open-banking/payment-submissions/#{payment_submission_id}").
        to_return(status: 200, body: response_body)
    end

    it 'returns a payment submission object' do
      submission = NedbankApi::PaymentsApi.new.get_payment_submission(payment_submission_id: payment_submission_id)
      expect(submission.PaymentSubmissionId).to eq payment_submission_id
      expect(submission.Status).to eq "AcceptedSettlementInProcess"
    end
  end
end
