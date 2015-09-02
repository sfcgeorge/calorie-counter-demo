require "rails_helper"

RSpec.shared_context "warden_mock_authenticated" do
  def warden
    double "warden", authenticate!: true, user: users(:kai)
  end

  before do
    request.env["warden"] = warden
  end
end
