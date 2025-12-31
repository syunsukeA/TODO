require "rails_helper"

RSpec.describe "Todos API", type: :request do
  describe "GET /api/v1/todos" do
    context "when limit is valid" do
      it "returns todos with default limit" do
        25.times { |i| Todo.create!(title: "Todo #{i}") }

        get "/api/v1/todos"

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)
        expect(body["todos"].size).to eq(20)
      end

      it "returns todos with requested limit" do
        12.times { |i| Todo.create!(title: "Todo #{i}") }

        get "/api/v1/todos", params: { limit: 5 }

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)
        expect(body["todos"].size).to eq(5)
      end
    end

    context "when limit is invalid" do
      it "returns 400 when limit exceeds the maximum" do
        120.times { |i| Todo.create!(title: "Todo #{i}") }

        get "/api/v1/todos", params: { limit: 150 }

        expect(response).to have_http_status(:bad_request)

        body = JSON.parse(response.body)
        expect(body["errors"]).to be_present
      end

      it "returns 400 when limit is not a number" do
        get "/api/v1/todos", params: { limit: "abc" }

        expect(response).to have_http_status(:bad_request)

        body = JSON.parse(response.body)
        expect(body["errors"]).to be_present
      end

      it "returns 400 when limit is zero" do
        get "/api/v1/todos", params: { limit: 0 }

        expect(response).to have_http_status(:bad_request)

        body = JSON.parse(response.body)
        expect(body["errors"]).to be_present
      end

      it "returns 400 when limit is negative" do
        get "/api/v1/todos", params: { limit: -1 }

        expect(response).to have_http_status(:bad_request)

        body = JSON.parse(response.body)
        expect(body["errors"]).to be_present
      end
    end
  end

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
