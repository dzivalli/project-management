class HomeController < ApplicationController
  def index
    @projects = Project.for_user(current_user)
  end
end
