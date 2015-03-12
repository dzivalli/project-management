module Companible
  extend ActiveSupport::Concern

  private

  def company_params
    params.require(:company).permit(:name, :email, :address, :phone,
                                    :website, :city, :inn, :kpp, :bik,
                                    :bank_title, :schet, :kor_schet)
  end
end