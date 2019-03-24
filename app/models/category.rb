class Category < ApplicationRecord
  acts_as_tree

  has_one :transactions

  def self.genre(parent_id: nil, parent_name: nil)
    if parent_id.present?
      Category.where(parent_id: parent_id)
    elsif parent_name.present?
      Category.where(parent_id: Category.where(name: parent_name).ids)
    else
      # 引数がない場合は先頭のgenreを返す
      Category.where(parent_id: Category.where(parent: nil).first.id)
    end
  end
end
