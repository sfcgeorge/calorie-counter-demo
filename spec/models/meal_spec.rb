require "rails_helper"

RSpec.describe Meal do
  describe "db structure" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:calories).of_type(:integer) }
    it { should have_db_column(:text).of_type(:string) }
    it { should have_db_column(:date).of_type(:date) }
    it { should have_db_column(:time).of_type(:time) }
  end

  describe "validations" do
    it { should belong_to(:user) }
    it { should validate_presence_of(:calories) }
    it {
      should validate_numericality_of(:calories)
        .only_integer.is_less_than_or_equal_to(30_000)
    }
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_most(200) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:time) }
  end
end
