class SettingsController < ApplicationController
  include Companible

  def general
    @company = client.main_company
  end

  def email

  end

  def update
    if params.has_key? :company
       renew do
         client.main_company.update(company_params)
       end
    end
  end
end
