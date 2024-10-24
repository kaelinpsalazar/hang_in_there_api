class Poster < ApplicationRecord

  def self.sort_posters(params)
    if params[:sort].present? && params[:order].present?
      Poster.order(created_at: :asc)
    end
  end

end