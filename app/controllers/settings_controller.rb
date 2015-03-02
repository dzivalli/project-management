class SettingsController < ApplicationController
  def general
    @company = client.main_company
  end

  def email
  end

  def update
    if params.has_key? :company
       renew do
         client.main_company.update(permitted(params, :company))
       end
    end
  end

  private

  def permitted(params, element)
    params.require(element).permit(:name, :email, :address, :phone,
                                   :website, :city)
  end
end
