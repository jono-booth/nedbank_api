module NedbankApi
  class PaymentsApi < ApiWrapper
    def create_intent(payments_batch:)
      http = Http.new(url: endpoint('/open-banking/payments'))

      response = http.post(
        headers: auth_headers,
        body: payments_batch
      )

      return Models::Payment.new(JSON.parse(response.body, object_class: OpenStruct))
    end

    def payment_auth(payment_id:, redirect_uri:)
      http = Http.new(url: endpoint('/nboauth/oauth20/authorize'))

      body = URI.encode_www_form({
          response_type: 'code',
          scope: 'payments',
          redirect_uri: redirect_uri,
          client_id: @client_id,
          intentid: payment_id,
          itype: 'payments',
          state: 'payments'
        })

      response = http.post(
        headers: {
          "accept" => 'text/html',
        },
        body: body
      )
    end
  end
end
