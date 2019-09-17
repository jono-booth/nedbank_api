# Payments API

[Official Documentation](https://apim.nedbank.co.za/static/docs/payments-oauth)

## 1) Request token (light)

Using your client ID and client secret (which you obtained when you created an application), you will make a POST request using the endpoint and values below to retrieve a Payment intent access token.

Please note that in order to use this API, you will have to be subscribed to both the Nedbank Authorisation API and this API.

```ruby
$ token = NedbankApi::AuthorisationsApi.request_token_light
$ token.authenticated?
# true
```

### 2) Request Payment intent ID

Using the Payment intent access token you received in the previous call, proceed to make a payment intent call to receive a Payment ID using the endpoint and values below.


```ruby
$ payment_batch = {
    "Data": {
      "Initiation": {
        ...
      }
    }
  }

$ payment = NedbankApi::PaymentsApi.create_intent(request_body: payment_batch)
```

Now the entire response object is available to like so
```ruby
$ p payment.Data.PaymentId
# "456c1abe-9568-4335-a914-73bd1df0085f"
$ p payment.Data.Initiation.InstructedAmount.Amount
# "55.60"
$ p payment.Data.Initiation.InstructedAmount.Currency
# "ZAR"
```

### 3) Get Payments authorisation

To make use of the Payment ID you received in the previous call, add it to the user parameter values found below in the authorization URL to retrieve an access code that you will use to get a heavy/submission token. Make use of the url and values found below.

```ruby
$ authorisation_url = NedbankApi::PaymentsApi.authorise_payment(
    intent: payment.Data.PaymentId,
    redirect_uri: 'https://yourapp.co.za/handle/auth/'
  )
$ p authorisation_url
# "https://yourapp.co.za/handle/auth/?code=xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

### 4) Request token (heavy/submission)

Using the code returned with the redirect URI, you must call this endpoint to get an access token for the payment submission call.

```ruby
$ token = NedbankApi::AuthorisationsApi.request_token_heavy(
    code: params[:code],
    redirect_uri: 'https://yourapp.co.za/handle/auth/'
  )
$ p token.access_token
# "TEMPACCESSTOKEN"
```

### 5) Payment submission

Using the access token from your previous call, you may proceed to make the call for submitting the payment.

```ruby
payment_batch = {
  "Data": {
    "PaymentId": "1878194005213184",
    "Initiation": {
      ...
    }
  }
}

$ payment_submission = NedbankApi::PaymentsApi.submit_payment(request_body: payment_batch)
$ p payment_submission.PaymentSubmissionId
# p "62820068622336"
$ payment_submission.Status
# "AcceptedSettlementInProcess"
```

### 6) Get Payment Submission

```ruby
$ payment_submission = NedbankApi::PaymentsApi.get_payment_submission(payment_submission_id: "1878194005213184")
$ payment_submission.Status
# "AcceptedSettlementInProcess"
```
