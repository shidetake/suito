class Category < ApplicationRecord
  acts_as_tree

  has_one :transactions
end
