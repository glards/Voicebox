class PagesController < ApplicationController
  before_filter :root_selection, only: :home

  def home
    @title = "Home"
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

  def help
    @title = "Help"
  end

end
