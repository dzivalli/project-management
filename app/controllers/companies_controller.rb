class CompaniesController < ApplicationController
  def index
    @companies = Company.every
  end

  def show
    @company = Company.includes(:users, :projects).find(params[:id])
  end

  def new
    @company = Company.new
    @title = 'Новая компания'
    render layout: 'modal'
  end

  def create
    company = Company.new company_params
    store do
      company.save
    end
  end

  def edit
    @company = Company.find params[:id]
    @title = 'Изменить данные'
    render 'new', layout: 'modal'
  end

  def update
    company = Company.find params[:id]
    renew do
      company.update company_params
    end
  end

  def destroy
    company = Company.find(params[:id])
    if company.destroy
      redirect_to companies_path, notice: 'Компания была успешно удалена'
    else

    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :email, :address, :phone,
                                    :website, :city)
  end
end
