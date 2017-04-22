require 'rails_helper'

RSpec.describe Pet, type: :model do
  # Association test
  # ensure Todo model has a 1:1 relationship with the Item model
  it { should have_one(:post).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:animal) }
  it { should validate_presence_of(:breed) }
  it { should validate_presence_of(:created_by) }
end
