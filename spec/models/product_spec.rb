require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    
    it 'saves succesfully with all four fields' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: 'Test',
        price: 12.44,
        quantity: 4,
        category: @category
      )
      
      expect(@product.save).to be true
    end

    it 'throws error when name is nil' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: nil,
        price: 12.44,
        quantity: 4,
        category: @category
      )
      
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it 'throws error when price is nil' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: 'Test',
        price: nil,
        quantity: 4,
        category: @category
      )
      
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it 'throws error when quantity is nil' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: 'Test',
        price: 12.44,
        quantity: nil,
        category: @category
      )
      
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it 'throws error when category is nil' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: 'Test',
        price: 12.44,
        quantity: 4,
        category: nil
      )
      
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  
  end
end


