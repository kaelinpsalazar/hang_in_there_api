class Api::V1::PostersController < ApplicationController

  def index
    posters = Poster.search(params)
    render json: PosterSerializer.new(posters, meta:{count: posters.count})
  end

  def show
    begin
      render json: PosterSerializer.new(Poster.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => exception
      render json: {
        errors: [
          {
            status: "404",
            message: exception.message
          }
        ]
      }, status: :not_found
    end
  end

  
  def create
    begin
      poster = Poster.create!(poster_params) 
      render json: PosterSerializer.new(poster), status: :created
    rescue ActiveRecord::RecordInvalid => error
      render json: {
        errors: [
          {
            "status": "422",
            "message": error.record.errors.full_messages.join(", ")
          }
        ]
      }, status: :unprocessable_entity 
    end
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