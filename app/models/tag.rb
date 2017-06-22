class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings # Allows to access directly from tags to articles
end
