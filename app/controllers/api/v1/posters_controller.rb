class Api::V1::PostersController < ApplicationController

  def index
    posters = Poster.all
    render json: PosterSerializer.new(posters, meta:{count: posters.count})
  end

  def show
    render json: PosterSerializer.new(Poster.find(params[:id]))
  end
  
  def create
    render json: PosterSerializer.new(Poster.create(poster_params))
  end

  def update 
    render json: PosterSerializer.new(Poster.update(params[:id], poster_params))
  end
 
  def destroy
    poster = Poster.find(params[:id])
    poster.destroy
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)

  end
end