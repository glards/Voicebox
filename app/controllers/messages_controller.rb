class MessagesController < ApplicationController
  before_filter :authentication

  def index
    @title = "Your messages"
    @messages = current_user.messages
  end

  def destroy
    id = params[:id]
    message = current_user.messages.find(id)
    message.remove
    redirect_to messages_path
  end
end
