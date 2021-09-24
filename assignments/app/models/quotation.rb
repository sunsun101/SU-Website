class Quotation < ApplicationRecord
  validates :author_name, presence: true
  validates :category, presence: true
  validates :quote, presence: true
  attr_accessor :newcategory

  def self.search(search)
    if search
      where('author_name ILIKE ? OR quote ILIKE ?', '%' + search + '%',
            '%' + search + '%')
    else
      all
    end
  end
end
