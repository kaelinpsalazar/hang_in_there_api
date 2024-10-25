class Api::V1::PostersController < ApplicationController

  def index
    posters = Poster.search(params)
    render json: PosterSerializer.new(posters, meta:{count: posters.count})
  end

  def show
    render json: PosterSerializer.new(Poster.find(params[:id]))
  end
  
  def create
    render json: PosterSerializer.new(Poster.create(poster_params))
  end

  def update
    poster = Poster.find(params[:id])
    if poster.update(poster_params)
      render json: PosterSerializer.new(poster), status: :ok
    end
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