module NedbankApi
  class PaymentsApi < ApiWrapper
    class << self

      API_PATHS = {
        payments: 'open-banking/payments',
        payment_submissions: 'open-banking/payment-submissions'
      }

      def create_intent(request_body: {}, headers: {})
        http = Http.new(url: endpoint(API_PATHS[:payments]))

        response = http.post(
          headers: auth_headers,
          body: request_body.to_json
        )

        return Models::Payment.new(json_to_object(response.body))
      end

      def submit_payment(request_body: {}, headers: {})
        http = Http.new(url: endpoint(API_PATHS[:payment_submissions]))

        response = http.post(
          headers: auth_headers,
          body: request_body.to_json
        )

        return Models::PaymentSubmission.new(json_to_object(response.body))
      end

      def get_payment_submission(payment_submission_id:, headers: {})
        http = Http.new(url: endpoint(API_PATHS[:payment_submissions], suffix: payment_submission_id))

        response = http.get(
          headers: auth_headers
        )

        return Models::PaymentSubmission.new(json_to_object(response.body))
      end
    end
  end
end
