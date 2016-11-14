require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'will require password and password confirmation to match' do
      @user = User.create(first_name: "Matthew", last_name: "Markic", email: "matt@matt.com", password: "matt", password_confirmation: "lsdkjfslkj")
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'will require both password fields to be filled if neither are filled' do
      @user = User.create(first_name: "Matthew", last_name: "Markic", email: "matt@matt.com", password: nil, password_confirmation: nil)
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'will require the password confirmation field to be filled if only the password field is filled' do
      @user = User.create(first_name: "Matt", last_name: "Mark", email: "matt@mark.com", password: 'mark', password_confirmation: nil)
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'will require the password field to be filled if only the password confirmation field is filled' do
      @user = User.create(first_name: "Mark", last_name: "Matt", email: "mark@matt.com", password: nil, password_confirmation: 'matt')
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'will require emails to be unique and not case sensitive' do
      @user1 = User.create(first_name: "Matthew", last_name: "Markic", email: "matt@matt.com", password: "matt", password_confirmation: "matt")
      @user2 = User.create(first_name: "Matthew", last_name: "Markic", email: "MaTt@MaTt.CoM", password: "matt", password_confirmation: "matt")
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'will require an email' do
      @user = User.create(first_name: "Matthew", last_name: "Markic", email: nil, password: "matt", password_confirmation: "matt")
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'will require a first name' do
      @user = User.create(first_name: nil, last_name: "Markic", email: "matt@matt.com", password: "matt", password_confirmation: "matt")
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'will require a last name' do
      @user = User.create(first_name: "Matt", last_name: nil, email: "matt@matt.com", password: "matt", password_confirmation: "matt")
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'will require a password be longer than 3 characters' do
      @user = User.create(first_name: "Matt", last_name: "Markic", email: "matt@matt.com", password: "mat", password_confirmation: "mat")
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'will find users despite white spaces around the email' do
      @user1 = User.create(first_name: "Matt", last_name: "Markic", email: "matt@matt.com", password: "matt", password_confirmation: "matt")
      @user2 = User.authenticate_with_credentials("   matt@matt.com   ", "matt")
      expect(@user1).to eq(@user2)
    end

    it 'will find users despite capitals within the email' do
      @user1 = User.create(first_name: "Matt", last_name: "Markic", email: "matt@matt.com", password: "matt", password_confirmation: "matt")
      @user2 = User.authenticate_with_credentials("MaTt@MaTt.CoM", "matt")
      expect(@user1).to eq(@user2)
    end
  end
end
