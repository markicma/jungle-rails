require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'will contain an id when saved' do
      @category = Category.create(name: "Sports")
      @product = @category.products.create(name: "Basketball Shoes", quantity: 50, price: 100.00)

      expect(@product.id).to be_present
    end

    it 'will require a price when created' do
      @category = Category.create(name: "Sports")
      @product = @category.products.create(name: nil, quantity: 50, price: 100.00)

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'will require a price when created' do
      @category = Category.create(name: "Sports")
      @product = @category.products.create(name: "Basketball Shoes", quantity: 50, price: nil)

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'will require a quantity when created' do
      @category = Category.create(name: "Sports")
      @product = @category.products.create(name: "Basketball Shoes", quantity: nil, price: 100.00)

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'will require a category when created' do
      @category = Category.create(name: "Sports")
      @product = Product.create(name: "Basketball Shoes", quantity: 50, price: 100.00)

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
