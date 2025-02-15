require "rails_helper"

RSpec.describe "Registrations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/registrations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/registrations/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/registrations/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
