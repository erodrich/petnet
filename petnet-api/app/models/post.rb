class Post < ApplicationRecord
  belongs_to :pet
  
  validates_presence_of :title, :content
  scope :active, -> (active) {where active: true }
  scope :animal, -> (animal) { where("pets.animal = ?", animal) }
  #scope :animal, joins(:post => :pet).where("pets.animal = ?", animal)

  
end
