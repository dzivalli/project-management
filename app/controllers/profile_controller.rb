class ProfileController < ApplicationController
  def index
    @user = current_user
  end

  def update
    renew do
      current_user.avatar.update(file: user_params[:avatar]) if user_params.key?(:avatar)
      current_user.update user_params.except(:avatar)
    end
  end

  private

  def user_params
    permitted = params.require(:user).permit(:full_name,
                                 :phone,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :avatar)
    if permitted[:password].blank? || permitted[:password_confirmation].blank?
      permitted.delete(:password)
      permitted.delete(:password_confirmation)
    end
    permitted
  end


end
