require 'spec_helper'

describe MessagesController do
  render_views

  describe "GET 'index'" do
    describe "user not logged in" do
      it "should redirect to the homepage" do
        get :index
        response.should redirect_to(root_path)
      end

      it "should have a flash error" do
        get :index
        flash.key?(:error).should be_true
      end
    end

    describe "user logged in" do
      before :each do
        @user = Factory(:user)
        controller.sign_in(@user)
      end

      it "should have the right title" do
        get :index
        response.should have_selector('title', content: 'Your messages')
      end

      describe "without any messages" do
        it "should display the empty message" do
          get :index
          response.should have_selector('p', content: 'You have no messages')
        end
      end

      describe "with messages" do
        before :each do
          @message = Factory(:message, user: @user)
          @message2 = Factory(:second_message, user: @user)
        end

        it "should display the messages" do
          get :index
          response.should have_selector('h2', content: '1.')
          response.should have_selector('h2', content: '2.') 
        end

        it "should allow the messages to be deleted" do
          get :index
          response.should have_selector('a', href: message_path(@message))
        end

        it "should include the audio" do
          get :index
          response.should have_selector('audio')
        end
      end
    end
  end

  describe "DELETE 'destroy'" do

    before :each do
        @user = Factory(:user)
        @message = Factory(:message, user: @user)
    end

    describe "user logged in" do
      before :each do
        controller.sign_in(@user)
      end

      it "should delete a message" do
        lambda do
          delete :destroy, id: @message
        end.should change(@user.messages, :count).by(-1)
      end

      it "should redirect to the index" do
        delete :destroy, id: @message
        response.should redirect_to(messages_path)
      end
    end

    describe "user not logged in" do
      it "should not delete a message" do
        lambda do
          delete :destroy, id: @message
        end.should_not change(@user.messages, :count)
      end
    end
  end
end
