class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_items(searched_name)
    where("name ILIKE ?", "%#{searched_name}%")
  end
end
