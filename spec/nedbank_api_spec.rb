RSpec.describe NedbankApi do
  it "has a version number" do
    expect(NedbankApi::VERSION).not_to be nil
  end

  let(:client) { build :fake_client }

  it "sets the client id" do
    NedbankApi.client_id = client.client_id
    expect(NedbankApi.client_id).to eq client.client_id
  end
end
