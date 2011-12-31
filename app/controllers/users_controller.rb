class UsersController < ApplicationController
  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcom to VoiceBox !"
      #TODO : Sign in user
      redirect_to root_path
    else
      @title = "Sign up"
      render :new
    end
  end

end
