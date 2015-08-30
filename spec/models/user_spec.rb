require "rails_helper"

RSpec.describe User do
  describe "db structure" do
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
    it { should have_db_column(:token).of_type(:string) }
    it { should have_db_column(:admin).of_type(:boolean) }
    it { should have_db_column(:target_callories).of_type(:integer) }
  end

  describe "validations" do
    it { should have_secure_password }

    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_least(2).is_at_most(20) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_length_of(:password).is_at_least(8).on(:create) }
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:admin) }
  end
end
