class PagesController < ApplicationController
  def home
    @title = 'home'
  end

  def search
    @title = 'search shows'
  end
end
