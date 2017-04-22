class User < ApplicationRecord
  has_secure_password

  # Model associations
  has_many :pets, foreign_key: :created_by
  # Validations
  validates_presence_of :name, :email, :password_digest
end
