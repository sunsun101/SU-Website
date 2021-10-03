class Quotation < ApplicationRecord
  validates :author_name, presence: true
  validates :category, presence: true
  validates :quote, presence: true
  attr_accessor :newcategory
end
