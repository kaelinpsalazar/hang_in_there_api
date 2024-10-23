class Api::V1::PostersController < ApplicationController

  def index
    render json: Poster.all
  end


  def show
    poster = Poster.find(params[:id])
    render json: poster

  def create
    render json: Poster.create(poster_params)
  end
  def update 
    render json:Poster.update(params[:id], poster_params)
  end
  private
  
  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)

  end

end