FactoryBot.define do
  factory :fake_client, class: OpenStruct do
    access_token { 'THISISBATCOUNTRY' }
    client_id { 'NEVERTRUSTACOPINARAINCOAT' }
    client_secret { 'TOOWEIRDTOLIVETORARETODIE' }
    expires_in { 3599 }
    api_url { 'https://api.nedbank.co.za/apimarket/sandbox' }

    factory :client_with_error do
      trait :invalid_client do
        access_token { nil }
        error_description { 'FBTOAU204E An invalid secret was provided for the client with identifier: [CLIENT_ID].' }
        error { 'invalid_client' }
      end
    end
  end
end
