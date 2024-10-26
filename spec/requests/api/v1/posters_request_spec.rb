require 'rails_helper'

describe "api" do
  before(:each) do
    Poster.destroy_all

    @poster1 = Poster.create(
      name: "REGRET",
      description: "Hard work rarely pays off.",
     price: 89.00,
     year: 2018,
     vintage: true,
     img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )


    @poster2= Poster.create(
      name: "DESPAIR",
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

  it "shows all posters" do
    
    
    get "/api/v1/posters"

    posters = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    # binding.pry

  
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
  
  it "can create a new poster" do

    new_poster_params =
    { name: "luffy",
      description: "Pirate King",
      price: 100.00,
      year: 1995,
      vintage: true,
      img_url: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.thegreatblight.com%2Fmajor-character%2Frand-althor&psig=AOvVaw2mEU7gb_WgjxRqQ1-B-xSl&ust=1725573628841000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNjr-eqkqogDFQAAAAAdAAAAABAE"

    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/posters", headers: headers, params: JSON.generate(poster: new_poster_params) 

    created_poster = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful 

    expect(created_poster[:data][:attributes][:name]).to eq(new_poster_params[:name])
    expect(created_poster[:data][:attributes][:description]).to eq(new_poster_params[:description])
    expect(created_poster[:data][:attributes][:price]).to eq(new_poster_params[:price])
    expect(created_poster[:data][:attributes][:year]).to eq(new_poster_params[:year])
    expect(created_poster[:data][:attributes][:vintage]).to eq(new_poster_params[:vintage])
    expect(created_poster[:data][:attributes][:img_url]).to eq(new_poster_params[:img_url])
  end
  
  
  it "can update an existing poster" do
    poster = Poster.create(
        name: "WOOOOOOO",
        description: "SO MUCH FUN",
        price: 72.50,
        year: 2020,
        vintage: false,
        img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
      )
    
      previous_name = poster.name 
      poster_params = { name: "SUCCESS" } 
      headers = { "CONTENT_TYPE" => "application/json" }
    
      patch "/api/v1/posters/#{poster.id}", headers: headers, params: JSON.generate({ poster: poster_params })

      
    
      changed_poster = JSON.parse(response.body, symbolize_names: true) 
    
      expect(response).to be_successful 
      expect(changed_poster[:data][:attributes][:name]).to_not eq(previous_name) 
      expect(changed_poster[:data][:attributes][:name]).to eq("SUCCESS") 
    end
    
    it "deletes posters by id" do
  
      delete "/api/v1/posters/#{@poster1.id}"
  
      expect(response).to have_http_status(:no_content)
      expect { Poster.find(@poster1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      
    end
  end