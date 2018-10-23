class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :group
  belongs_to :source
  belongs_to :store
  belongs_to :wallet

  def parent_category_id
    category.parent.nil? ? category_id : category.parent.id
  end

  def store_name
    store.name
  end

  def category_name
    category.name
  end

  def parent_category_name
    category.parent.nil? ? category_name : category.parent.name
  end
end
