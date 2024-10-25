require "rails_helper"

describe Poster, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_uniqueness_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:year)}
    it {should validate_numericality_of(:year)}
    it {should validate_presence_of(:price)}
    it {should validate_numericality_of(:price)}
  end
end