class CategoriesController < ApplicationController
  def index
    render json: Category.where(parent_id: params['parent_id'])
  end
end
