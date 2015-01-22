class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    if User.create(permitted(params))
      redirect_to users_path
    else
      redirect_to users_path
    end
  end

  def update
    
  end

  def destroy

  end

  private

  def permitted(params)
    params.permit(:full_name, :username, :email, :phone, :company,
                  :password, :password_confirmation)
  end
end
