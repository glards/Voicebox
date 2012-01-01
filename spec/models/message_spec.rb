require 'spec_helper'

describe Message do

  before :each do
    @attr = {
      callsid: "12345",
      from: "+411231212",
      received: DateTime.now,
      url: "http://localhost/"
    }
  end

  it "should create a new instance" do
    Message.create!(@attr)
  end

end
