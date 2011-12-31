class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]

    user = User.where(email: email).first
    if !user.nil? and user.authenticate(password) == user
      sign_in user
      redirect_to root_path
    else
      @title = "Sign in"
      flash.now[:error] = "Invalid email/password combination."
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
