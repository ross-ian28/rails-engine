class Merchant < ApplicationRecord
  has_many :items

  def self.find_merchant(searched_name)
    where("name ILIKE ?", "%#{searched_name}%")
    .order(:name)
    .first
  end
end
