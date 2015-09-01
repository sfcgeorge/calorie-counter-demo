require "rails_helper"

RSpec.describe UsersController, type: :controller do
  def valid_attributes
    attributes_for(:user)
  end

  def invalid_attributes
    valid_attributes.tap { |a| a[:username] = "x" }
  end

  let!(:user) { User.create(valid_attributes) }

  let(:show_pattern) do
    {
      id: Integer,
      username: String,
      target_calories: Integer
    }
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: user.id, format: :json
      expect(response).to have_http_status(:success)
    end

    it "matches json pattern" do
      get :show, id: user.id, format: :json
      expect(response.body).to match_json_expression(show_pattern)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "returns http success" do
        post :create, user: valid_attributes, format: :json
        expect(response).to have_http_status(:success)
      end

      it "creates a new User" do
        expect do
          post :create, user: valid_attributes, format: :json
        end.to change(User, :count).by(1)
      end

      it "matches json pattern" do
        post :create, user: valid_attributes, format: :json
        expect(response.body).to match_json_expression(show_pattern)
      end
    end

    context "with invalid params" do
      it "returns http unprocessable entity" do
        post :create, user: invalid_attributes, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested user" do
        new_attributes = valid_attributes
        put :update, id: user.id, user: new_attributes, format: :json
        user.reload
        expect(user.username).to eq(new_attributes[:username])
      end

      it "returns http success" do
        put :update, id: user.id, user: valid_attributes, format: :json
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid params" do
      it "returns http unprocessable entity" do
        put :update, id: user.id, user: invalid_attributes, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect {
        delete :destroy, id: user.id, format: :json
      }.to change(User, :count).by(-1)
    end

    it "returns http success" do
      delete :destroy, id: user.id, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end
