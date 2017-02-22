require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
  end

  describe 'Relations' do
    it { should have_many(:startups).dependent(:destroy) }
  end
end
