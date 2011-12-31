require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector('title', content: "Sign up")
    end
  end

 describe "POST 'create'" do
   describe 'failure' do
     before :each do
       @attr = { email: "", phone: "", password: "", password_confirmation: "" }
     end

     it "should not create a user" do
       lambda do
         post :create, user: @attr
       end.should_not change(User, :count)
     end

     it "should have the right title" do
       post :create, user: @attr
       response.should have_selector('title', content: "Sign up")
     end

     it "should render the 'new' template" do
       post :create, user: @attr
       response.should render_template('new')
     end
   end
   
   describe "success" do
     before :each do
       @attr = { email: "test@example.com", phone: "+41790000000", password: "foobar", password_confirmation: "foobar" }
     end

     it "should create a user" do
       lambda do
         post :create, user: @attr
       end.should change(User, :count).by(1)
     end

     it "should redirect to the home page" do
       post :create, user: @attr
       response.should redirect_to root_path
     end

     it "should have a welcome message" do
       post :create, user: @attr
       flash.key?(:success).should be_true
     end

     it "should sign the user in" do
       post :create, user: @attr
       controller.should be_signed_in
     end
   end
 end
end
