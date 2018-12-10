require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(
      first_name: 'test',
      last_name: 'name',
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

    it 'is invalid if password less than 6 characters' do
      @user.password = 'test'
      @user.password_confirmation = 'test'
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
        last_name: 'name',
        email: 'test@email.com',
        password: 'test_password',
        password_confirmation: 'test_password'
      )

      @duplicate_user = User.new(
        first_name: 'test',
        last_name: 'name',
        email: 'test@email.com',
        password: 'test_password',
        password_confirmation: 'test_password'
      )

      expect(@duplicate_user).not_to be_valid
    end

    it 'is not valid if email is duplicate but typed with different case' do
      User.create(
        first_name: 'test',
        last_name: 'name',
        email: 'test@email.com',
        password: 'test_password',
        password_confirmation: 'test_password'
      )

      @duplicate_user = User.new(
        first_name: 'test',
        last_name: 'name',
        email: 'TEST@email.com',
        password: 'test_password',
        password_confirmation: 'test_password'
      )

      expect(@duplicate_user).not_to be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it 'returns user instance when login successful' do
      user = User.authenticate_with_credentials('null_user', 'password')
      expect(user).to be nil
    end

    it 'returns nil when login unsuccessful' do
      User.create(
        first_name: 'test',
        last_name: 'name',
        email: 'test@email.com',
        password: 'test_password',
        password_confirmation: 'test_password'
      )

      user = User.authenticate_with_credentials('test@email.com', 'test_password')
      expect(user).not_to be nil
    end

    it 'successfully authenticates if email starts or ends with whitespace' do
      User.create(
        first_name: 'test',
        last_name: 'name',
        email: 'test@email.com',
        password: 'test_password',
        password_confirmation: 'test_password'
      )

      user = User.authenticate_with_credentials('  test@email.com', 'test_password')
      expect(user).not_to be nil
    end

    it 'successfully authenticates if email is correct but wrong case' do
      User.create(
        first_name: 'test',
        last_name: 'name',
        email: 'test@email.com',
        password: 'test_password',
        password_confirmation: 'test_password'
      )

      user = User.authenticate_with_credentials('  TEST@email.com', 'test_password')
      expect(user).not_to be nil
    end

  end

end
