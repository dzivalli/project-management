class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
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
    payment = Payment.new payment_params.merge(invoice_id: params[:invoice_id], company_id: current_user.company.id)
    store do
      payment.save
    end
  end

  def edit
    @title = 'Изменить счет'
    @payment_methods = PaymentMethod.all
    @payment = Payment.find params[:id]
    render layout: 'modal'
  end

  def update
    payment = Payment.find params[:id]
    renew do
      payment.update payment_params
    end
  end

  def show
    @payment = Payment.find params[:id]
    @payments = Payment.all
  end

  def destroy

  end

  private

  def payment_params
    params.require(:payment).permit(:trans, :amount, :payment_date, :payment_method_id, :notes)
  end
end
