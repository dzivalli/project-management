class CompaniesController < ApplicationController
  def index
    @companies = Company.every
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
    render layout: false
  end
  def create
    if Company.create(permitted(params))
      redirect_to companies_path
    else
      redirect_to companies_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
    company = Company.find(params[:id])
    if company.destroy
      redirect_to companies_path
    else

    end
  end

  private

  def permitted(params)
    params.require(:company).permit(:name, :email, :address, :phone,
                                    :website, :city)
  end
end