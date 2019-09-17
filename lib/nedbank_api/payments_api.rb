module NedbankApi
  class PaymentsApi < ApiWrapper

    def create_intent(request_body:)
      http = Http.new(url: endpoint('/open-banking/payments'))

      response = http.post(
        headers: auth_headers,
        body: request_body.to_json
      )

      return Models::Payment.new(json_to_object(response.body))
    end

    def authorise_payment(request_body:)
      http = Http.new(url: endpoint('/nboauth/oauth20/authorize'))

      body = URI.encode_www_form({
          response_type: 'code',
          scope: 'payments',
          client_id: NedbankApi.client_id,
          type: 'payments',
          state: 'payments'
      }.merge(request_body))

      response = http.post(
        headers: { "accept" => 'text/html' },
        body: body
      )

      return response.body
    end

    def submit_payment(request_body:)
      http = Http.new(url: endpoint('/open-banking/payment-submissions'))

      response = http.post(
        headers: auth_headers,
        body: request_body.to_json
      )

      return Models::PaymentSubmission.new(json_to_object(response.body))
    end

    def get_payment_submission(payment_submission_id:)
      http = Http.new(url: endpoint('/open-banking/payment-submissions/' + payment_submission_id))

      response = http.get(
        headers: auth_headers
      )

      return Models::PaymentSubmission.new(json_to_object(response.body))
    end
  end
end