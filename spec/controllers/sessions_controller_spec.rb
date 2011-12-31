require 'spec_helper'

describe SessionsController do
  render_views

  before :each do
    @attr = { email: "user@example.com", phone: "+41790000000", password: "foobar", password_confirmation: "foobar" }
    @session = { email: @attr[:email], password: @attr[:password] }
    @invalid = { email: @attr[:email], password: "invalid" }
  end

  describe "GET 'new'" do
    it "should have the right title" do
      get :new
      response.should have_selector('title', content: 'Sign in')
    end
  end

  describe "GET 'create'" do
    describe 'success' do
      it "should sign in the user" do
        user = User.create!(@attr)
        post :create, session: @session 
        controller.current_user.should == user
        controller.should be_signed_in
      end

      it "should redirect to the root path on success" do
        User.create!(@attr)
        post :create, session: @session
        response.should redirect_to root_path
      end
    end

    describe 'failure' do
      it "should render the sign in form" do
        User.create!(@attr)
        post :create, session: @invalid
        response.should render_template(:new)
      end

      it "should display an error message" do
        User.create!(@attr)
        post :create, session: @invalid
        flash.key?(:error).should be_true
      end
    end 
  end

  describe "GET 'destroy'" do
    it "should sign out the user" do
      user = User.create!(@attr)
      controller.sign_in(user)
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to root_path
    end 
  end

end
