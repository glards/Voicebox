class RecordingController < ApplicationController
  respond_to :xml

  def reply
    phone = params[:From]

    @valid = User.where(phone: phone).exists?
  end

  def callback
    phone = params[:From]
    callsid = params[:CallSid]
    url = params[:RecordingUrl]
    account = params[:AccountSid]

    user = User.where(phone: phone).first

    if !user.nil? and account == TWILIO_ACCOUNT_GUID
      user.messages.create(callsid: callsid, from: phone, received: DateTime.now, url: url)
    end

    render nothing: true, status: 200
  end
end
