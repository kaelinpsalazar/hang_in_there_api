require 'rails_helper'

describe "api" do

  it "shows all posters" do
    Poster.create(
      name: "REGRET",
      description: "Hard work rarely pays off.",
     price: 89.00,
     year: 2018,
     vintage: true,
     img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )

    Poster.create(
      name: "FAILURE",
      description: "The key to success is knowing when to give up.",
      price: 72.50,
      year: 2020,
      vintage: false,
      img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )

    Poster.create(
      name: "DESPAIR",
     description: "Why try, when you can fail spectacularly?",
     price: 65.99,
      year: 2015,
      vintage: true,
      img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )
    
    get "/api/v1/posters"

    posters = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  
    expect(posters.count).to eq(3)

    posters.each do |poster| 
      expect(poster).to have_key(:id) 
      expect(poster[:id]).to be_an(Integer)

      expect(poster).to have_key(:name) 
      expect(poster[:name]).to be_a(String)

      expect(poster).to have_key(:description) 
      expect(poster[:description]).to be_a(String) 

      expect(poster).to have_key(:price) 
      expect(poster[:price]).to be_a(Float)

      expect(poster).to have_key(:year) 
      expect(poster[:year]).to be_a(Integer) 

      expect(poster).to have_key(:vintage) 
      expect(poster[:vintage]).to be_in([true, false]) 

      expect(poster).to have_key(:img_url) 
      expect(poster[:img_url]).to be_a(String) 
    end
  
  end


  it "shows posters by id" do

    id = Poster.create(
      name: "REGRET",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    ).id

    get "/api/v1/posters/#{id}"

    poster = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(poster).to have_key(:id) 
    expect(poster[:id]).to be_an(Integer)

    expect(poster).to have_key(:name) 
    expect(poster[:name]).to be_a(String)

    expect(poster).to have_key(:description) 
    expect(poster[:description]).to be_a(String) 

    expect(poster).to have_key(:price) 
    expect(poster[:price]).to be_a(Float)

    expect(poster).to have_key(:year) 
    expect(poster[:year]).to be_a(Integer) 

    expect(poster).to have_key(:vintage) 
    expect(poster[:vintage]).to be_in([true, false]) 

    expect(poster).to have_key(:img_url) 
    expect(poster[:img_url]).to be_a(String) 
  end



  it "can create a new poster" do
    poster_params = {name: "FAILURE",
    description: "The key to success is knowing when to give up.",
    price: 72.50,
    year: 2020,
    vintage: false,
    img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/posters", headers: headers, params: JSON.generate(poster: poster_params)
    created_poster = Poster.last

    expect(response).to be_successful

    expect(created_poster.name).to eq(poster_params[:name])
    expect(created_poster.description).to eq(poster_params[:description])
    expect(created_poster.price).to eq(poster_params[:price])
    expect(created_poster.year).to eq(poster_params[:year])
    expect(created_poster.vintage).to eq(poster_params[:vintage])
    expect(created_poster.img_url).to eq(poster_params[:img_url])
    
  end

end