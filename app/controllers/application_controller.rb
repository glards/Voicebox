class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def authentication
    unless signed_in?
      flash[:error] = "You must be logged in to perform the action requested"
      redirect_to root_path
    end
  end

  def root_selection
    if signed_in?
      redirect_to messages_path
    end
  end
end
