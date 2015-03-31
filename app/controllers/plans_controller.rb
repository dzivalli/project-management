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

  def choose
    @plans = Plan.paid
  end

  def generate
    plan = Plan.paid[params[:plan].to_i - 1]
    @invoice = Invoice.new company_id: current_user.company.id,
                           due_date: Time.now + 1.week,
                           status: 'черновик'
    @invoice.items << Item.from_plan!(plan)
    @invoice.generate_reference!
    if @invoice.save
      redirect_to @invoice, notice: 'Счет был успешно высталвен'
    else
      redirect_to choose_plans_path, alert: 'Произошла ошибка'
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :cost, :term)
  end
end
