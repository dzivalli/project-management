class PlansController < ApplicationController
  layout 'modal', only: [:new, :edit]

  def index
    @plans = Plan.all
  end

  def new
    @title = 'Новый тарифный план'
    @plan = Plan.new
  end

  def create
    plan = Plan.new plan_params
    store do
      plan.save
    end
  end

  def edit
    @title = 'Изменить тарифный план'
    @plan = Plan.find params[:id]
    render 'new'
  end

  def update
    plan = Plan.find params[:id]
    renew do
      plan.update plan_params
    end
  end

  def destroy
    plan = Plan.find params[:id]
    if plan.destroy
      redirect_to :back, notice: 'План успешно удален'
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :cost, :term)
  end
end
