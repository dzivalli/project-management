class TeamController < ApplicationController
  include Projectable

  def index
    @project = find_project { includes(:users) }
  end

  def new
    @project = find_project
    @users = User.customer_users(client)
  end

  def create
    team = User.customer_users(client).find users_params
    renew do
      find_project.users = team
    end
  end

  private

  def users_params
    ids = params.require(:team).permit(ids: [])[:ids]
    ids.reject { |id| id.empty? }
  end

end
