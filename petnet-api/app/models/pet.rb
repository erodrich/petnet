class Pet < ApplicationRecord
    has_one :post, dependent: :destroy
    
    validates_presence_of :name, :animal, :breed, :created_by
end
