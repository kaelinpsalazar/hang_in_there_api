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


  describe "the filter model method" do
    describe "when filtering names" do
      before(:each) do
        @poster1 = Poster.create(
        name: "REGRET",
        description: "Hard work rarely pays off.",
         price: 89.00,
         year: 2018,
         vintage: true,
         img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        )
    
    
        @poster2= Poster.create(
          name: "HELLO",
         description: "Why try, when you can fail spectacularly?",
         price: 65.99,
          year: 2015,
          vintage: true,
          img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        )
        @poster3= Poster.create(
          name: "STORMS",
         description: "Why are we doing this?",
         price: 55.21,
          year: 2019,
          vintage: true,
          img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        )

      end
      it "returns poster in created by asc order" do
        results = Poster.search(sort: "asc")
        expect(results).to eq([@poster1, @poster2, @poster3])
      end

      it "returns poster in created by desc order" do
        results = Poster.search(sort: "desc")
        expect(results).to eq([@poster3, @poster2, @poster1])
      end

      it "returns posters by min price" do
        results = Poster.search(min_price: 56.00)
        expect(results).to eq([@poster1, @poster2])
      end

      it "returns posters by max price" do
        results = Poster.search(max_price: 56.00)
        expect(results).to eq([@poster3])
      end
      
      it "returns posters that partially match the name" do
        results = Poster.search(name: "re")
        expect(results).to include(@poster1)
        expect(results).not_to include(@poster2)
        expect(results).not_to include(@poster3)
      end
    end
  end
end