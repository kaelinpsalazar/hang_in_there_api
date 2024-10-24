require 'rails_helper'

describe "api" do
  before(:each) do
    @poster1 = Poster.create(
      name: "REGRET",
      description: "Hard work rarely pays off.",
     price: 89.00,
     year: 2018,
     vintage: true,
     img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )

    @poster2 = Poster.create(
      name: "FAILURE",
      description: "The key to success is knowing when to give up.",
      price: 72.50,
      year: 2020,
      vintage: false,
      img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )

    @poster3= Poster.create(
      name: "DESPAIR",
     description: "Why try, when you can fail spectacularly?",
     price: 65.99,
      year: 2015,
      vintage: true,
      img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )

  end

  it "shows all posters" do
    
    
    get "/api/v1/posters"

    posters = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

  
    expect(posters[:data].count).to eq(3)

    expect(posters[:meta]).to be_present
		expect(posters[:meta][:count]).to eq(3)

    posters[:data].each do |poster| 

      expect(poster[:id].to_i).to be_an(Integer)

      expect(poster[:attributes]).to have_key(:name) 
      expect(poster[:attributes][:name]).to be_a(String)

      expect(poster[:attributes]).to have_key(:description) 
      expect(poster[:attributes][:description]).to be_a(String) 

      expect(poster[:attributes]).to have_key(:price) 
      expect(poster[:attributes][:price]).to be_a(Float)

      expect(poster[:attributes]).to have_key(:year) 
      expect(poster[:attributes][:year]).to be_a(Integer) 

      expect(poster[:attributes]).to have_key(:vintage) 
      expect(poster[:attributes][:vintage]).to be_in([true, false]) 

      expect(poster[:attributes]).to have_key(:img_url) 
      expect(poster[:attributes][:img_url]).to be_a(String) 
    end
  
  end


  it "shows posters by id" do

    get "/api/v1/posters/#{@poster1.id}"

    poster = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(poster[:data]).to have_key(:id) 
    expect(poster[:data][:id].to_i).to eq(@poster1.id)

    expect(poster[:data][:attributes]).to have_key(:name) 
    expect(poster[:data][:attributes][:name]).to eq(@poster1.name)

    expect(poster[:data][:attributes]).to have_key(:description) 
    expect(poster[:data][:attributes][:description]).to eq(@poster1.description) 

    expect(poster[:data][:attributes]).to have_key(:price) 
    expect(poster[:data][:attributes][:price]).to eq(@poster1.price)

    expect(poster[:data][:attributes]).to have_key(:year) 
    expect(poster[:data][:attributes][:year]).to eq(@poster1.year) 

    expect(poster[:data][:attributes]).to have_key(:vintage) 
    expect(poster[:data][:attributes][:vintage]).to eq(@poster1.vintage) 

    expect(poster[:data][:attributes]).to have_key(:img_url) 
    expect(poster[:data][:attributes][:img_url]).to eq(@poster1.img_url)
  end

  it "deletes posters by id" do

    delete "/api/v1/posters/#{@poster1.id}"

    expect(response).to have_http_status(:no_content)
    
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
    
    expect(response.code).to eq("201")
    expect(response).to be_successful

    expect(created_poster.name).to eq(poster_params[:name])
    expect(created_poster.description).to eq(poster_params[:description])
    expect(created_poster.price).to eq(poster_params[:price])
    expect(created_poster.year).to eq(poster_params[:year])
    expect(created_poster.vintage).to eq(poster_params[:vintage])
    expect(created_poster.img_url).to eq(poster_params[:img_url])
    
  end

  it "can update an existing poster" do
    id = Poster.create(
      name: "FAILURE",
      description: "The key to success is knowing when to give up.",
      price: 72.50,
      year: 2020,
      vintage: false,
      img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    ).id
  
    previous_name = Poster.last.name 
    poster_params = { name: "SUCCESS" } 
    headers = { "CONTENT_TYPE" => "application/json" }
  
    patch "/api/v1/posters/#{id}", headers: headers, params: JSON.generate({ poster: poster_params })
  
    poster = Poster.find_by(id: id) 
  
    expect(response).to be_successful 
    expect(poster.name).to_not eq(previous_name) 
    expect(poster.name).to eq("SUCCESS") 
  end

end