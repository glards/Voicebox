require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      email: "test@example.com",
      password: "foobar",
      password_confirmation: "foobar",
      phone: "+41791234567"
    }

    @attr2 = {
      email: "test2@example.com",
      password: "foobar",
      password_confirmation: "foobar",
      phone: "+41797654321"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  describe "email field" do
    it "should require an email" do
      user = User.new(@attr.merge(email: ""))
      user.should_not be_valid
    end

    it "should accept valid email" do
      emails = %w(user@example.com first.last@example.co.uk user+spam@mail.com)
      emails.each do |email|
        user = User.new(@attr.merge(email: email))
        user.should be_valid
      end
    end

    it "should reject invalid email" do
      emails = %w(user@host@host.com foo@bar. truc_at_bleh)
      emails.each do |email|
        user = User.new(@attr.merge(email: email))
        user.should_not be_valid
      end
    end

    it "should reject duplicate emails" do
      User.create!(@attr)
      user = User.new(@attr2.merge(email: @attr[:email]))
      user.should_not be_valid
    end

    it "should reject duplicate emails up to the case" do
      email_up = @attr[:email].upcase
      User.create!(@attr)
      user = User.new(@attr2.merge(email: email_up))
      user.should_not be_valid
    end
  end

  describe "password field" do
    it "should require a password" do
      user = User.new(@attr.merge(password: ""))
      user.should_not be_valid
    end

    it "should require a matching password confirmation" do
      user = User.new(@attr.merge(password_confirmation: "invalid"))
      user.should_not be_valid
    end

    it "should reject short passwords" do
      pwd = "a"*5
      user = User.new(@attr.merge(password: pwd))
      user.should_not be_valid
    end
  end

  describe "phone field" do
    it "should require a phone number" do
      user = User.new(@attr.merge(phone: ""))
      user.should_not be_valid
    end

    it "should allow twilio client number" do
      user = User.new(@attr.merge(phone: "client:Glards"))
      user.should be_valid
    end

    it "should reject an invalid phone number" do
      phones = ["asdbgasgg", "12345678", "+41 123 12 34"]
      phones.each do |phone|
        user = User.new(@attr.merge(phone: phone))
        user.should_not be_valid
      end
    end

    it "should reject duplicate phone numbers" do
      User.create!(@attr)
      user = User.new(@attr2.merge(phone: @attr[:phone]))
      user.should_not be_valid
    end

    it "should reject short numbers" do
      user = User.new(@attr.merge(phone: "+41123"))
      user.should_not be_valid
    end
  end
end
