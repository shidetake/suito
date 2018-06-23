class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :group
  belongs_to :source
  belongs_to :store
  belongs_to :wallet
end
