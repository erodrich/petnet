class Post < ApplicationRecord
  belongs_to :pet
  
  validates_presence_of :title, :content
end
