class PaymentsController < ApplicationController
  def index
    @payments = Payment.client_payments(client)
  end

  def new
    @title = 'Новый платеж'
    @payment = Payment.new
    @payment.payment_date = Time.now.strftime("%d-%m-%Y")
    @payment.amount = Invoice.find(params[:invoice_id]).amount_due
    @payment.generate_trans
    @payment_methods = PaymentMethod.all
    render layout: 'modal'
  end

  def create
    invoice = Invoice.client_invoices(client).find params[:invoice_id]
    payment = Payment.new payment_params.merge(invoice: invoice, company: invoice.company)
    store do
      payment.save
    end
  end

  def edit
    @title = 'Изменить счет'
    @payment_methods = PaymentMethod.all
    @payment = Payment.client_payments(client).find params[:id]
    render layout: 'modal'
  end

  def update
    payment = Payment.client_payments(client).find params[:id]
    renew do
      payment.update payment_params
    end
  end

  def show
    @payment = Payment.client_payments(client).find params[:id]
    @payments = Payment.client_payments(client)
  end

  def destroy
    payment = Payment.client_payments(client).find params[:id]
    if payment.destroy
      redirect_to :back, notice: 'Платеж удален успешно'
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:trans, :amount, :payment_date, :payment_method_id, :notes)
  end
end
