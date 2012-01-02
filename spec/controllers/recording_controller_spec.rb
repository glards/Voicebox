require 'spec_helper'

describe RecordingController do
  render_views

  describe "GET /reply" do
    it "should record a call from a known user" do
      user = Factory(:user)
      get :reply, format: :xml, From: user.phone
      response.should have_xpath('//record')
    end

    it "should hangup when a user is unknown" do
      get :reply, format: :xml, From: "+411231212"
      response.should have_xpath('//reject')
    end
  end

  describe "GET /callback" do
    it "should save the message for a known user" do
      user = Factory(:user)
      lambda do
        get :callback,
          AccountSid: TWILIO_ACCOUNT_GUID,
          From: user.phone,
          CallSid: "1234",
          RecordingUrl: "http://localhost/"
      end.should change(user.messages, :count).by(1)
      user.messages.first.callsid.should == "1234"
      response.should be_success
    end

    it "should not save the message for an unknown user" do
      lambda do
        get :callback,
          AccountSid: TWILIO_ACCOUNT_GUID,
          From: "+411231212",
          CallSid: "1234",
          RecordingUrl: "http://localhost/"
      end.should_not change(Message, :count)
      response.should be_success
    end
  end
end
