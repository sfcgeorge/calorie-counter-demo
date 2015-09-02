require "rails_helper"

RSpec.describe MealsController, type: :controller do
  it_behaves_like "api_controller"
  include_context "warden_mock_authenticated"

  def valid_attributes
    attributes_for(:meal)
  end

  def invalid_attributes
    valid_attributes.tap { |a| a[:calories] = "x" }
  end

  let!(:user) { users(:kai) }
  let!(:meal) { Meal.create(valid_attributes.merge user: user) }
  let!(:meal_not) { Meal.create(valid_attributes) }

  let(:show_pattern) do
    {
      id: Integer,
      calories: Integer,
      text: String,
      date: String,
      time: String
    }
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end

    it "matches json pattern" do
      get :index, format: :json
      expect(response.body).to match_json_expression([show_pattern])
    end

    it "containt user's meals only" do
      get :index, format: :json
      expect(response.body).to match_json_expression(
        [{ id: meal.id }.forgiving!]
      )
      expect(response.body).not_to match_json_expression(
        [{ id: meal_not.id }.forgiving!]
      )
    end
  end

  describe "GET #show" do
    before { get :show, id: meal.id, format: :json }

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
        post :create, meal: valid_attributes, format: :json
        expect(response).to have_http_status(:success)
      end

      it "creates a new Meal" do
        expect do
          post :create, meal: valid_attributes, format: :json
        end.to change(Meal, :count).by(1)
      end

      it "matches json pattern" do
        post :create, meal: valid_attributes, format: :json
        expect(response.body).to match_json_expression(show_pattern)
      end
    end

    context "with invalid params" do
      it "returns http unprocessable entity" do
        post :create, meal: invalid_attributes, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested customer" do
        new_attributes = valid_attributes
        put :update, id: meal.id, meal: new_attributes, format: :json
        meal.reload
        expect(meal.text).to eq new_attributes[:text]
      end

      it "returns http success" do
        put :update, id: meal.id, meal: valid_attributes, format: :json
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid params" do
      it "returns http unprocessable entity" do
        put :update, id: meal.id, meal: invalid_attributes, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested meal" do
      expect {
        delete :destroy, id: meal.id, format: :json
      }.to change(Meal, :count).by(-1)
    end

    it "returns http success" do
      delete :destroy, id: meal.id, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end
