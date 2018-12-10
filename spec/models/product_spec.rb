require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { Category.new(name: 'test_category')}

  before :each do
    @product = Product.new(
      name: 'test_name',
      price_cents: 1,
      quantity: 1,
      category: category
    )
  end

  describe 'Validations' do
    it 'is valid if all attributes are set correctly' do
      expect(@product).to be_valid
    end

    it 'is invalid if name not set' do
      @product.name = nil
      expect(@product).not_to be_valid
    end

    it 'is invalid if price not set' do
      @product.price_cents = nil
      expect(@product).not_to be_valid
    end

    it 'is invalid if quantity not set' do
      @product.quantity = nil
      expect(@product).not_to be_valid
    end

    it 'is invalid if category not set' do
      @product.category = nil
      expect(@product).not_to be_valid
    end

  end
end
