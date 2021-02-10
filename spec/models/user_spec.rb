require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # # validation tests/examples here
    # before do

    # end

    
    it 'saves succesfully with all three fields' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'secret',
        password_confirmation: 'secret'
      )
      
      expect(@user.save).to be true
    end

    it 'throws error when first_name is nil' do
      @user = User.new(
        first_name: nil,
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'secret',
        password_confirmation: 'secret'
      )
      
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it 'throws error when last_name is nil' do
      @user = User.new(
        first_name: 'Test',
        last_name: nil,
        email: 'testtykitty@hotmail.com',
        password: 'secret',
        password_confirmation: 'secret'
      )
      
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'throws error when email is nil' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: nil,
        password: 'secret',
        password_confirmation: 'secret'

      )
      
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'throws error when password is nil' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: nil,
        password_confirmation: nil
      )
      
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'throws error when passwords do not match' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'something',
        password_confirmation: 'different'
      )
      
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'throws error when email has been taken' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @replica = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'something',
        password_confirmation: 'something'
      )

      expect(@user.save).to be true
      expect(@replica.save).to be false
      expect(@replica.errors.full_messages).to include "Email has already been taken"
    end

    it 'throws error when password is too short' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'some',
        password_confirmation: 'some'
      )

      
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 5 characters)"
    end
    
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'returned user matches user info' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user.save
      user_returned = User.authenticate_with_credentials('testtykitty@hotmail.com', 'something')
      expect(user_returned[:first_name]).to eq('Test') 
      expect(user_returned[:last_name]).to eq('Testington')

    end

    it 'should return nil if user email is incorrect' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user.save
      user_returned = User.authenticate_with_credentials('testykity@hotmail.com', 'something')
      expect(user_returned).to be nil

    end

    it 'should return nil if user password is incorrect' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user.save
      user_returned = User.authenticate_with_credentials('testtykitty@hotmail.com', 'somthing')
      expect(user_returned).to be nil

    end

    it 'should still be able to login with extra spacing around email' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user.save
      user_returned = User.authenticate_with_credentials('  testtykitty@hotmail.com ', 'something')
      expect(user_returned[:first_name]).to eq('Test') 
      expect(user_returned[:last_name]).to eq('Testington')
    end

    it 'should still be able to login without case sensitivity' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Testington',
        email: 'testtykitty@hotmail.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user.save
      user_returned = User.authenticate_with_credentials('TesttykITty@hotmail.com', 'something')
      expect(user_returned[:first_name]).to eq('Test') 
      expect(user_returned[:last_name]).to eq('Testington')
    end
  end
end
