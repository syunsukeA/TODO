require "rails_helper"

RSpec.describe "Todos API", type: :request do
  describe "POST /api/v1/todos" do
    it "creates a todo and returns id and created_at" do
      post "/api/v1/todos", params: { title: "Buy milk" }

      expect(response).to have_http_status(:created)
    end

    it "returns 422 when title is too long" do
      post "/api/v1/todos", params: { title: "a" * 101 }

      expect(response).to have_http_status(:unprocessable_entity)

      body = JSON.parse(response.body)
      expect(body["errors"]).to be_present
    end
  end
end
