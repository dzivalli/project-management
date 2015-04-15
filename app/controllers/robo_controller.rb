class RoboController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_client_plan!
  skip_before_action :authorize_resource

  before_action :find_invoice

  def result
    sum = params['OutSum'].to_i
    crc = params['SignatureValue']
    puts sum, crc
    puts (crc == @invoice.pay_hash['crc'])
    puts (sum == @invoice.pay_hash['out_summ'])
    if @invoice && crc == @invoice.pay_hash['crc'] && sum == @invoice.pay_hash['out_summ']
      @invoice.get_paid!
      client.update_plan!(invoice.plan) if @invoice.plan
      render layout: false, plain: "OK#{@invoice.id}"
    end
    not_found
  end

  def success
    if @invoice
      redirect_to invoice_path(invoice), notice: 'Счет успешно оплачен'
    end
    not_found
  end

  def failure
    if @invoice
      redirect_to invoice_path(invoice), alert: 'Счет не оплачен!'
    end
    not_found
  end

  private

  def find_invoice
    @invoice = Invoice.find_by(id: params['InvId'])
  end
end
