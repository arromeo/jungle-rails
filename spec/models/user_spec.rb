require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(
      first_name: 'test',
      last_name: 'user',
      email: 'test@email.com',
      password: 'test_password',
      password_confirmation: 'test_password'
    )
  end

  describe 'Validations' do

    it 'is valid if all attributes are set correctly' do
      expect(@user).to be_valid
    end

    it 'is invalid if no first name' do
      @user.first_name = nil
      expect(@user).not_to be_valid
    end

    it 'is invalid if no last name' do
      @user.last_name = nil
      expect(@user).not_to be_valid
    end

    it 'is invalid if no email' do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it 'is invalid if no password' do
      @user.password = nil
      expect(@user).not_to be_valid
    end

    it 'is invalid if no password confirmation' do
      @user.password_confirmation = nil
      expect(@user).not_to be_valid
    end

    it 'is invalid if password and password confirmation do not match' do
      @user.password_confirmation = 'different_password'
      expect(@user).not_to be_valid
    end

    it 'is not valid if email exists in database' do
      User.create(
        first_name: 'test',
        last_name: 'user',
        email: 'test@email.com',
        password: 'test_password',
        password_confirmation: 'test_password'
      )

      @duplicate_user = User.new(
        first_name: 'test',
        last_name: 'user',
        email: 'test@email.com',
        password: 'test_password',
        password_confirmation: 'test_password'
      )

      expect(@duplicate_user).not_to be_valid
    end

  end

end
