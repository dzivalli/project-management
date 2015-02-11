class HomeController < ApplicationController
  def index
    @projects = Project.for_user(current_user)
    @versions = PaperTrail::Version.last(10)
  end
end
