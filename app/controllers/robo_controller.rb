class RoboController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_client_plan!
  skip_before_action :authorize_resource

  before_action :find_invoice

  def result
    if @invoice && @invoice.check_params?(params)
      @invoice.get_paid!(params['OutSum'])
      client.update_plan!(invoice.plan) if @invoice.plan
      render layout: false, plain: "OK#{@invoice.id}"
    end
  end

  def success
    if @invoice
      redirect_to invoice_path(invoice), notice: 'Счет успешно оплачен'
    end
  end

  def failure
    if @invoice
      redirect_to invoice_path(invoice), alert: 'Счет не оплачен!'
    end
  end

  private

  def find_invoice
    @invoice = Invoice.find_by(id: params['InvId'])
  end
end
