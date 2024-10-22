class Api::V1::PostersController < ApplicationController

  def index
    render json: Poster.all
  end


  def show
    poster = Poster.find(params[:id])
    render json: poster
  end
  
  def create
    render json: Poster.create(poster_params)
  end

  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)

  end

  def destroy
    poster = Poster.find(params[:id])
    poster.destroy
  end
end