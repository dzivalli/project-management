class SettingsController < ApplicationController
  def general
    @company = Company.default
  end

  def email
  end

  def update
    if params.has_key? :company
       if Company.default.first.update(permitted(params, :company))
         redirect_to settings_general_path, notice: 'Данные успешно обновлены'
       else
         redirect_to settings_general_path, alert: 'Произошла ошибка, попробуйте еще раз'
       end
    end
  end

  private

  def permitted(params, element)
    params.require(element).permit(:name, :email, :address, :phone,
                                   :website, :city)
  end
end
