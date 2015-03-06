class TeamController < ApplicationController
  include Projectable

  def index
    @project = project { includes(:users) }
  end

  def new
    @users = User.customer_users(client)
    render layout: 'modal'
  end

  def create
    team = User.customer_users(client).find users_params
    renew do
      project.users = team
    end
  end

  private

  def users_params
    ids = params.require(:team).permit(ids: [])[:ids]
    ids.reject { |id| id.empty? }
  end

end
