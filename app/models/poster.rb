class Poster < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :year, presence: true, numericality: {only_integer: true}
  validates :price, presence: true, numericality: {only_float: true}
  validates :vintage, presence: true

  def self.search(params)
    posters = Poster.all
    if params[:sort].present?
      if params[:sort] == 'asc'
        posters = posters.order(created_at: :asc)
      elsif params[:sort] == 'desc'
        posters= posters.order(created_at: :desc)
      end
    end
    if params[:min_price].present?
      posters = posters.where('price >= ?',params[:min_price].to_f)
    end

    if params[:max_price].present?
      posters = posters.where('price <= ?',params[:max_price].to_f)
    end

    if params[:name].present?
      posters = posters.where("name ILIKE ?", "%#{params[:name]}%")
    end
    
   return posters
  end



end