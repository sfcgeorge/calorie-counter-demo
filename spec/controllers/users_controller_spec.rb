require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    { username: "John", password: "JohnDoe1", target_calories: 1000 }
  end

  let(:invalid_attributes) do
    { username: nil, password: "JohnDoe1", target_calories: "1000" }
  end

  let!(:user) { User.create(valid_attributes) }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: user.id, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "returns http success" do
      put :update, id: user.id, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      delete :destroy, id: user.id, format: :json
      expect(response).to have_http_status(:success)
    end
  end
end
