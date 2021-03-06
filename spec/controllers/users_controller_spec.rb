require "rails_helper"

RSpec.describe UsersController, type: :controller do
  it_behaves_like "api_controller"
  include_context "warden_mock_authenticated"

  def valid_attributes
    attributes_for(:user)
  end

  def invalid_attributes
    valid_attributes.tap do |a|
      a[:username] = "x"
      a[:password] = "x"
    end
  end

  let!(:user) { users(:kai) }

  let(:show_pattern) do
    {
      id: Integer,
      username: String,
      target_calories: Integer,
      admin: Boolean
    }
  end

  describe "POST #login" do
    context "with valid credentials" do
      before do
        request.headers["Authorization"] =
          "Basic #{Base64.encode64("#{user.username}:Password1")}"
        post :login, format: :json
      end

      it { expect(response).to have_http_status(:success) }

      it "updates token" do
        expect do
          post :login, user: valid_attributes, format: :json
          user.reload
        end.to change(user, :token)
      end

      it "matches json pattern" do
        expect(response.body).to match_json_expression(
          id: Integer,
          token: String
        )
      end
    end

    context "with invalid credentials" do
      before do
        request.headers["Authorization"] = "Basic #{Base64.encode64 'u:nope'}"
        post :login, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context "with missing/invalid params" do
      before { post :login, foo: { bar: "baz" }, format: :json }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "POST #logout" do
    it "returns http success" do
      post :logout, id: user.id, format: :json
      expect(response).to have_http_status(:success)
    end

    it "change token" do
      expect do
        post :logout, id: user.id, format: :json
        user.reload
      end.to change(user, :token)
    end
  end

  describe "GET #index" do
    before { get :index, format: :json }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "matches json pattern" do
      expect(response.body).to match_json_expression([show_pattern].forgiving!)
    end
  end

  describe "GET #show" do
    before { get :show, id: user.id, format: :json }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "matches json pattern" do
      expect(response.body).to match_json_expression(show_pattern)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "returns http success" do
        post :create, valid_attributes, format: :json
        expect(response).to have_http_status(:success)
      end

      it "creates a new User" do
        expect do
          post :create, valid_attributes, format: :json
        end.to change(User, :count).by(1)
      end

      it "matches json pattern" do
        post :create, valid_attributes, format: :json
        expect(response.body).to match_json_expression(show_pattern)
      end
    end

    context "with invalid params" do
      it "returns http unprocessable entity" do
        post :create, invalid_attributes, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested user" do
        new_attributes = valid_attributes
        put :update, id: user.id, **new_attributes, format: :json
        user.reload
        expect(user.username).to eq(new_attributes[:username])
      end

      it "returns http success" do
        put :update, id: user.id, **valid_attributes, format: :json
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid params" do
      it "returns http unprocessable entity" do
        put :update, id: user.id, **invalid_attributes, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect do
        delete :destroy, id: user.id, format: :json
      end.to change(User, :count).by(-1)
    end

    it "returns http success" do
      delete :destroy, id: user.id, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end
