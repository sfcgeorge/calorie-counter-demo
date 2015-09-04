require "rails_helper"

RSpec.shared_examples "api_controller" do
  describe "rescues from ActiveRecord::RecordNotFound" do
    context "on GET #show" do
      before { get :show, id: "not-existing", format: :json }

      it { expect(response.status).to eq(404) }
      it { expect(response.body).to be_blank }
    end

    context "on PUT #update" do
      before { put :update, id: "not-existing", format: :json }

      it { expect(response.status).to eq(404) }
      it { expect(response.body).to be_blank }
    end

    context "on DELETE #destroy" do
      before { delete :destroy, id: "not-existing", format: :json }

      it { expect(response.status).to eq(404) }
      it { expect(response.body).to be_blank }
    end
  end
end
